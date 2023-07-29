import { sendResult } from '@wang-ku/api/error-handling';
import { protect } from '@wang-ku/api/plugins';
import {
  addErrorSchemas,
  BudgetRequestCRUD,
  BudgetRequestCRUDSchema,
  securitySchema,
} from '@wang-ku/shared/schema';
import { FastifyPluginAsync } from 'fastify';

import * as data from './data';

export const budgetRequestPlugin: FastifyPluginAsync = async function (
  fastify
): Promise<void> {
  fastify.register(protect);

  fastify.get<{
    Reply: BudgetRequestCRUD['readMany']['response'];
  }>(
    `${BudgetRequestCRUDSchema.path}${BudgetRequestCRUDSchema.readMany.path}`,
    {
      schema: {
        tags: ['budget_request', 'readMany'],
        description: 'list all the requested budget',
        summary: 'list all the requested budget',
        response: addErrorSchemas({ 200: BudgetRequestCRUDSchema.readMany.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.readMany(fastify.db, request.user);
      return sendResult(result, reply, 200);
    }
  );

  fastify.get<{
    Reply: BudgetRequestCRUD['read']['response'];
  }>(
    `${BudgetRequestCRUDSchema.path}`,
    {
      schema: {
        tags: ['budget_request', 'read'],
        description: 'Get user data for loan',
        summary: 'Get user data for loan',
        response: addErrorSchemas({ 200: BudgetRequestCRUDSchema.read.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.read(fastify.db, request.user);
      return sendResult(result, reply, 200);
    }
  );

  fastify.post<{
    Body: BudgetRequestCRUD['create']['body'];
    Reply: BudgetRequestCRUD['create']['response'];
  }>(
    `${BudgetRequestCRUDSchema.path}`,
    {
      schema: {
        tags: ['budget_request', 'create'],
        description: 'Submit a loan request',
        summary: 'Submit a loan request',
        body: BudgetRequestCRUDSchema.create.body,
        response: addErrorSchemas({ 201: BudgetRequestCRUDSchema.create.response }),
        security: securitySchema,
      },
    },
    async function (request, reply) {
      const result = await data.create(fastify.db, request.body, request.user);
      return sendResult(result, reply, 201);
    }
  );
};
