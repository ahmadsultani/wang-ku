import {
  AuthSchema,
  BudgetRequestCRUDSchema,
  BusinessCRUDSchema,
  UserCRUDSchema,
} from '@wang-ku/shared/schema';

interface ModelConfiguration {
  path: string;
  fileName?: string;
  className?: string;
  skip?: boolean;
  removeClasses?: string[];
  renameClasses?: RenameDartClass[];
  renameKeywords?: RenameDartKeyword[];
}

interface RenameDartClass {
  from: string;
  to: string;
}

interface RenameDartKeyword {
  from: string;
  to: string;
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type ApiSchemas = Record<string, any>;

interface Config {
  targetDir: string;
  models: ModelConfiguration[];
  baseDartImport: string;
  schemas: ApiSchemas;
}

const Configurations: Config = {
  targetDir: 'libs/mobile/shared/lib/domains/generated',
  baseDartImport: "import 'package:shared/shared.dart';",
  schemas: {
    auth: AuthSchema,
    business: BusinessCRUDSchema,
    user: UserCRUDSchema,
    budget_request: BudgetRequestCRUDSchema
  },
  models: [],
};

export {
  Configurations,
  ModelConfiguration,
  RenameDartClass,
  RenameDartKeyword,
};
