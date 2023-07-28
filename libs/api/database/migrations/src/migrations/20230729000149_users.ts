import { Kysely, sql } from 'kysely';

const tableName = 'users';

export async function up(db: Kysely<any>): Promise<void> {
  await db.schema
    .createTable(tableName)
    .addColumn('id', 'uuid', (col) =>
      col.primaryKey().defaultTo(sql`gen_random_uuid()`)
    )
    .addColumn('name', 'varchar', (col) => col.notNull())
    .addColumn('email', 'varchar', (col) => col.notNull().unique())
    .addColumn('password', 'text', (col) => col.notNull())
    .addColumn('phone_number', 'varchar', (col) => col.notNull().unique())
    .addColumn('gender', 'varchar', (col) => col.notNull())
    .addColumn('birth_date', 'bigint', (col) => col.notNull())
    .addColumn('picture', 'text')
    .addColumn('created_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .addColumn('updated_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .execute();

  await db.schema
    .createIndex(`idx_${tableName}_id_email_phone_number`)
    .on(tableName)
    .columns(['id', 'email', 'phone_number'])
    .execute();
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable(tableName).execute();
}
