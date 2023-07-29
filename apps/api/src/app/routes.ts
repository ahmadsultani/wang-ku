import { authPlugin } from '@wang-ku/api/features/auth';
import { budgetRequestPlugin } from '@wang-ku/api/features/budget-request';
import { businessPlugin } from '@wang-ku/api/features/business';
import { dashboardPlugin } from '@wang-ku/api/features/dashboard';
import { userPlugin } from '@wang-ku/api/features/user';
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

  // -----------------------------------------------------
  // User
  // -----------------------------------------------------
  app.register(userPlugin, {
    prefix: API_PREFIX,
  });

  // -----------------------------------------------------
  // Budget Request
  // -----------------------------------------------------
  app.register(budgetRequestPlugin, {
    prefix: API_PREFIX,
  });

  // -----------------------------------------------------
  // Dashboard
  // -----------------------------------------------------
  app.register(dashboardPlugin, {
    prefix: API_PREFIX,
  });
};
