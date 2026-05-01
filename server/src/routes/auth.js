import { Router } from "express";
import passport from "passport";
import { config } from "../config.js";

const router = Router();

router.get("/", (_req, res) => {
  res.json({
    provider: "steam",
    loginUrl: "/auth/steam",
  });
});

router.get("/steam", passport.authenticate("steam", { failureRedirect: "/" }));

router.get(
  "/steam/return",
  passport.authenticate("steam", { failureRedirect: `${config.clientUrl}/?login=failed` }),
  (_req, res) => {
    res.redirect(`${config.clientUrl}/dashboard`);
  }
);

router.post("/logout", (req, res, next) => {
  req.logout((error) => {
    if (error) {
      next(error);
      return;
    }

    req.session.destroy(() => {
      res.json({ ok: true });
    });
  });
});

export { router as authRouter };
