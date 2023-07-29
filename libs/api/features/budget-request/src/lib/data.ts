import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { User } from '@wang-ku/api/plugins';
import { BudgetRequestCRUD } from '@wang-ku/shared/schema';
import { Kysely } from 'kysely';

export async function read(
  db: Kysely<Database>,
  user: User
): Promise<AppResult<BudgetRequestCRUD['read']['response']>> {
  try {
    const verification = await db
      .selectFrom('users_verifications')
      .where('user_id', '=', user.id ?? '')
      .selectAll()
      .executeTakeFirst();

    if (!verification) {
      return R.Error({
        message: 'Harap verifikasi akun anda terlebih dahulu',
        reason: 'Data verifikasi pengguna tidak ditemukan',
      });
    }

    const { lend_limit } = await db
      .selectFrom('businesses')
      .where('user_id', '=', user.id ?? '')
      .select(['lend_limit'])
      .executeTakeFirstOrThrow();

    return R.Ok({
      data: {
        name: user.name ?? '',
        lend_limit,
      },
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}

export async function create(
  db: Kysely<Database>,
  insertRecord: BudgetRequestCRUD['create']['body'],
  user: User
): Promise<AppResult<BudgetRequestCRUD['create']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const { id } = await trx
        .selectFrom('businesses')
        .where('user_id', '=', user.id ?? '')
        .select(['id'])
        .executeTakeFirstOrThrow();
      const request = await db
        .insertInto('budget_requests')
        .values({
          business_id: id,
          status: 'pending',
          ...insertRecord,
        })
        .returningAll()
        .executeTakeFirstOrThrow();

      return request;
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}

export async function readMany(
  db: Kysely<Database>,
  user: User
): Promise<AppResult<BudgetRequestCRUD['readMany']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const { id } = await trx
        .selectFrom('businesses')
        .where('user_id', '=', user.id ?? '')
        .select(['id'])
        .executeTakeFirstOrThrow();
      const request = await db
        .selectFrom('budget_requests')
        .where('business_id', '=', id)
        .innerJoin('businesses', 'businesses.id', 'budget_requests.business_id')
        .selectAll('budget_requests')
        .select([
          'businesses.name as business_name'
        ])
        .execute();

      return request;
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
