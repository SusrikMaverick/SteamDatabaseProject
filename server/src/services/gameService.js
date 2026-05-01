import { config } from "../config.js";
import { isStale, fromUnixSeconds } from "../lib/cache.js";
import { query, withTransaction } from "../lib/db.js";
import {
  fetchAppDetails,
  fetchGameNews,
  fetchGlobalAchievements,
  fetchStoreSearch,
} from "../lib/steamApi.js";

function normalizeSearchItem(item) {
  return {
    appId: item.id,
    name: item.name,
    imageUrl: item.tiny_image || null,
    isFree: Boolean(item.is_free),
    price: item.price ? { final: item.price.final, initial: item.price.initial } : null,
  };
}

async function filterStoreItemsToGames(items, limit = 12) {
  const candidates = items.slice(0, Math.max(limit * 2, limit));
  const settled = await Promise.allSettled(
    candidates.map(async (item) => {
      const details = await fetchAppDetails(item.id);
      return {
        item,
        details,
      };
    })
  );

  const filtered = [];

  for (const result of settled) {
    if (result.status !== "fulfilled") {
      continue;
    }

    const { item, details } = result.value;

    if (details?.type === "game") {
      filtered.push(item);
    }

    if (filtered.length >= limit) {
      break;
    }
  }

  return filtered;
}

function mapGame(row) {
  if (!row) {
    return null;
  }

  return {
    appId: row.app_id,
    name: row.name,
    headerImage: row.header_image,
    capsuleImage: row.capsule_image,
    shortDescription: row.short_description,
    developers: row.developers ?? [],
    publishers: row.publishers ?? [],
    genres: row.genres ?? [],
    categories: row.categories ?? [],
    platforms: row.platforms ?? {},
    releaseDate: row.release_date,
    isFree: row.is_free,
    priceOverview: row.price_overview,
    lastFetchedAt: row.game_last_fetched_at,
  };
}

function mapArticle(row) {
  return {
    gid: row.gid,
    title: row.title,
    url: row.url,
    author: row.author,
    contents: row.contents,
    feedType: row.feed_type,
    publishedAt: row.published_at,
  };
}

function mapAchievement(row) {
  return {
    apiName: row.api_name,
    displayName: row.display_name,
    description: row.description,
    icon: row.icon,
    iconGray: row.icon_gray,
    globalPercent: row.global_percent,
    lastFetchedAt: row.global_stat_last_fetched_at,
  };
}

async function cacheSearchResults(items) {
  if (!items.length) {
    return;
  }

  await withTransaction(async (client) => {
    for (const item of items) {
      await client.query(
        `
          INSERT INTO games (
            app_id,
            name,
            capsule_image,
            is_free,
            price_overview
          )
          VALUES ($1, $2, $3, $4, $5)
          ON CONFLICT (app_id) DO UPDATE SET
            name = EXCLUDED.name,
            capsule_image = COALESCE(EXCLUDED.capsule_image, games.capsule_image),
            is_free = EXCLUDED.is_free,
            price_overview = COALESCE(EXCLUDED.price_overview, games.price_overview)
        `,
        [
          item.id,
          item.name,
          item.tiny_image || null,
          Boolean(item.is_free),
          item.price ? JSON.stringify(item.price) : null,
        ]
      );
    }
  });
}

async function refreshGame(appId, existingRow = null) {
  let details = null;

  try {
    details = await fetchAppDetails(appId);
  } catch (error) {
    if (existingRow) {
      return existingRow;
    }

    throw error;
  }

  if (!details) {
    if (existingRow) {
      await query(
        "UPDATE games SET game_last_fetched_at = NOW() WHERE app_id = $1",
        [appId]
      );
      const refreshed = await query("SELECT * FROM games WHERE app_id = $1", [appId]);
      return refreshed.rows[0];
    }

    return null;
  }

  await query(
    `
      INSERT INTO games (
        app_id,
        name,
        header_image,
        capsule_image,
        short_description,
        detailed_description,
        website,
        developers,
        publishers,
        genres,
        categories,
        platforms,
        release_date,
        is_free,
        price_overview,
        game_last_fetched_at
      )
      VALUES (
        $1, $2, $3, $4, $5, $6, $7,
        $8::jsonb, $9::jsonb, $10::jsonb, $11::jsonb, $12::jsonb, $13, $14, $15::jsonb, NOW()
      )
      ON CONFLICT (app_id) DO UPDATE SET
        name = EXCLUDED.name,
        header_image = EXCLUDED.header_image,
        capsule_image = COALESCE(EXCLUDED.capsule_image, games.capsule_image),
        short_description = EXCLUDED.short_description,
        detailed_description = EXCLUDED.detailed_description,
        website = EXCLUDED.website,
        developers = EXCLUDED.developers,
        publishers = EXCLUDED.publishers,
        genres = EXCLUDED.genres,
        categories = EXCLUDED.categories,
        platforms = EXCLUDED.platforms,
        release_date = EXCLUDED.release_date,
        is_free = EXCLUDED.is_free,
        price_overview = EXCLUDED.price_overview,
        game_last_fetched_at = NOW()
    `,
    [
      appId,
      details.name,
      details.header_image || null,
      details.capsule_image || null,
      details.short_description || null,
      details.detailed_description || null,
      details.website || null,
      JSON.stringify(details.developers || []),
      JSON.stringify(details.publishers || []),
      JSON.stringify(details.genres || []),
      JSON.stringify(details.categories || []),
      JSON.stringify(details.platforms || {}),
      details.release_date?.date || null,
      Boolean(details.is_free),
      JSON.stringify(details.price_overview || null),
    ]
  );

  const refreshed = await query("SELECT * FROM games WHERE app_id = $1", [appId]);
  return refreshed.rows[0];
}

async function refreshNews(appId) {
  const newsItems = await fetchGameNews(appId);

  await withTransaction(async (client) => {
    for (const item of newsItems) {
      await client.query(
        `
          INSERT INTO news_articles (
            gid,
            app_id,
            title,
            url,
            author,
            contents,
            feed_type,
            published_at,
            article_last_fetched_at
          )
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW())
          ON CONFLICT (gid) DO UPDATE SET
            title = EXCLUDED.title,
            url = EXCLUDED.url,
            author = EXCLUDED.author,
            contents = EXCLUDED.contents,
            feed_type = EXCLUDED.feed_type,
            published_at = EXCLUDED.published_at,
            article_last_fetched_at = NOW()
        `,
        [
          item.gid,
          appId,
          item.title || null,
          item.url || null,
          item.author || null,
          item.contents || null,
          item.feed_type ?? null,
          fromUnixSeconds(item.date),
        ]
      );
    }

    await client.query(
      "UPDATE games SET news_last_fetched_at = NOW() WHERE app_id = $1",
      [appId]
    );
  });
}

async function refreshGlobalAchievements(appId) {
  const achievements = await fetchGlobalAchievements(appId);

  await withTransaction(async (client) => {
    for (const item of achievements) {
      await client.query(
        `
          INSERT INTO achievements (
            app_id,
            api_name,
            display_name,
            description,
            icon,
            icon_gray,
            global_percent,
            global_stat_last_fetched_at
          )
          VALUES ($1, $2, $3, $4, $5, $6, $7, NOW())
          ON CONFLICT (app_id, api_name) DO UPDATE SET
            display_name = COALESCE(EXCLUDED.display_name, achievements.display_name),
            description = COALESCE(EXCLUDED.description, achievements.description),
            icon = COALESCE(EXCLUDED.icon, achievements.icon),
            icon_gray = COALESCE(EXCLUDED.icon_gray, achievements.icon_gray),
            global_percent = EXCLUDED.global_percent,
            global_stat_last_fetched_at = NOW()
        `,
        [
          appId,
          item.name,
          item.displayName || item.name,
          item.description || null,
          item.icon || null,
          item.icongray || null,
          item.percent ?? null,
        ]
      );
    }

    await client.query(
      `
        UPDATE games
        SET global_achievements_last_fetched_at = NOW()
        WHERE app_id = $1
      `,
      [appId]
    );
  });
}

export async function searchGames(searchTerm) {
  const trimmed = searchTerm.trim();

  if (!trimmed) {
    return [];
  }

  try {
    const storeItems = await fetchStoreSearch(trimmed);
    const filteredItems = await filterStoreItemsToGames(storeItems, 12);
    await cacheSearchResults(filteredItems);
    return filteredItems.map(normalizeSearchItem);
  } catch (error) {
    const fallback = await query(
      `
        SELECT app_id, name, capsule_image, is_free, price_overview
        FROM games
        WHERE name ILIKE $1
        ORDER BY name
        LIMIT 12
      `,
      [`%${trimmed}%`]
    );

    return fallback.rows.map((row) => ({
      appId: row.app_id,
      name: row.name,
      imageUrl: row.capsule_image,
      isFree: row.is_free,
      price: row.price_overview,
    }));
  }
}

export async function getGameDetails(appId) {
  const currentResult = await query("SELECT * FROM games WHERE app_id = $1", [appId]);
  let gameRow = currentResult.rows[0] ?? null;

  const needsFullRefresh =
    !gameRow ||
    !gameRow.short_description ||
    !gameRow.header_image ||
    isStale(gameRow.game_last_fetched_at, config.ttl.gameHours);

  if (needsFullRefresh) {
    gameRow = await refreshGame(appId, gameRow);
  }

  if (!gameRow) {
    return null;
  }

  if (isStale(gameRow.news_last_fetched_at, config.ttl.newsHours)) {
    try {
      await refreshNews(appId);
    } catch (error) {
      console.warn(`Unable to refresh news for app ${appId}:`, error.message);
    }
  }

  if (
    isStale(
      gameRow.global_achievements_last_fetched_at,
      config.ttl.achievementHours
    )
  ) {
    try {
      await refreshGlobalAchievements(appId);
    } catch (error) {
      console.warn(
        `Unable to refresh global achievements for app ${appId}:`,
        error.message
      );
    }
  }

  const [freshGame, articles, achievements] = await Promise.all([
    query("SELECT * FROM games WHERE app_id = $1", [appId]),
    query(
      `
        SELECT *
        FROM news_articles
        WHERE app_id = $1
        ORDER BY published_at DESC NULLS LAST
        LIMIT 10
      `,
      [appId]
    ),
    query(
      `
        SELECT *
        FROM achievements
        WHERE app_id = $1
        ORDER BY global_percent DESC NULLS LAST, display_name
      `,
      [appId]
    ),
  ]);

  return {
    game: mapGame(freshGame.rows[0]),
    news: articles.rows.map(mapArticle),
    achievements: achievements.rows.map(mapAchievement),
  };
}
