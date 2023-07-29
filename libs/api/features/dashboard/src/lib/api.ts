import { sendResult } from '@wang-ku/api/error-handling';
import { protect } from '@wang-ku/api/plugins';
import {
  addErrorSchemas,
  Dashboard,
  DashboardSchema,
  securitySchema,
} from '@wang-ku/shared/schema';
import { FastifyPluginAsync } from 'fastify';

import * as data from './data';

export const dashboardPlugin: FastifyPluginAsync = async function (
  fastify
): Promise<void> {
  fastify.register(protect);

  fastify.get<{
    Reply: Dashboard['read']['response'];
  }>(
    `${DashboardSchema.path}`,
    {
      schema: {
        tags: ['dashboard', 'read'],
        description: 'Get dashboard data',
        summary: 'Get dashboard data',
        response: addErrorSchemas({ 200: DashboardSchema.read.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.read(fastify.db, request.user);
      return sendResult(result, reply, 200);
    }
  );
};
