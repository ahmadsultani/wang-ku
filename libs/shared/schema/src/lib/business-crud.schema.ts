import { Type } from '@sinclair/typebox';

import { DbSchema } from './database';
import { RecursiveStatic } from './generics';

export const BusinessCRUDSchema = {
  path: '/business',
  create: {
    body: Type.Intersect([
Type.Omit(DbSchema['businesses'], ['id', 'user_id', 'created_at', 'updated_at']),
      Type.Object({
        lend_limit: Type.Optional(DbSchema['businesses']['properties']['lend_limit']),
        phone_number: Type.Optional(DbSchema['businesses']['properties']['phone_number']),
        monthly_spending: Type.Optional(DbSchema['businesses']['properties']['monthly_spending']),
        monthly_income: Type.Optional(DbSchema['businesses']['properties']['monthly_income']),
      })
    ]),
    response: Type.Object({
      data: Type.Intersect([
        DbSchema['businesses'],
        Type.Object({
          user_name: DbSchema['users']['properties']['name'],
          user_email: DbSchema['users']['properties']['email'],
          user_phone_number: DbSchema['users']['properties']['phone_number'],
        })
      ])
    }),
  },
};

export type BusinessCRUD = RecursiveStatic<typeof BusinessCRUDSchema>;
