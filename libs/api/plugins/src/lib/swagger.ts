import swaggerPlugin, { FastifySwaggerOptions } from '@fastify/swagger';
import swaggerPluginUi from '@fastify/swagger-ui';
import { FastifyPluginAsync } from 'fastify';
import fp from 'fastify-plugin';

export const swagger: FastifyPluginAsync = fp<FastifySwaggerOptions>(
  async (fastify) => {
    await fastify.register(swaggerPlugin, {
      swagger: {
        info: {
          title: 'Wangku API Documentation',
          description: 'Wangku API Documentation',
          version: '1.0.0',
        },
        host:
          process.env.APP_ENV != 'dev'
            ? process.env.API_URL?.replace('https://', '')
            : '127.0.0.1:9000',
        schemes: process.env.APP_ENV != 'dev' ? ['https'] : ['http'],
        consumes: ['application/json'],
        produces: ['application/json'],
        definitions: {},
        securityDefinitions: {
          bearerAuth: {
            type: 'apiKey',
            name: 'Authorization',
            in: 'header',
          },
        },
        security: [
          {
            bearerAuth: [],
          },
        ],
      },
    });

    await fastify.register(swaggerPluginUi, {
      routePrefix: '/docs',
      initOAuth: {},
      uiConfig: {
        deepLinking: false,
        docExpansion: 'none',
        filter: true,
        displayRequestDuration: true,
      },
      staticCSP: true,
      transformStaticCSP: (header) => header,
    });
  }
);
