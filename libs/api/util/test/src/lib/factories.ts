import { faker } from '@faker-js/faker';
import * as DB from '@wang-ku/api/database';
import { BudgetRequests, Businessses, Database, Users, UsersVerifications } from '@wang-ku/api/database';
import { Kysely } from 'kysely';

export { faker } from '@faker-js/faker';

export function randomUser(overrides?: DB.Users['update']): DB.Users['insert'] {
  const firstName = faker.person.firstName();
  const lastName = faker.person.lastName();
  return {
    name: [firstName, lastName].join(' '),
    email: faker.internet.email({
      firstName,
      lastName,
    }),
    password: 'password',
    phone_number: faker.phone.number(),
    gender: faker.helpers.arrayElement(['male', 'female']),
    birth_date: faker.date
      .birthdate({ min: 18, max: 65, mode: 'age' })
      .getTime(),
    picture: faker.image.url(),
    ...overrides,
  };
}

export async function createRandomUser(
  db: Kysely<Database>,
  overrides?: DB.Users['update']
): Promise<Users['select']> {
  return await db
    .insertInto('users')
    .values(randomUser(overrides))
    .returningAll()
    .executeTakeFirstOrThrow();
}

export function randomBusiness(
  overrides?: DB.Businessses['update']
): DB.Businessses['insert'] {
  return {
    user_id: '',
    name: faker.company.name(),
    category: faker.helpers.arrayElement([
      'wholesale',
      'material',
      'manufacture',
      'food_and_beverage',
      'business_service',
      'hardware',
      'others',
    ]),
    npwp: faker.string.numeric(16),
    nib: faker.string.numeric(13),
    address: faker.location.streetAddress(),
    phone_number: faker.phone.number(),
    ...overrides,
  };
}

export async function createRandomBusiness(
  db: Kysely<Database>,
  overrides?: DB.Businessses['update']
): Promise<Businessses['select']> {
  return await db
    .insertInto('businesses')
    .values(randomBusiness(overrides))
    .returningAll()
    .executeTakeFirstOrThrow();
}

export function randomUserVerification(
  overrides?: DB.UsersVerifications['update']
): DB.UsersVerifications['insert'] {
  return {
    user_id: '',
    picture: faker.image.url(),
    nik: faker.string.numeric(16),
    birth_place: faker.location.city(),
    ...overrides,
  };
}

export async function createRandomUserVerification(
  db: Kysely<Database>,
  overrides?: DB.UsersVerifications['update']
): Promise<UsersVerifications['select']> {
  return await db
    .insertInto('users_verifications')
    .values(randomUserVerification(overrides))
    .returningAll()
    .executeTakeFirstOrThrow();
}

export function randomBudgetRequest(
  overrides?: DB.BudgetRequests['update']
): DB.BudgetRequests['insert'] {
  return {
    request_budget: faker.number.int({ max: 20_000_000 }),
    status: 'pending',
    business_id: '',
    ...overrides,
  };
}

export async function createRandomBudgetRequest(
  db: Kysely<Database>,
  overrides?: DB.BudgetRequests['update']
): Promise<BudgetRequests['select']> {
  return await db
    .insertInto('budget_requests')
    .values(randomBudgetRequest(overrides))
    .returningAll()
    .executeTakeFirstOrThrow();
}
