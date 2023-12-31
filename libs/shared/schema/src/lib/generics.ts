import { Static, TSchema, Type } from '@sinclair/typebox';
import { Conditional } from '@sinclair/typebox/conditional';

export type RecursiveStatic<Schemas> = {
  [Key in keyof Schemas]: Schemas[Key] extends TSchema
    ? ExpandDeep<Static<Schemas[Key]>>
    : RecursiveStatic<Schemas[Key]>;
};

// Problem: https://github.com/microsoft/vscode/issues/94679
// Source: https://github.com/shian15810/type-expand
type ExpandDeep<T> = T extends object
  ? T extends infer O
    ? { [K in keyof O]: ExpandDeep<O[K]> }
    : never
  : T;

export const Nullable = <T extends TSchema>(schema: T) =>
  Type.Union([{ ...schema, nullable: true }, Type.Null()]);

export const NonNullable = <T extends TSchema>(schema: T) =>
  Conditional.Exclude(
    Type.Union([schema]),
    Type.Union([Type.Null(), Type.Undefined()])
  );
