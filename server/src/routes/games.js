import { Router } from "express";
import { getGameDetails, searchGames } from "../services/gameService.js";

const router = Router();

router.get("/search", async (req, res, next) => {
  try {
    const q = String(req.query.q || "");
    const results = await searchGames(q);
    res.json({ results });
  } catch (error) {
    next(error);
  }
});

router.get("/:appId", async (req, res, next) => {
  try {
    const appId = Number(req.params.appId);

    if (!Number.isInteger(appId)) {
      res.status(400).json({ error: "Invalid app id" });
      return;
    }

    const details = await getGameDetails(appId);

    if (!details) {
      res.status(404).json({ error: "Game not found" });
      return;
    }

    res.json(details);
  } catch (error) {
    next(error);
  }
});

export { router as gamesRouter };
