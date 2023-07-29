import { Kysely, sql } from 'kysely';

const tableName = 'businesses';

export async function up(db: Kysely<any>): Promise<void> {
  await db.schema
    .createTable(tableName)
    .addColumn('id', 'uuid', (col) =>
      col.primaryKey().defaultTo(sql`gen_random_uuid()`)
    )
    .addColumn('user_id', 'uuid', (col) => col.references('users.id').notNull())
    .addColumn('name', 'varchar', (col) => col.notNull())
    .addColumn('category', 'varchar', (col) => col.notNull())
    .addColumn('npwp', 'text', (col) => col.notNull())
    .addColumn('nib', 'varchar', (col) => col.notNull())
    .addColumn('lend_limit', 'bigint')
    .addColumn('address', 'varchar', (col) => col.notNull())
    .addColumn('phone_number', 'varchar')
    .addColumn('monthly_spending', 'bigint')
    .addColumn('monthly_income', 'bigint')
    .addColumn('created_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .addColumn('updated_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .execute();

  await db.schema
    .createIndex(`idx_${tableName}_id_user_id`)
    .on(tableName)
    .columns(['id', 'user_id'])
    .execute();
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable(tableName).execute();
}
