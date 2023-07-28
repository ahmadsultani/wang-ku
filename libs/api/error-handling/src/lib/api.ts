import { FastifyReply } from 'fastify';
import { StatusCodes } from 'http-status-codes';

import { AppError, AppResultWithData } from './results';

// fix FastifySchema doenst have tags, description, summary, attribute
declare module 'fastify' {
  interface FastifySchema {
    tags?: string[];
    description?: string;
    summary?: string;
    body?: unknown;
    querystring?: unknown;
    params?: unknown;
    headers?: unknown;
    response?: unknown;
  }
}

export function sendResult<T, E>(
  result: AppResultWithData<T, E>,
  reply: FastifyReply,
  okStatusCode = 200
): FastifyReply {
  if (!result.TAG) {
    return reply.code(okStatusCode).send(result._0);
  }
  return reply.code(parseStatusCode(result._0)).send(result._0);
}

function parseStatusCode<E>(error: AppError<E>): number {
  const reason = (error.reason ?? '').toLowerCase();
  const badRequestKeywords = [
    'invalid date',
    'invalid time',
    'invalid input syntax for type',
    'violates foreign key constraint',
    'violates check constraint',
    'received unexpected keys',
    'parse error',
    'date/time field value out of range',
    'error: syntax error at or near',
    'is too large',
    'is wrong',
  ];
  if (badRequestKeywords.some((kw) => reason.includes(kw))) {
    return StatusCodes.BAD_REQUEST;
  }
  if (reason.includes('column') && reason.includes('does not exist')) {
    return StatusCodes.BAD_REQUEST;
  }
  const forbiddenKeywords = ['tidak memiliki akses', 'forbidden'];
  if (forbiddenKeywords.some((kw) => reason.includes(kw))) {
    return StatusCodes.FORBIDDEN;
  }
  const conflictKeywords = ['duplicate key value violates unique constraint'];
  if (conflictKeywords.some((kw) => reason.includes(kw))) {
    return StatusCodes.CONFLICT;
  }
  const notFoundKeywords = ['no result', 'not found'];
  if (notFoundKeywords.some((kw) => reason.includes(kw))) {
    return StatusCodes.NOT_FOUND;
  }
  if (error.message === 'Gagal masuk!') {
    return StatusCodes.UNAUTHORIZED;
  }
  return StatusCodes.INTERNAL_SERVER_ERROR;
}
