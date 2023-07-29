import { Type } from '@sinclair/typebox';

import { DbSchema, StatusEnum } from './database';
import { RecursiveStatic } from './generics';

export const DashboardSchema = {
  path: '/dashboard',
  read: {
    response: Type.Object({
      data: Type.Object({
        lended_total: Type.Number(),
        lend_limit: Type.Number(),
        monthly_spending: Type.Number(),
        monthly_income: Type.Number(),
        last_lend_status: StatusEnum,
        business: Type.Union([DbSchema['businesses'], Type.Null()]),
        user_verification: Type.Union([DbSchema['users_verifications'], Type.Null()]),
      }),
    }),
  },
};

export type Dashboard = RecursiveStatic<typeof DashboardSchema>;
