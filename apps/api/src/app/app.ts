import * as plugins from '@wang-ku/api/plugins';
import fastify from 'fastify';
import { Pool, types } from 'pg';

import { environment } from '../environments/environment';
import { appRoutes } from './routes';

export async function buildApp() {
  const app = await fastify({
    ajv: {
      customOptions: {
        strict: true,
        strictSchema: true,
        removeAdditional: 'all',
        coerceTypes: 'array',
      },
    },
    logger: environment.production
      ? true
      : {
          transport: {
            target: 'pino-pretty',
            options: {
              translateTime: 'HH:MM:ss Z',
              colorize: true,
              ignore: 'pid,hostname',
            },
          },
        },
  });

  async function closeGracefully(signal: string) {
    app.log.info(`*^!@4=> Received signal to terminate: ${signal}`);
    await app.close();
    process.exit();
  }

  process.on('SIGINT', closeGracefully);
  process.on('SIGTERM', closeGracefully);

  const config = {
    pool: new Pool({ connectionString: environment.databaseUrl }),
  };

  types.setTypeParser(20, Number);
  types.setTypeParser(1700, parseFloat);

  app.register(plugins.db, config);
  app.register(plugins.cors);
  if (environment.appEnv !== 'prod') {
    app.register(plugins.swagger);
  }

  app.get('/health', (_, reply) => {
    reply.send({
      message: 'WangKu API V1 is online.',
      time: new Date().getTime(),
    });
  });

  app.register(appRoutes);

  return app;
}
