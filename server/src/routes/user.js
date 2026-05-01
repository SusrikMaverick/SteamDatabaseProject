import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth.js";
import {
  getOwnedGamesForUser,
  getRecentlyPlayedForUser,
  getUserAchievementsForGame,
  getViewer,
} from "../services/userService.js";

const router = Router();

router.get("/", async (req, res, next) => {
  try {
    if (!req.isAuthenticated || !req.isAuthenticated()) {
      res.json({
        authenticated: false,
      });
      return;
    }

    const steamId = req.user?.steamId || req.user?.id;
    const viewer = await getViewer(steamId);

    res.json({
      authenticated: true,
      viewer,
    });
  } catch (error) {
    next(error);
  }
});

router.get("/owned-games", requireAuth, async (req, res, next) => {
  try {
    const steamId = req.user?.steamId || req.user?.id;
    const payload = await getOwnedGamesForUser(steamId);
    res.json(payload);
  } catch (error) {
    next(error);
  }
});

router.get("/recently-played", requireAuth, async (req, res, next) => {
  try {
    const steamId = req.user?.steamId || req.user?.id;
    const payload = await getRecentlyPlayedForUser(steamId);
    res.json(payload);
  } catch (error) {
    next(error);
  }
});

router.get("/games/:appId/achievements", requireAuth, async (req, res, next) => {
  try {
    const steamId = req.user?.steamId || req.user?.id;
    const appId = Number(req.params.appId);

    if (!Number.isInteger(appId)) {
      res.status(400).json({ error: "Invalid app id" });
      return;
    }

    const payload = await getUserAchievementsForGame(steamId, appId);
    res.json(payload);
  } catch (error) {
    next(error);
  }
});

export { router as userRouter };
