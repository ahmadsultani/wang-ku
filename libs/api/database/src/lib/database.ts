import { Db } from '@wang-ku/shared/schema';

import { DefaultAutoCols, Entity, Modify } from './generics';

export interface Database {
  users: UserTable;
  businesses: BusinessTable;
}

// -----------------------------------------------------
// MASTER
// -----------------------------------------------------
type UserTable = Modify<Db['users'], DefaultAutoCols>;
export type Users = Entity<UserTable>;

type BusinessTable = Modify<Db['businesses'], DefaultAutoCols>;
export type Businessses = Entity<BusinessTable>;
