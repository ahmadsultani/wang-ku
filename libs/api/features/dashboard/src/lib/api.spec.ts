import { Users } from '@wang-ku/api/database';
import * as T from '@wang-ku/api/util/test';
import { DashboardSchema as SS } from '@wang-ku/shared/schema';
import { FastifyInstance } from 'fastify';

import { dashboardPlugin } from './api';

const BASE_PATH = `/api/v1`;
const DASHBOARD_PATH = `${BASE_PATH}${SS.path}`;

describe('Dashboard endpoints', () => {
  let app: FastifyInstance;
  const db = T.dbConnection();

  let user: Users['select'];
  let token: string;

  beforeAll(async () => {
    app = await T.buildApp(
      [
        {
          path: BASE_PATH,
          route: dashboardPlugin,
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

  it('should be able to get dashboard data', async () => {
    const business = await T.createRandomBusiness(db, { user_id: user.id });
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
    const budget_requests = await Promise.all(Array(3).fill(null).map(() => {
      return T.createRandomBudgetRequest(db, { business_id: business.id, status: 'approved' })
    }))
    const lended_total = budget_requests.reduce((value, currRow: { request_budget: number }) => {
      return value + currRow.request_budget
    }, 0)

    const getResponse = await app.inject({
      method: 'GET',
      url: DASHBOARD_PATH,
      ...T.authorizationHeaders(token),
    });
    expect(getResponse.statusCode).toBe(200);
    expect(getResponse.json().data).toMatchObject({
      lended_total,
      lend_limit: 100_000_000,
      monthly_spending: 0,
      monthly_income: 0,
      last_lend_status: 'approved',
      business: {
        ...business,
        lend_limit: 100_000_000,
      },
      user_verification: verification,
    });


    await db.deleteFrom('budget_requests').execute();
    await db.deleteFrom('businesses').where('id', '=', business.id).execute();
    await db
      .deleteFrom('users_verifications')
      .where('id', '=', verification.id)
      .execute();
  });
});
