import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { User } from '@wang-ku/api/plugins';
import { BusinessCRUD } from '@wang-ku/shared/schema';
import { Kysely } from 'kysely';

export async function create(
  db: Kysely<Database>,
  insertRecord: BusinessCRUD['create']['body'],
  user: User
): Promise<AppResult<BusinessCRUD['create']['response']>> {
  try {
    const data = await db.transaction().execute(async (trx) => {
      const business = await trx
        .insertInto('businesses')
        .values({
          user_id: user.id ?? '',
          ...insertRecord,
        })
        .returningAll()
        .executeTakeFirstOrThrow();

      const selectedUser = await trx
        .selectFrom('users')
        .where('id', '=', user.id ?? '')
        .select(['name', 'email', 'phone_number'])
        .executeTakeFirstOrThrow();

      return {
        ...business,
        user_name: selectedUser.name,
        user_email: selectedUser.email,
        user_phone_number: selectedUser.phone_number,
      };
    });

    return R.Ok({
      data,
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
