import { faker } from '@faker-js/faker';
import * as DB from '@wang-ku/api/database';

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
