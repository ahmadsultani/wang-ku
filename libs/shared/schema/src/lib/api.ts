import { Type } from '@sinclair/typebox';

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
