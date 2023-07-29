import { Type } from '@sinclair/typebox';

import { DbSchema } from './database';
import { RecursiveStatic } from './generics';

export const BudgetRequestCRUDSchema = {
  path: '/budget-request',
  read: {
    response: Type.Object({
      data: Type.Object({
        name: DbSchema['users']['properties']['name'],
        lend_limit: DbSchema['businesses']['properties']['lend_limit']
      }),
    }),
  },
  readMany: {
    path: '/all',
    response: Type.Object({
      data: Type.Array(Type.Intersect([
        DbSchema['budget_requests'],
        Type.Object({
          business_name: DbSchema['businesses']['properties']['name']
        })
      ])),
    }),
  },
  create: {
    body: Type.Pick(DbSchema['budget_requests'], ['request_budget']),
    response: Type.Object({
      data: DbSchema['budget_requests'],
    }),
  },
};

export type BudgetRequestCRUD = RecursiveStatic<typeof BudgetRequestCRUDSchema>;
