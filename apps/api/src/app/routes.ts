import { authPlugin } from '@wang-ku/api/features/auth';
import { businessPlugin } from '@wang-ku/api/features/business';
import * as SS from '@wang-ku/shared/schema';
import {
  FastifyError,
  FastifyPluginAsync,
  FastifyReply,
  FastifyRequest,
} from 'fastify';

import { environment } from '../environments/environment';

const API_PREFIX = '/api/v1';
export const appRoutes: FastifyPluginAsync = async (app) => {
  app.setErrorHandler(
    (error: FastifyError, _request: FastifyRequest, reply: FastifyReply) =>
      reply.status(error.statusCode ?? 500).send({
        message: error.message ?? 'Internal Server Error',
        error: error.message ?? 'Internal Server Error',
        statusCode: error.statusCode ?? 500,
      })
  );

  app.get('/', (_, reply) => {
    reply.send({
      message: 'WangKu API V1 is online.',
      time: new Date().getTime(),
    });
  });

  // -----------------------------------------------------
  // Auth
  // -----------------------------------------------------
  app.register(authPlugin, {
    prefix: API_PREFIX + SS.AuthSchema.path,
    secret: environment.secret,
    sign: {
      expiresIn: '10m',
    },
    verify: {
      maxAge: '30d',
    },
  });

  // -----------------------------------------------------
  // Business
  // -----------------------------------------------------
  app.register(businessPlugin, {
    prefix: API_PREFIX,
  });
};
