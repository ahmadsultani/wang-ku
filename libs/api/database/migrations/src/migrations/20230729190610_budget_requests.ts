import { Kysely, sql } from 'kysely';

const tableName = 'budget_requests';

export async function up(db: Kysely<any>): Promise<void> {
  await db.schema
    .createTable(tableName)
    .addColumn('id', 'uuid', (col) =>
      col.primaryKey().defaultTo(sql`gen_random_uuid()`)
    )
    .addColumn('business_id', 'uuid', (col) =>
      col.references('businesses.id').notNull()
    )
    .addColumn('request_budget', 'bigint', (col) => col.notNull())
    .addColumn('status', 'varchar')
    .addColumn('created_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .addColumn('updated_at', 'bigint', (col) =>
      col.defaultTo(sql`EXTRACT(EPOCH FROM NOW()) * 1000`).notNull()
    )
    .execute();

  await db.schema
    .createIndex(`idx_${tableName}_id_business_id_status`)
    .on(tableName)
    .columns(['id', 'business_id', 'status'])
    .execute();
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable(tableName).execute();
}
