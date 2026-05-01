import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { pool } from "../lib/db.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const schemaPath = path.resolve(__dirname, "../../../db/schema.sql");

async function main() {
  const sql = await fs.readFile(schemaPath, "utf8");
  await pool.query(sql);
  console.log("Database schema initialized successfully.");
}

main()
  .catch((error) => {
    console.error("Failed to initialize schema:", error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await pool.end();
  });
