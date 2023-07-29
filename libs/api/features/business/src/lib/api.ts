import { sendResult } from '@wang-ku/api/error-handling';
import { protect } from '@wang-ku/api/plugins';
import { addErrorSchemas, BusinessCRUD, BusinessCRUDSchema, securitySchema } from '@wang-ku/shared/schema';
import { FastifyPluginAsync } from 'fastify';

import * as data from './data';

export const businessPlugin: FastifyPluginAsync = async function (
  fastify
): Promise<void> {
  fastify.register(protect);


  fastify.post<{
    Body: BusinessCRUD['create']['body'];
    Reply: BusinessCRUD['create']['response'];
  }>(
    `${BusinessCRUDSchema.path}`,
    {
      schema: {
        tags: ['business', 'create'],
        description: 'Create a business',
        summary: 'Create a business',
        body: BusinessCRUDSchema.create.body,
        response: addErrorSchemas({ 201: BusinessCRUDSchema.create.response }),
        security: securitySchema
      },
    },
    async function (request, reply) {
      const result = await data.create(fastify.db, request.body, request.user);
      return sendResult(result, reply, 201);
    }
  );

};
