import { sendResult } from '@wang-ku/api/error-handling';
import { protect } from '@wang-ku/api/plugins';
import {
  addErrorSchemas,
  securitySchema,
  UserCRUD,
  UserCRUDSchema,
} from '@wang-ku/shared/schema';
import { FastifyPluginAsync } from 'fastify';

import * as data from './data';

export const userPlugin: FastifyPluginAsync = async function (
  fastify
): Promise<void> {
  fastify.register(protect);

  fastify.get<{
    Reply: UserCRUD['profile']['response'];
  }>(
    `${UserCRUDSchema.path}${UserCRUDSchema.profile.path}`,
    {
      schema: {
        tags: ['users', 'profile'],
        description: 'Verify users data',
        summary: 'Verify users data',
        response: addErrorSchemas({ 200: UserCRUDSchema.profile.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.profile(fastify.db, request.user);
      return sendResult(result, reply, 200);
    }
  );

  fastify.post<{
    Body: UserCRUD['verify']['body'];
    Reply: UserCRUD['verify']['response'];
  }>(
    `${UserCRUDSchema.path}${UserCRUDSchema.verify.path}`,
    {
      schema: {
        tags: ['users', 'verify'],
        description: 'Verify users data',
        summary: 'Verify users data',
        body: UserCRUDSchema.verify.body,
        response: addErrorSchemas({ 201: UserCRUDSchema.verify.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.verify(fastify.db, request.body, request.user);
      return sendResult(result, reply, 201);
    }
  );
};
