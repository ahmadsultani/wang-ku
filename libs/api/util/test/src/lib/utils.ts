import * as DB from '@wang-ku/api/database';
import * as plugins from '@wang-ku/api/plugins';
import fastify, { FastifyInstance, FastifyPluginAsync } from 'fastify';
import { IncomingHttpHeaders } from 'http';
import { Kysely, PostgresDialect } from 'kysely';
import { Pool, types } from 'pg';

export async function buildApp(
  routes: {
    path: string;
    route: FastifyPluginAsync<any>;
  }[],
  isAuth = false
): Promise<FastifyInstance> {
  const app = await fastify({
    ajv: {
      customOptions: {
        strict: true,
        strictSchema: true,
        removeAdditional: 'all',
        coerceTypes: 'array',
        keywords: [
          {
            keyword: 'isFileSchema',
            compile: (_, parent) => {
              parent.type = 'file';
              delete parent.isFileSchema;
              return () => true;
            },
            errors: false,
          },
        ],
      },
    },
    exposeHeadRoutes: false,
  });

  // Plugins
  const config = {
    pool: new Pool({ connectionString: process.env['DATABASE_URL'] ?? '' }),
  };
  types.setTypeParser(20, Number);
  // Fix intermittent float failures, which are parsed as text.
  // Source: https://github.com/brianc/node-postgres/issues/811#issuecomment-488374261
  types.setTypeParser(1700, parseFloat);

  app.register(plugins.db, config);
  if (isAuth) {
    app.register(plugins.jwt, {
      prefix: '/api/v1/auth',
      secret: process.env['SECRET'] ?? '',
      sign: {
        expiresIn: '12h',
      },
      verify: {
        maxAge: '30d',
      },
    });
  }

  // Routes
  routes.forEach((r) => {
    const jwt = {
      secret: process.env['SECRET'] ?? '',
      sign: {
        expiresIn: '12h',
      },
      verify: {
        maxAge: '30d',
      },
    };
    app.register(r.route, {
      ...jwt,
      prefix: r.path,
      bucket: process.env['STORAGE_BUCKET'] ?? '',
    });
  });

  await app.ready();
  return app;
}

export type TestDb = Kysely<DB.Database>;
export function dbConnection(): TestDb {
  const connectionString = process.env.DATABASE_URL;
  const pgConfig = { pool: new Pool({ connectionString: connectionString }) };
  const db = new Kysely<DB.Database>({
    dialect: new PostgresDialect(pgConfig),
  });
  return db;
}

export async function login(
  app: FastifyInstance,
  email: string
): Promise<string> {
  const selectedUser = await app.db
    .selectFrom('users')
    .where('email', '=', email)
    .select(['id', 'email', 'name'])
    .executeTakeFirstOrThrow();

  const token = app.jwt.sign(
    {
      id: selectedUser.id,
      email: selectedUser.email,
      name: selectedUser.name ?? '',
    },
    { expiresIn: '12h' }
  );
  return token;
}

export function authorizationHeaders(
  token: string,
  args?: IncomingHttpHeaders
): { headers: IncomingHttpHeaders } {
  return {
    headers: {
      authorization: `Bearer ${token}`,
      ...args,
    },
  };
}
