import passport from "passport";
import passportSteam from "passport-steam";
import { config } from "../config.js";
import { getViewer, upsertUserFromPassportProfile } from "../services/userService.js";

const { Strategy: SteamStrategy } = passportSteam;

let initialized = false;

export function setupPassport() {
  if (initialized) {
    return passport;
  }

  initialized = true;

  passport.serializeUser((user, done) => {
    done(null, user.id || user.steamId);
  });

  passport.deserializeUser(async (steamId, done) => {
    try {
      const user = await getViewer(steamId);
      done(null, user || { steamId });
    } catch (error) {
      done(error);
    }
  });

  passport.use(
    new SteamStrategy(
      {
        returnURL: config.steamReturnUrl,
        realm: config.steamRealm,
        apiKey: config.steamApiKey,
      },
      async (_identifier, profile, done) => {
        try {
          await upsertUserFromPassportProfile(profile);
          done(null, profile);
        } catch (error) {
          done(error);
        }
      }
    )
  );

  return passport;
}
