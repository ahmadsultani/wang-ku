import { Users } from '@wang-ku/api/database';
import * as T from '@wang-ku/api/util/test';
import { faker } from '@wang-ku/api/util/test';
import { BudgetRequestCRUDSchema as SS } from '@wang-ku/shared/schema';
import { FastifyInstance } from 'fastify';

import { budgetRequestPlugin } from './api';

const BASE_PATH = `/api/v1`;
const BUDGET_REQUEST_PATH = `${BASE_PATH}${SS.path}`;

describe('Budget request endpoints', () => {
  let app: FastifyInstance;
  const db = T.dbConnection();

  let user: Users['select'];
  let token: string;

  beforeAll(async () => {
    app = await T.buildApp(
      [
        {
          path: BASE_PATH,
          route: budgetRequestPlugin,
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

  it('should be able to get data for loan and able to submit loan', async () => {
    const business = await T.createRandomBusiness(db, { user_id: user.id });

    const getVerifyResponse = await app.inject({
      method: 'GET',
      url: BUDGET_REQUEST_PATH,
      ...T.authorizationHeaders(token),
    });
    expect(getVerifyResponse.statusCode).toBe(400);
    expect(getVerifyResponse.json().message).toBe(
      'Harap verifikasi akun anda terlebih dahulu'
    );

    const verification = await T.createRandomUserVerification(db, {
      user_id: user.id,
    });
    await db
      .updateTable('businesses')
      .where('id', '=', business.id)
      .set({
        lend_limit: 100_000_000,
      })
      .execute();

    const getResponse = await app.inject({
      method: 'GET',
      url: BUDGET_REQUEST_PATH,
      ...T.authorizationHeaders(token),
    });
    expect(getResponse.statusCode).toBe(200);
    expect(getResponse.json().data).toMatchObject({
      name: user.name,
      lend_limit: 100_000_000,
    });

    const requestBudget = faker.number.int({ max: 100_000_000 });
    const postResponse = await app.inject({
      method: 'POST',
      url: BUDGET_REQUEST_PATH,
      body: {
        request_budget: requestBudget,
      },
      ...T.authorizationHeaders(token),
    });
    expect(postResponse.statusCode).toBe(201);
    expect(postResponse.json().data).toMatchObject({
      request_budget: requestBudget,
      status: 'pending',
    });

    const getAllResponse = await app.inject({
      method: 'GET',
      url: BUDGET_REQUEST_PATH + SS.readMany.path,
      ...T.authorizationHeaders(token),
    });
    expect(getAllResponse.statusCode).toBe(200);
    expect(getAllResponse.json().data.length).toBeGreaterThan(0);

    await db.deleteFrom('budget_requests').execute();
    await db.deleteFrom('businesses').where('id', '=', business.id).execute();
    await db
      .deleteFrom('users_verifications')
      .where('id', '=', verification.id)
      .execute();
  });
});
