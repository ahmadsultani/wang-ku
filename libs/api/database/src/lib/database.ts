import { Db } from '@wang-ku/shared/schema';

import { DefaultAutoCols, Entity, Modify } from './generics';

export interface Database {
  users: UserTable;
  businesses: BusinessTable;
  users_verifications: UserVerificationTable;
  budget_requests: BudgetRequestTable;
}

// -----------------------------------------------------
// MASTER
// -----------------------------------------------------
type UserTable = Modify<Db['users'], DefaultAutoCols>;
export type Users = Entity<UserTable>;

type BusinessTable = Modify<Db['businesses'], DefaultAutoCols>;
export type Businessses = Entity<BusinessTable>;

type UserVerificationTable = Modify<Db['users_verifications'], DefaultAutoCols>;
export type UsersVerifications = Entity<UserVerificationTable>;

type BudgetRequestTable = Modify<Db['budget_requests'], DefaultAutoCols>;
export type BudgetRequests = Entity<BudgetRequestTable>;
