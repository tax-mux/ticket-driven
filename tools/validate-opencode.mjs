#!/usr/bin/env node
import { readFileSync } from "node:fs";
import { parse } from "jsonc-parser";
import { resolve } from "node:path";

const target = process.argv[2] ?? ".opencode/opencode.jsonc.example";
const path = resolve(target);
const text = readFileSync(path, "utf8");
const errors = [];
const value = parse(text, errors, { allowTrailingComma: true });

if (errors.length > 0) {
  for (const e of errors) {
    console.error(`${path}:${e.offset}: ${e.message}`);
  }
  process.exit(1);
}

if (!value || typeof value !== "object") {
  console.error(`${path}: expected a JSON object`);
  process.exit(1);
}

console.log(`OK: ${path}`);
