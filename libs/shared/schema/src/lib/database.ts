import { Type } from '@sinclair/typebox';

import { Nullable, RecursiveStatic } from './generics';

// -----------------------------------------------------
// MASTER
// -----------------------------------------------------
const TimestampColumn = Type.Object({
  created_at: Type.Integer({ minimum: 0 }),
  updated_at: Type.Integer({ minimum: 0 }),
});

const GenderEnum = Type.Union([Type.Literal('male'), Type.Literal('female')]);
export const User = Type.Object({
  id: Type.String({ format: 'uuid' }),
  name: Type.String({ minLength: 1 }),
  email: Type.String({ format: 'email' }),
  password: Type.String({ minLength: 1 }),
  gender: GenderEnum,
  phone_number: Type.String({ minLength: 1 }),
  birth_date: Type.Integer({ minimum: 0 }),
  picture: Nullable(Type.String()),
});

export const DbSchema = {
  users: Type.Intersect([User, TimestampColumn]),
};

export type Db = RecursiveStatic<typeof DbSchema>;
