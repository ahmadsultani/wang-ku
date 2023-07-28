import * as T from '@wang-ku/api/util/test';
import { AuthSchema as SS } from '@wang-ku/shared/schema';
import { FastifyInstance } from 'fastify';

import { authPlugin } from './api';

const AUTH_PATH = `/api/v1${SS.path}`;

describe('Authentication endpoints', () => {
  let app: FastifyInstance;
  const db = T.dbConnection();

  beforeAll(async () => {
    app = await T.buildApp([
      {
        path: AUTH_PATH,
        route: authPlugin,
      },
    ]);
  });

  afterAll(() => db.destroy());

  it('should be able to register', async () => {
    const insertUser = T.randomUser();

    const signUpResponse = await app.inject({
      method: 'POST',
      url: AUTH_PATH + SS.sign_up.path,
      payload: insertUser,
    });
    expect(signUpResponse.statusCode).toBe(201);
    expect(signUpResponse.json().data.email).toBe(insertUser.email);

    await db
      .deleteFrom('users')
      .where('email', '=', insertUser.email)
      .executeTakeFirstOrThrow();
  });
});
