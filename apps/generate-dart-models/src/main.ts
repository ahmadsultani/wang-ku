import { faker } from '@faker-js/faker';
import { TSchema } from '@sinclair/typebox';
import { ApiSchemas } from '@wang-ku/shared/schema';
import * as fs from 'fs';
import {
  FetchingJSONSchemaStore,
  InputData,
  JSONSchemaInput,
  quicktype,
} from 'quicktype-core';

type GeneratedCode = { lines: string[] };
const TARGET_DIR = 'apps/mobile/lib/src/generated_models';

async function main() {
  if (fs.existsSync(TARGET_DIR)) {
    fs.rmSync(TARGET_DIR, { recursive: true, force: true });
  }
  fs.mkdirSync(TARGET_DIR, { recursive: true });

  const moduleKeys = ['auth'];
  for (const apiModule of moduleKeys) {
    for (const apiName of Object.keys(ApiSchemas[apiModule])) {
      for (const apiPart of Object.keys(ApiSchemas[apiModule][apiName])) {
        const targetDir = `${TARGET_DIR}/${toSnakeCase(apiModule)}`;
        if (!fs.existsSync(targetDir)) {
          fs.mkdirSync(targetDir, { recursive: true });
        }
        const modelName = toPascalCase(`${apiName}_${apiPart}`);
        const targetPath =
          targetDir + `/${toSnakeCase(apiName)}_${apiPart}.g.dart`;
        const dartSourceStr = await quicktypeJSONSchema(
          modelName,
          ApiSchemas[apiModule][apiName][apiPart]
        );
        fs.writeFileSync(targetPath, dartSourceStr);
        console.log(`Created ${targetPath}!`);
      }
    }
  }
}
main();
// ---------------------------------------------------------------------------
// Quick Type
// ---------------------------------------------------------------------------
// Source: https://github.com/quicktype/quicktype
async function quicktypeJSONSchema(
  modelName: string,
  schema: TSchema
): Promise<string> {
  const schemaInput = new JSONSchemaInput(new FetchingJSONSchemaStore());
  await schemaInput.addSource({
    name: modelName,
    schema: JSON.stringify(schema),
  });
  const inputData = new InputData();
  inputData.addInput(schemaInput);
  const { lines } = (await quicktype({
    inputData,
    lang: 'dart',
  })) as GeneratedCode;
  return lines
    .map(addRequiredToLine)
    .map((line) => addOptionality(line, lines))
    .join('\n');
}

// Source: https://stackoverflow.com/a/53952925
function toPascalCase(str: string): string {
  return `${str}`
    .toLowerCase()
    .replace(new RegExp(/[-_]+/, 'g'), ' ')
    .replace(new RegExp(/[^\w\s]/, 'g'), '')
    .replace(
      new RegExp(/\s+(.)(\w*)/, 'g'),
      (_, $2, $3) => `${$2.toUpperCase() + $3}`
    )
    .replace(new RegExp(/\w/), (s) => s.toUpperCase());
}

// Source: https://stackoverflow.com/a/44280814
function toSnakeCase(str: string): string {
  return str
    .split(/\.?(?=[A-Z])/)
    .join('_')
    .toLowerCase();
}

// ---------------------------------------------------------------------------
// Custom Transformers
// ---------------------------------------------------------------------------
function addOptionality(line: string, context: string[]): string {
  const words = line.trim().split(' ');
  const firstWord = words[0] ?? '';
  const lastChar = line[line.length - 1] ?? '';
  const isFieldDeclaration =
    words.length === 2 && firstWord !== 'import' && lastChar == ';';
  if (isFieldDeclaration) {
    const fieldName = (words[1] ?? faker.string.uuid()).replace(';', '');
    const nullableLines = context.filter(
      (x) => x.includes(fieldName + ': json') && x.includes('== null ? null :')
    );
    const shouldBeNullable = nullableLines.length > 0;
    return shouldBeNullable ? line.replace(firstWord, firstWord + '?') : line;
  }
  return line;
}

function addRequiredToLine(line: string): string {
  return line.replace('this.', 'required this.');
}
