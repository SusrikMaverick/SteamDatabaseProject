import { config } from "../config.js";
import { isStale, fromUnixSeconds } from "../lib/cache.js";
import { query, withTransaction } from "../lib/db.js";
import {
  fetchOwnedGames,
  fetchPlayerAchievements,
  fetchPlayerSummary,
  fetchRecentlyPlayed,
} from "../lib/steamApi.js";
import { getGameDetails } from "./gameService.js";

export const ENDPOINTS = {
  ownedGames: "owned_games",
  recentlyPlayed: "recently_played",
  playerAchievements: "player_achievements",
};

function mapUser(row) {
  if (!row) {
    return null;
  }

  return {
    steamId: row.steam_id,
    displayName: row.display_name,
    avatarUrl: row.avatar_url,
    profileUrl: row.profile_url,
    profileLastFetchedAt: row.profile_last_fetched_at,
  };
}

function mapLibraryRow(row) {
  return {
    appId: row.app_id,
    name: row.name,
    headerImage: row.header_image || row.capsule_image,
    playtimeForever: row.playtime_forever,
    ownershipLastFetchedAt: row.ownership_last_fetched_at,
  };
}

function mapRecentRow(row) {
  return {
    appId: row.app_id,
    name: row.name,
    headerImage: row.header_image || row.capsule_image,
    playtime2Weeks: row.playtime_2weeks,
    playtimeForever: row.playtime_forever,
    lastPlayedAt: row.last_played_at,
    recentLastFetchedAt: row.recent_last_fetched_at,
  };
}

function mapAchievementRow(row) {
  return {
    apiName: row.api_name,
    displayName: row.display_name,
    description: row.description,
    icon: row.icon,
    iconGray: row.icon_gray,
    globalPercent: row.global_percent,
    achieved: row.achieved,
    unlockTime: row.unlock_time,
    userAchievementLastFetchedAt: row.user_achievement_last_fetched_at,
  };
}

async function upsertUserRecord(client, user) {
  await client.query(
    `
      INSERT INTO users (
        steam_id,
        display_name,
        avatar_url,
        profile_url,
        profile_last_fetched_at
      )
      VALUES ($1, $2, $3, $4, NOW())
      ON CONFLICT (steam_id) DO UPDATE SET
        display_name = EXCLUDED.display_name,
        avatar_url = EXCLUDED.avatar_url,
        profile_url = EXCLUDED.profile_url,
        profile_last_fetched_at = NOW()
    `,
    [user.steamId, user.displayName, user.avatarUrl, user.profileUrl]
  );
}

async function upsertGameShell(client, game) {
  await client.query(
    `
      INSERT INTO games (
        app_id,
        name,
        capsule_image
      )
      VALUES ($1, $2, $3)
      ON CONFLICT (app_id) DO UPDATE SET
        name = EXCLUDED.name,
        capsule_image = COALESCE(EXCLUDED.capsule_image, games.capsule_image)
    `,
    [game.appid, game.name || `App ${game.appid}`, game.img_icon_url || null]
  );
}

async function upsertEndpointStatus(client, steamId, endpointName, status, details = null) {
  await client.query(
    `
      INSERT INTO user_endpoint_status (
        steam_id,
        endpoint_name,
        status,
        last_checked_at,
        details
      )
      VALUES ($1, $2, $3, NOW(), $4)
      ON CONFLICT (steam_id, endpoint_name) DO UPDATE SET
        status = EXCLUDED.status,
        last_checked_at = NOW(),
        details = EXCLUDED.details
    `,
    [steamId, endpointName, status, details]
  );
}

async function getEndpointStatus(steamId, endpointName) {
  const result = await query(
    `
      SELECT *
      FROM user_endpoint_status
      WHERE steam_id = $1 AND endpoint_name = $2
    `,
    [steamId, endpointName]
  );

  return result.rows[0] ?? null;
}

function isEndpointFresh(statusRow) {
  return statusRow && !isStale(statusRow.last_checked_at, config.ttl.userHours);
}

export async function upsertUserFromPassportProfile(profile) {
  const normalized = {
    steamId: profile.id,
    displayName: profile.displayName,
    avatarUrl:
      profile.photos?.[2]?.value || profile.photos?.[0]?.value || profile._json?.avatarfull,
    profileUrl: profile._json?.profileurl || profile._json?.url || null,
  };

  await withTransaction(async (client) => {
    await upsertUserRecord(client, normalized);
  });

  return normalized.steamId;
}

export async function refreshUserProfile(steamId) {
  const summary = await fetchPlayerSummary(steamId);

  if (!summary) {
    return null;
  }

  const user = {
    steamId,
    displayName: summary.personaname,
    avatarUrl: summary.avatarfull || summary.avatarmedium || summary.avatar,
    profileUrl: summary.profileurl || null,
  };

  await withTransaction(async (client) => {
    await upsertUserRecord(client, user);
  });

  return user;
}

export async function getViewer(steamId) {
  const existing = await query("SELECT * FROM users WHERE steam_id = $1", [steamId]);
  let userRow = existing.rows[0] ?? null;

  if (!userRow || isStale(userRow.profile_last_fetched_at, config.ttl.userHours)) {
    await refreshUserProfile(steamId);
    const refreshed = await query("SELECT * FROM users WHERE steam_id = $1", [steamId]);
    userRow = refreshed.rows[0] ?? userRow;
  }

  if (!userRow) {
    return null;
  }

  const statuses = await query(
    `
      SELECT endpoint_name, status, last_checked_at, details
      FROM user_endpoint_status
      WHERE steam_id = $1
    `,
    [steamId]
  );

  const endpointStatus = Object.fromEntries(
    statuses.rows.map((row) => [
      row.endpoint_name,
      {
        status: row.status,
        lastCheckedAt: row.last_checked_at,
        details: row.details,
      },
    ])
  );

  return {
    ...mapUser(userRow),
    endpointStatus,
  };
}

export async function getOwnedGamesForUser(steamId) {
  const currentStatus = await getEndpointStatus(steamId, ENDPOINTS.ownedGames);

  if (!isEndpointFresh(currentStatus)) {
    const response = await fetchOwnedGames(steamId);
    const games = Array.isArray(response?.games) ? response.games : null;

    if (!games) {
      await withTransaction(async (client) => {
        await upsertEndpointStatus(
          client,
          steamId,
          ENDPOINTS.ownedGames,
          "private",
          "Steam did not return owned games for this user."
        );
      });
    } else {
      await withTransaction(async (client) => {
        for (const game of games) {
          await upsertGameShell(client, game);
          await client.query(
            `
              INSERT INTO owns (
                steam_id,
                app_id,
                playtime_forever,
                ownership_last_fetched_at
              )
              VALUES ($1, $2, $3, NOW())
              ON CONFLICT (steam_id, app_id) DO UPDATE SET
                playtime_forever = EXCLUDED.playtime_forever,
                ownership_last_fetched_at = NOW()
            `,
            [steamId, game.appid, game.playtime_forever || 0]
          );
        }

        await upsertEndpointStatus(client, steamId, ENDPOINTS.ownedGames, "available");
      });
    }
  }

  const status = await getEndpointStatus(steamId, ENDPOINTS.ownedGames);
  const rows = await query(
    `
      SELECT o.*, g.name, g.header_image, g.capsule_image
      FROM owns AS o
      JOIN games AS g ON g.app_id = o.app_id
      WHERE o.steam_id = $1
      ORDER BY o.playtime_forever DESC, g.name
    `,
    [steamId]
  );

  return {
    status: status?.status ?? "unknown",
    lastCheckedAt: status?.last_checked_at ?? null,
    details: status?.details ?? null,
    games: rows.rows.map(mapLibraryRow),
  };
}

export async function getRecentlyPlayedForUser(steamId) {
  const currentStatus = await getEndpointStatus(steamId, ENDPOINTS.recentlyPlayed);

  if (!isEndpointFresh(currentStatus)) {
    const response = await fetchRecentlyPlayed(steamId);
    const games = Array.isArray(response?.games) ? response.games : null;

    if (!games) {
      await withTransaction(async (client) => {
        await upsertEndpointStatus(
          client,
          steamId,
          ENDPOINTS.recentlyPlayed,
          "private",
          "Steam did not return recently played data for this user."
        );
      });
    } else {
      await withTransaction(async (client) => {
        for (const game of games) {
          await upsertGameShell(client, game);
          await client.query(
            `
              INSERT INTO recently_played (
                steam_id,
                app_id,
                playtime_2weeks,
                playtime_forever,
                recent_last_fetched_at,
                last_played_at
              )
              VALUES ($1, $2, $3, $4, NOW(), $5)
              ON CONFLICT (steam_id, app_id) DO UPDATE SET
                playtime_2weeks = EXCLUDED.playtime_2weeks,
                playtime_forever = EXCLUDED.playtime_forever,
                recent_last_fetched_at = NOW(),
                last_played_at = EXCLUDED.last_played_at
            `,
            [
              steamId,
              game.appid,
              game.playtime_2weeks || 0,
              game.playtime_forever || 0,
              fromUnixSeconds(game.rtime_last_played),
            ]
          );
        }

        await upsertEndpointStatus(
          client,
          steamId,
          ENDPOINTS.recentlyPlayed,
          "available"
        );
      });
    }
  }

  const status = await getEndpointStatus(steamId, ENDPOINTS.recentlyPlayed);
  const rows = await query(
    `
      SELECT r.*, g.name, g.header_image, g.capsule_image
      FROM recently_played AS r
      JOIN games AS g ON g.app_id = r.app_id
      WHERE r.steam_id = $1
      ORDER BY r.playtime_2weeks DESC, g.name
    `,
    [steamId]
  );

  return {
    status: status?.status ?? "unknown",
    lastCheckedAt: status?.last_checked_at ?? null,
    details: status?.details ?? null,
    games: rows.rows.map(mapRecentRow),
  };
}

export async function getUserAchievementsForGame(steamId, appId) {
  await getGameDetails(appId);

  const freshness = await query(
    `
      SELECT MAX(user_achievement_last_fetched_at) AS last_fetched_at
      FROM completes
      WHERE steam_id = $1 AND app_id = $2
    `,
    [steamId, appId]
  );
  const lastFetchedAt = freshness.rows[0]?.last_fetched_at ?? null;

  if (isStale(lastFetchedAt, config.ttl.userHours)) {
    const response = await fetchPlayerAchievements(steamId, appId);
    const achievements = Array.isArray(response?.achievements)
      ? response.achievements
      : null;

    if (!achievements || response?.success === false) {
      await withTransaction(async (client) => {
        await upsertEndpointStatus(
          client,
          steamId,
          ENDPOINTS.playerAchievements,
          "private",
          "Steam did not return player achievement data for this game."
        );
      });
    } else {
      await withTransaction(async (client) => {
        await client.query(
          "DELETE FROM completes WHERE steam_id = $1 AND app_id = $2",
          [steamId, appId]
        );

        for (const achievement of achievements) {
          await client.query(
            `
              INSERT INTO completes (
                steam_id,
                app_id,
                api_name,
                achieved,
                unlock_time,
                user_achievement_last_fetched_at
              )
              VALUES ($1, $2, $3, $4, $5, NOW())
              ON CONFLICT (steam_id, app_id, api_name) DO UPDATE SET
                achieved = EXCLUDED.achieved,
                unlock_time = EXCLUDED.unlock_time,
                user_achievement_last_fetched_at = NOW()
            `,
            [
              steamId,
              appId,
              achievement.apiname,
              Boolean(achievement.achieved),
              fromUnixSeconds(achievement.unlocktime),
            ]
          );
        }

        await upsertEndpointStatus(
          client,
          steamId,
          ENDPOINTS.playerAchievements,
          "available"
        );
      });
    }
  }

  const status = await getEndpointStatus(steamId, ENDPOINTS.playerAchievements);
  const rows = await query(
    `
      SELECT
        a.app_id,
        a.api_name,
        a.display_name,
        a.description,
        a.icon,
        a.icon_gray,
        a.global_percent,
        c.achieved,
        c.unlock_time,
        c.user_achievement_last_fetched_at
      FROM achievements AS a
      LEFT JOIN completes AS c
        ON c.app_id = a.app_id
       AND c.api_name = a.api_name
       AND c.steam_id = $1
      WHERE a.app_id = $2
      ORDER BY a.display_name
    `,
    [steamId, appId]
  );

  return {
    status: status?.status ?? "unknown",
    lastCheckedAt: status?.last_checked_at ?? null,
    details: status?.details ?? null,
    achievements: rows.rows.map(mapAchievementRow),
  };
}
