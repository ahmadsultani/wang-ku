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

const CategoryEnum = Type.Union([
  Type.Literal('wholesale'),
  Type.Literal('material'),
  Type.Literal('manufacture'),
  Type.Literal('food_and_beverage'),
  Type.Literal('business_service'),
  Type.Literal('hardware'),
  Type.Literal('others'),
]);
export const Business = Type.Object({
  id: Type.String({ format: 'uuid' }),
  user_id: Type.String({ format: 'uuid' }),
  name: Type.String({ minLength: 1 }),
  category: CategoryEnum,
  npwp: Type.String({ minLength: 16, maxLength: 16 }),
  nib: Type.String({ minLength: 13, maxLength: 13 }),
  lend_limit: Nullable(Type.Number()),
  address: Type.String({ minLength: 1 }),
  phone_number: Nullable(Type.String()),
  monthly_spending: Nullable(Type.Number()),
  monthly_income: Nullable(Type.Number()),
});

export const DbSchema = {
  users: Type.Intersect([User, TimestampColumn]),
  businesses: Type.Intersect([Business, TimestampColumn]),
};

export type Db = RecursiveStatic<typeof DbSchema>;
