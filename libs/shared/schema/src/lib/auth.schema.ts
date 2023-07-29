import { Type } from '@sinclair/typebox';

import { DbSchema } from './database';
import { RecursiveStatic } from './generics';

export const AuthSchema = {
  path: '/auth',
  sign_up: {
    path: '/sign-up',
    body: Type.Omit(DbSchema['users'], ['id', 'created_at', 'updated_at']),
    response: Type.Object({
      data: Type.Pick(DbSchema['users'], ['email']),
    }),
  },
  sign_in: {
    path: '/sign-in',
    body: Type.Pick(DbSchema['users'], ['email', 'password']),
    response: Type.Object({
      data: Type.Object({
        token: Type.String({ minLength: 1 }),
        user: Type.Pick(DbSchema['users'], ['id', 'email', 'name']),
      }),
    }),
  },
};

export type Auth = RecursiveStatic<typeof AuthSchema>;
