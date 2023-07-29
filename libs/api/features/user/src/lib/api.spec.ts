import { Users } from '@wang-ku/api/database';
import * as T from '@wang-ku/api/util/test';
import { UserCRUDSchema as SS } from '@wang-ku/shared/schema';
import { FastifyInstance } from 'fastify';

import { userPlugin } from './api';

const BASE_PATH = `/api/v1`;
const USER_PATH = `${BASE_PATH}${SS.path}`;

describe('User endpoints', () => {
  let app: FastifyInstance;
  const db = T.dbConnection();

  let user: Users['select'];
  let token: string;

  beforeAll(async () => {
    app = await T.buildApp(
      [
        {
          path: BASE_PATH,
          route: userPlugin,
        },
      ],
      true
    );

    user = await T.createRandomUser(db);
    token = await T.login(app, user.email);
  });

  afterAll(async () => {
    await app.db.deleteFrom('users').where('id', '=', user.id).execute();
    await db.destroy();
  });

  it('should be able to get profile data', async () => {
    const userResponse = {
      id: user.id,
      name: user.name,
      email: user.email,
      phone_number: user.phone_number,
      birth_date: user.birth_date,
    };

    const getResponse = await app.inject({
      method: 'GET',
      url: USER_PATH + SS.profile.path,
      ...T.authorizationHeaders(token),
    });
    expect(getResponse.statusCode).toBe(200);
    expect(getResponse.json().data).toMatchObject({
      user: userResponse,
      business: null,
    });

    const business = await T.createRandomBusiness(db, { user_id: user.id });

    const getBusinessResponse = await app.inject({
      method: 'GET',
      url: USER_PATH + SS.profile.path,
      ...T.authorizationHeaders(token),
    });
    expect(getBusinessResponse.statusCode).toBe(200);
    expect(getBusinessResponse.json().data).toMatchObject({
      user: userResponse,
      business,
    });

    await db.deleteFrom('businesses').where('id', '=', business.id).execute();
  });

  it('should be able to submit user verification', async () => {
    const insertVerification = T.randomUserVerification();

    const postResponse = await app.inject({
      method: 'POST',
      url: USER_PATH + SS.verify.path,
      payload: insertVerification,
      ...T.authorizationHeaders(token),
    });
    expect(postResponse.statusCode).toBe(201);
    expect(postResponse.json().data).toMatchObject({
      ...insertVerification,
      id: expect.any(String),
      user_id: user.id,
    });

    await db
      .deleteFrom('users_verifications')
      .where('id', '=', postResponse.json().data.id)
      .executeTakeFirstOrThrow();
  });
});
