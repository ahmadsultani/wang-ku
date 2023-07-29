import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { User } from '@wang-ku/api/plugins';
import { Dashboard } from '@wang-ku/shared/schema';
import { Kysely, sql } from 'kysely';

export async function read(
  db: Kysely<Database>,
  user: User
): Promise<AppResult<Dashboard['read']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const business = await trx
        .selectFrom('businesses')
        .where('user_id', '=', user.id ?? '')
        .selectAll()
        .executeTakeFirstOrThrow();

      // __AUTO_GENERATED_PRINTF_START__
      console.log('read#(anon) 1'); // __AUTO_GENERATED_PRINTF_END__

      const userVerification = await trx
        .selectFrom('users_verifications')
        .where('user_id', '=', user.id ?? '')
        .selectAll()
        .executeTakeFirstOrThrow();

      // __AUTO_GENERATED_PRINTF_START__
      console.log('read#(anon) 2'); // __AUTO_GENERATED_PRINTF_END__

      const { lended_total } = await trx
        .selectFrom('budget_requests')
        .where('business_id', '=', business.id)
        .where('status', '=', 'approved')
        .select([sql<number>`sum(request_budget)`.as('lended_total')])
        .executeTakeFirstOrThrow();

      // __AUTO_GENERATED_PRINTF_START__
      console.log('read#(anon) 3'); // __AUTO_GENERATED_PRINTF_END__

      const lastRequest = await trx
        .selectFrom('budget_requests')
        .where('business_id', '=', business.id)
        .select('status')
        .orderBy('updated_at', 'desc')
        .limit(1)
        .executeTakeFirst();

      return {
        lended_total,
        lend_limit: business.lend_limit ?? 0,
        monthly_spending: business.monthly_spending ?? 0,
        monthly_income: business.monthly_income ?? 0,
        last_lend_status: lastRequest ? lastRequest.status : null,
        business: business ?? null,
        user_verification: userVerification ?? null,
      };
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
