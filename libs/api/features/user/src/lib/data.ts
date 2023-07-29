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
    const user_verification = await db
      .insertInto('users_verifications')
      .values({
        user_id: user.id ?? '',
        ...insertRecord,
      })
      .returningAll()
      .executeTakeFirstOrThrow();

    return R.Ok({
      data: user_verification,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
