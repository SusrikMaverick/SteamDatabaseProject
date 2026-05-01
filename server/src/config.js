import path from "node:path";
import { fileURLToPath } from "node:url";
import dotenv from "dotenv";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootEnvPath = path.resolve(__dirname, "../../.env");

dotenv.config({ path: rootEnvPath, override: false });
dotenv.config({ override: false });

function toNumber(value, fallback) {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
}

const port = toNumber(process.env.PORT, 3001);
const steamRealm = process.env.STEAM_REALM || `http://localhost:${port}`;

export const config = {
  port,
  host: process.env.HOST || "127.0.0.1",
  clientUrl: process.env.CLIENT_URL || "http://localhost:5173",
  sessionSecret: process.env.SESSION_SECRET || "dev-session-secret-change-me",
  steamApiKey: process.env.STEAM_API_KEY || "",
  steamRealm,
  steamReturnUrl:
    process.env.STEAM_RETURN_URL || `${steamRealm}/auth/steam/return`,
  databaseUrl: process.env.DATABASE_URL || "",
  db: {
    host: process.env.DB_HOST || "localhost",
    port: toNumber(process.env.DB_PORT, 5432),
    database: process.env.DB_NAME || "steam_webapp",
    user: process.env.DB_USER || "postgres",
    password: process.env.DB_PASSWORD || "",
  },
  ttl: {
    gameHours: toNumber(process.env.GAME_TTL_HOURS, 24),
    newsHours: toNumber(process.env.NEWS_TTL_HOURS, 6),
    achievementHours: toNumber(process.env.ACHIEVEMENT_TTL_HOURS, 24),
    userHours: toNumber(process.env.USER_TTL_HOURS, 6),
  },
};
