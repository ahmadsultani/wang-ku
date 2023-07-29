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

  it('should be able to register and login', async () => {
    const insertUser = T.randomUser();

    const signUpResponse = await app.inject({
      method: 'POST',
      url: AUTH_PATH + SS.sign_up.path,
      payload: insertUser,
    });
    expect(signUpResponse.statusCode).toBe(201);
    expect(signUpResponse.json().data.email).toBe(insertUser.email);

    const signInResponse = await app.inject({
      method: 'POST',
      url: AUTH_PATH + SS.sign_in.path,
      payload: {
        email: insertUser.email,
        password: insertUser.password,
      },
    });
    expect(signInResponse.statusCode).toBe(200);
    expect(signInResponse.json().data).toMatchObject({
      token: expect.any(String),
      user: {
        id: expect.any(String),
        name: insertUser.name,
        email: insertUser.email,
      },
    });

    await db
      .deleteFrom('users')
      .where('id', '=', signInResponse.json().data.user.id)
      .executeTakeFirstOrThrow();
  });
});
