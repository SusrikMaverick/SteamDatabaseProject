import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import cors from "cors";
import express from "express";
import session from "express-session";
import passport from "passport";
import { config } from "./config.js";
import { setupPassport } from "./lib/passport.js";
import { authRouter } from "./routes/auth.js";
import { gamesRouter } from "./routes/games.js";
import { userRouter } from "./routes/user.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const clientDistDir = path.resolve(__dirname, "../../client/dist");

setupPassport();

const app = express();

app.use(
  cors({
    origin: config.clientUrl,
    credentials: true,
  })
);
app.use(express.json());
app.use(
  session({
    secret: config.sessionSecret,
    resave: false,
    saveUninitialized: false,
    cookie: {
      sameSite: "lax",
      secure: false,
    },
  })
);
app.use(passport.initialize());
app.use(passport.session());

app.get("/api/health", (_req, res) => {
  res.json({ ok: true });
});

app.use("/auth", authRouter);
app.use("/api/games", gamesRouter);
app.use("/api/me", userRouter);

if (fs.existsSync(clientDistDir)) {
  app.use(express.static(clientDistDir));

  app.get("*", (req, res, next) => {
    if (req.path.startsWith("/api") || req.path.startsWith("/auth")) {
      next();
      return;
    }

    res.sendFile(path.join(clientDistDir, "index.html"));
  });
}

app.use((error, _req, res, _next) => {
  console.error(error);
  res.status(500).json({
    error: error.message || "Unexpected server error",
  });
});

export { app };
