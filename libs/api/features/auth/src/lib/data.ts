import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { Auth } from '@wang-ku/shared/schema';
import * as argon2 from 'argon2';
import { Kysely } from 'kysely';

export async function signUp(
  db: Kysely<Database>,
  insertRecord: Auth['sign_up']['body']
): Promise<AppResult<Auth['sign_up']['response']>> {
  try {
    const hashedPassword = await argon2.hash(insertRecord.password);
    const user = await db
      .insertInto('users')
      .values({
        ...insertRecord,
        password: hashedPassword,
      })
      .returningAll()
      .executeTakeFirstOrThrow();

    return R.Ok({
      data: {
        email: user.email,
      },
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
