import jwtPlugin, { FastifyJWTOptions } from '@fastify/jwt';
import { AppError } from '@wang-ku/api/error-handling';
import { FastifyPluginAsync } from 'fastify';
import fp from 'fastify-plugin';
import { ReasonPhrases, StatusCodes } from 'http-status-codes';
export { JWT } from '@fastify/jwt';

export type Payload = {
  id: string;
  email: string;
  name: string;
};

export type User = {
  id: string | undefined;
  email: string | undefined;
  name: string | undefined;
};

declare module '@fastify/jwt' {
  interface FastifyJWT {
    payload: Payload;
    user: User;
  }
}

export type JwtOptions = FastifyJWTOptions & {
  prefix: string;
};

export const jwt: FastifyPluginAsync<JwtOptions> = fp<JwtOptions>(
  async (fastify, opts) => {
    fastify.register(jwtPlugin, opts).addHook('onRequest', async (request) => {
      try {
        await request.jwtVerify();
      } catch (err) {
        request.user = {
          id: undefined,
          email: undefined,
          name: undefined,
        };
      }
    });
  }
);

export const protect: FastifyPluginAsync = fp(async (fastify, _) => {
  fastify.addHook('onRequest', async (request, reply) => {
    const isJwtVerified =
      request.user !== undefined &&
      request.user.id !== undefined &&
      request.user.email !== undefined &&
      request.user.name !== undefined;
    if (!isJwtVerified) {
      const appError: AppError<undefined> = {
        message: 'Failed to verify your authentication token!',
        reason: ReasonPhrases.UNAUTHORIZED,
      };
      return reply.code(StatusCodes.UNAUTHORIZED).send(appError);
    }
    const existUser = await fastify.db
      .selectFrom('users')
      .selectAll()
      .where('id', '=', `${request.user.id}`)
      .executeTakeFirst();
    if (!existUser) {
      const appError: AppError<undefined> = {
        message: 'Failed to verify your authentication token!',
        reason: ReasonPhrases.UNAUTHORIZED,
      };
      return reply.code(StatusCodes.UNAUTHORIZED).send(appError);
    }
    return;
  });
});
