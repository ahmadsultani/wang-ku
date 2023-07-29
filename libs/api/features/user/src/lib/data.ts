import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { User } from '@wang-ku/api/plugins';
import { UserCRUD } from '@wang-ku/shared/schema';
import { Kysely } from 'kysely';

export async function profile(
  db: Kysely<Database>,
  user: User
): Promise<AppResult<UserCRUD['profile']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const selectedUser = await trx
        .selectFrom('users')
        .where('id', '=', user.id ?? '')
        .select(['id', 'name', 'email', 'phone_number', 'birth_date'])
        .executeTakeFirstOrThrow();

      const business = await trx
        .selectFrom('businesses')
        .where('user_id', '=', selectedUser.id)
        .selectAll()
        .executeTakeFirst();

      return {
        user: selectedUser,
        business: business ?? null,
      };
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}

export async function verify(
  db: Kysely<Database>,
  insertRecord: UserCRUD['verify']['body'],
  user: User
): Promise<AppResult<UserCRUD['verify']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const user_verification = await trx
        .insertInto('users_verifications')
        .values({
          user_id: user.id ?? '',
          ...insertRecord,
        })
        .returningAll()
        .executeTakeFirstOrThrow();

      await trx
        .updateTable('businesses')
        .where('user_id', '=', user.id ?? '')
        .set({
          lend_limit: 100_000_000,
        })
        .execute();
      return user_verification;
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
