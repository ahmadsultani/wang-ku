import { Db } from '@wang-ku/shared/schema';

import { DefaultAutoCols, Entity, Modify } from './generics';

export interface Database {
  users: UserTable;
}

// -----------------------------------------------------
// MASTER
// -----------------------------------------------------
type UserTable = Modify<Db['users'], DefaultAutoCols>;
export type Users = Entity<UserTable>;
