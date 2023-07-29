import { TSchema } from '@sinclair/typebox';
import * as fs from 'fs';
import {
  DartTargetLanguage,
  FetchingJSONSchemaStore,
  InputData,
  JSONSchemaInput,
  quicktype,
} from 'quicktype-core';

import {
  Configurations,
  ModelConfiguration,
  RenameDartClass,
  RenameDartKeyword,
} from './configuration';

const CONFIGURATION = Configurations;
const TARGET_DIR = CONFIGURATION.targetDir;

type GeneratedCode = { lines: string[] };

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function removeKey(obj: any) {
  delete obj['path'];
  for (const prop in obj) {
    delete obj[prop]['path'];
    delete obj[prop]['query'];
  }
  return obj;
}

async function main() {
  if (fs.existsSync(TARGET_DIR)) {
    fs.rmSync(TARGET_DIR, { recursive: true, force: true });
  }
  fs.mkdirSync(TARGET_DIR, { recursive: true });

  const schemas = CONFIGURATION.schemas;
  const generatedFiles: Array<string> = [];

  for (const apiModule in schemas) {
    const value = removeKey(schemas[apiModule]);
    for (const apiName of Object.keys(value)) {
      for (const apiPart of Object.keys(value[apiName])) {
        const targetDir = `${TARGET_DIR}/${toSnakeCase(apiModule)}`;
        if (!fs.existsSync(targetDir)) {
          fs.mkdirSync(targetDir, { recursive: true });
        }
        const targetPathTemp =
          targetDir + `/${toSnakeCase(apiName)}_${apiPart}.dart`;
        const config = findConfiguration(targetPathTemp);

        // Skip generated file
        if (config?.skip === true) continue;

        const modelName =
          config?.className ?? toPascalCase(`${apiName}_${apiPart}`);
        const targetPath =
          config?.fileName != null
            ? targetDir + `/${config.fileName}`
            : targetPathTemp;

        const dartSourceStr = await quicktypeJSONSchema(
          modelName,
          value[apiName][apiPart],
          config
        );

        fs.writeFileSync(targetPath, dartSourceStr);
        // Add the generated file position to the array
        generatedFiles.push(targetPath.replace(`${TARGET_DIR}/`, ''));
        console.info(`Created ${targetPath}!`);
      }
    }
  }

  // Make main export generated files
  const targetPath = `${TARGET_DIR}/generated.dart`;
  fs.writeFileSync(
    targetPath,
    generatedFiles.map((line) => `export '${line}';`).join('\n')
  );
  console.info(`Created ${targetPath}!`);
}

main();

// ---------------------------------------------------------------------------
// Quick Type
// ---------------------------------------------------------------------------
// Source: https://github.com/quicktype/quicktype
async function quicktypeJSONSchema(
  modelName: string,
  schema: TSchema,
  config?: ModelConfiguration | null
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
    lang: new DartTargetLanguage(),
    rendererOptions: {
      'copy-with': 'true',
      'final-props': 'true',
      'coders-in-class': 'true',
      'use-freezed': 'true',
    },
  })) as GeneratedCode;

  let newLines = deleteUnusedImport(lines);
  newLines = changeClassDataName(newLines);
  newLines = addRequiredProperty(newLines);
  newLines = removeFreezedClasses(newLines, config?.removeClasses ?? []);
  newLines = renameFreezedClasses(newLines, config?.renameClasses ?? []);
  newLines = renameKeywords(newLines, config?.renameKeywords ?? []);

  return newLines.join('\n');
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
function addRequiredProperty(lines: string[]): string[] {
  const result = lines;
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (line.includes('const factory ')) {
      let isEnd = false;
      let currentLine = i + 1;

      while (!isEnd) {
        const property = lines[currentLine];
        isEnd = property.includes('}) = ');
        if (!isEnd) {
          const isOptional = property.includes('??');
          const words = property.trim().split(' ');

          if (isOptional) {
            result[currentLine] = `    ${words[0].replace('??', '?')} ${
              words[1]
            }`;
          } else {
            result[currentLine] = `    required ${words[0].replace('?', '')} ${
              words[1]
            }`;
          }
        }

        currentLine++;
      }
    }
  }

  return result;
}

function deleteUnusedImport(lines: string[]) {
  lines.splice(0, 4);
  let linesStr = lines.join('\n');

  linesStr = linesStr.replace("import 'package:meta/meta.dart'", '');
  linesStr = linesStr.replace("import 'dart:convert';", '');
  linesStr = linesStr.replace(
    "import 'package:freezed_annotation/freezed_annotation.dart';",
    CONFIGURATION.baseDartImport
  );

  return linesStr.split('\n');
}

function changeClassDataName(lines: string[]) {
  const classInitiation = lines[7].split(' ');
  const className = classInitiation[1];

  return renameFreezedClasses(lines, [
    {
      from: 'Data',
      to: `${className}Data`,
    },
    {
      from: 'Datum',
      to: `${className}Data`,
    },
  ]);
}

function findConfiguration(targetPath: string) {
  const path = targetPath.replace(`${TARGET_DIR}/`, '');

  const config = CONFIGURATION.models.filter((element) => {
    return element.path === path;
  });

  if (config.length >= 1) {
    return config[0];
  }

  return null;
}

function removeFreezedClasses(lines: string[], classes: string[]) {
  if (classes.length == 0) return lines;

  let result = lines;
  for (const classItem of classes) {
    const firstLine =
      result.indexOf(`class ${classItem} with _$${classItem} {`) - 1;
    if (firstLine > 0) {
      const lastLine =
        result.indexOf(
          `    factory ${classItem}.fromJson(Map<String, dynamic> json) => _$${classItem}FromJson(json);`
        ) + 1;
      if (lastLine > 1) {
        const temp = [];
        temp.push(...result.slice(0, firstLine));
        temp.push(...result.slice(lastLine + 1, result.length - 1));
        result = temp;
      }
    }
  }

  return result;
}

function renameFreezedClasses(lines: string[], classes: RenameDartClass[]) {
  if (classes.length == 0) return lines;

  let result = lines.join('\n');
  for (const classItem of classes) {
    const from = classItem.from;
    const to = classItem.to;
    const hasClass = result.includes(`class ${from} with _$${from} {`);
    if (hasClass) {
      result = renameKeywords(result.split('\n'), [
        {
          from: from,
          to: to,
        },
      ]).join('\n');
      result = result.replace(`= _${from}`, `= _${to}`);
    }
  }

  return result.split('\n');
}

function renameKeywords(lines: string[], keywords: RenameDartKeyword[]) {
  if (keywords.length == 0) return lines;

  let result = lines.join('\n');
  for (const keyword of keywords) {
    const from = keyword.from;
    const to = keyword.to;
    const hasKeyword = result.includes(from);
    if (hasKeyword) {
      result = result.replace(`class ${from}`, `class ${to}`);
      result = result.replace(`with _$${from}`, `with _$${to}`);
      result = result.replace(`factory ${from}.`, `factory ${to}.`);
      result = result.replace(`factory ${from}(`, `factory ${to}(`);
      result = result.replace(`_$${from}FromJson`, `_$${to}FromJson`);
      result = result.replace(`required ${from} `, `required ${to} `);
      result = result.replace(
        `required List<${from}> `,
        `required List<${to}> `
      );
      result = result.replace(` ${from}? `, ` ${to}? `);
      result = result.replace(`List<${from}>? `, `List<${to}>? `);
      result = result.replace(`List<${from}?> `, `List<${to}?> `);
    }
  }

  return result.split('\n');
}
