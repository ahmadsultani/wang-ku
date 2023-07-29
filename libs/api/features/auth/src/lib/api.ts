import { sendResult } from '@wang-ku/api/error-handling';
import { jwt, JwtOptions } from '@wang-ku/api/plugins';
import { addErrorSchemas, Auth, AuthSchema } from '@wang-ku/shared/schema';
import { FastifyPluginAsync } from 'fastify';
import fp from 'fastify-plugin';

import * as data from './data';

const authRoute: FastifyPluginAsync<JwtOptions> = async function (
  fastify,
  opts
): Promise<void> {
  fastify.register(jwt, opts);

  fastify.post<{
    Body: Auth['sign_up']['body'];
    Reply: Auth['sign_up']['response'];
  }>(
    `${opts.prefix}${AuthSchema.sign_up.path}`,
    {
      schema: {
        tags: ['auth'],
        description: 'User sign up',
        summary: 'User sign up',
        security: [],
        body: AuthSchema.sign_up.body,
        response: addErrorSchemas({ 201: AuthSchema.sign_up.response }),
      },
    },
    async function (request, reply) {
      const result = await data.signUp(fastify.db, request.body);
      return sendResult(result, reply, 201);
    }
  );
};

export const authPlugin = fp(authRoute, {
  fastify: '4.x',
  name: 'wang-ku-auth',
});
