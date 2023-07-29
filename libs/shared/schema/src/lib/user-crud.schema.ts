import { Type } from '@sinclair/typebox';

import { DbSchema } from './database';
import { RecursiveStatic } from './generics';

export const UserCRUDSchema = {
  path: '/users',
  profile: {
    path: '/profile',
    response: Type.Object({
      data: Type.Object({
        user: Type.Pick(DbSchema['users'], [
          'id',
          'name',
          'email',
          'phone_number',
          'birth_date',
        ]),
        business: Type.Union([DbSchema['businesses'], Type.Null()]),
      }),
    }),
  },
  verify: {
    path: '/verify',
    body: Type.Intersect([
      Type.Omit(DbSchema['users_verifications'], [
        'id',
        'user_id',
        'created_at',
        'updated_at',
      ]),
      Type.Object({
        picture: Type.Optional(
          DbSchema['users_verifications']['properties']['picture']
        ),
      }),
    ]),
    response: Type.Object({
      data: DbSchema['users_verifications'],
    }),
  },
};

export type UserCRUD = RecursiveStatic<typeof UserCRUDSchema>;
