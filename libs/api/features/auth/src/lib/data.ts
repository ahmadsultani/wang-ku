import { Database } from '@wang-ku/api/database';
import { AppResult, R, toAppError } from '@wang-ku/api/error-handling';
import { JWT } from '@wang-ku/api/plugins';
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

export async function signIn(
  db: Kysely<Database>,
  jwt: JWT,
  insertRecord: Auth['sign_in']['body']
): Promise<AppResult<Auth['sign_in']['response']>> {
  try {
    const user = await db
      .selectFrom('users')
      .where('email', '=', insertRecord.email)
      .selectAll()
      .executeTakeFirstOrThrow();

    const { id, hashed, name, email } = user
      ? {
          id: user.id,
          name: user.name,
          hashed:
            user.password ??
            '$argon2id$v=19$m=65536,t=3,p=4$xxxxxxxxxxxxxxxx$xxxxxxxx/xxxxxxxxxxxxxxxx/w',
          email: user.email,
        }
      : {
          id: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
          name: 'xxxxxxx',
          hashed:
            '$argon2id$v=19$m=65536,t=3,p=4$xxxxxxxxxxxxxxxx$xxxxxxxx/xxxxxxxxxxxxxxxx/w',
          email: 'xxxxxxxxxxxx',
        };

    const passwordMatches = await argon2.verify(hashed, insertRecord.password);
    if (!passwordMatches)
      return R.Error({
        message: 'Gagal masuk!',
        reason: 'Email atau kata sandi tidak sesuai.',
      });

    const token = await jwt.sign(
      {
        id,
        email,
        name,
      },
      {
        expiresIn: '24h',
      }
    );

    return R.Ok({
      data: {
        token,
        user: {
          id,
          name,
          email,
        },
      },
    });
  } catch (err) {
    return R.Error(toAppError(err));
  }
}
