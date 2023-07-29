import { Kysely, sql } from 'kysely';

const tableName = 'users_verifications';

export async function up(db: Kysely<any>): Promise<void> {
  await db.schema
    .createTable(tableName)
    .addColumn('id', 'uuid', (col) =>
      col.primaryKey().defaultTo(sql`gen_random_uuid()`)
    )
    .addColumn('user_id', 'uuid', (col) => col.references('users.id').notNull())
    .addColumn('picture', 'text')
    .addColumn('nik', 'varchar', (col) => col.notNull().unique())
    .addColumn('birth_place', 'varchar', (col) => col.notNull())
    .addColumn('created_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .addColumn('updated_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .execute();

  await db.schema
    .createIndex(`idx_${tableName}_id_user_id_nik`)
    .on(tableName)
    .columns(['id', 'user_id', 'nik'])
    .execute();
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable(tableName).execute();
}
