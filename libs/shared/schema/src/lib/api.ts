import { TSchema, Type } from '@sinclair/typebox';

import { AuthSchema } from './auth.schema';

// ---------------------------------------------------------------------------
// Errors
// ---------------------------------------------------------------------------
const ErrorSchema = Type.Object({
  message: Type.String(),
  reason: Type.Optional(Type.String()),
  data: Type.Optional(Type.Any()),
});

export function addErrorSchemas(responseSchema: object): object {
  return {
    ...responseSchema,
    400: ErrorSchema,
    500: ErrorSchema,
  };
}

function removeKey(obj: any) {
  delete obj['path'];
  for (const prop in obj) {
    delete obj[prop]['path'];
  }
  return obj;
}

type EndpointSchema = Record<string, TSchema>;
type PluginSchema = Record<string, EndpointSchema>;
export const ApiSchemas: Record<string, PluginSchema> = {
  auth: removeKey(AuthSchema),
};
