import { Users } from '@wang-ku/api/database';
import * as T from '@wang-ku/api/util/test';
import { BusinessCRUDSchema as SS } from '@wang-ku/shared/schema';
import { FastifyInstance } from 'fastify';

import { businessPlugin } from './api';

const BASE_PATH = `/api/v1`;
const BUSINESS_PATH = `/api/v1${SS.path}`;

describe('Business endpoints', () => {
  let app: FastifyInstance;
  const db = T.dbConnection();

  let user: Users['select'];
  let token: string;

  beforeAll(async () => {
    app = await T.buildApp([
      {
        path: BASE_PATH,
        route: businessPlugin,
      },
    ], true);

    user = await T.createRandomUser(db);
    token = await T.login(app, user.email);
  });

  afterAll(async () => {
    await app.db.deleteFrom('users').where('id', '=', user.id).execute();
    await db.destroy();
  });

  it('should be able to create a business', async () => {
    const insertBusiness = T.randomBusiness();

    const postResponse = await app.inject({
      method: 'POST',
      url: BUSINESS_PATH,
      payload: insertBusiness,
      ...T.authorizationHeaders(token),
    });
    expect(postResponse.statusCode).toBe(201);
    expect(postResponse.json().data).toMatchObject({
      ...insertBusiness,
      id: expect.any(String),
      user_id: user.id
    });

    await db
      .deleteFrom('businesses')
      .where('id', '=', postResponse.json().data.id)
      .executeTakeFirstOrThrow();
  });

  it('should not be able to create a business unauthorized', async () => {
    const insertBusiness = T.randomBusiness();

    const postResponse = await app.inject({
      method: 'POST',
      url: BUSINESS_PATH,
      payload: insertBusiness,
    });
    expect(postResponse.statusCode).toBe(401);
    expect(postResponse.json().reason).toContain('Unauthorized');
  });
});
