import { config } from "../config.js";

const STORE_SEARCH_URL = "https://store.steampowered.com/api/storesearch/";
const STORE_DETAILS_URL = "https://store.steampowered.com/api/appdetails";
const GAME_NEWS_URL =
  "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/";
const GLOBAL_ACHIEVEMENTS_URL =
  "https://api.steampowered.com/ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002/";
const PLAYER_SUMMARIES_URL =
  "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/";
const OWNED_GAMES_URL =
  "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/";
const RECENTLY_PLAYED_URL =
  "https://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/";
const PLAYER_ACHIEVEMENTS_URL =
  "https://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v0001/";

function buildUrl(baseUrl, params) {
  const url = new URL(baseUrl);

  Object.entries(params).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== "") {
      url.searchParams.set(key, String(value));
    }
  });

  return url;
}

async function fetchJson(baseUrl, params = {}, options = {}) {
  const url = buildUrl(baseUrl, params);
  const response = await fetch(url);
  const allowedStatuses = options.allowedStatuses || [];

  if (!response.ok) {
    if (allowedStatuses.includes(response.status)) {
      return null;
    }

    throw new Error(`Steam request failed with status ${response.status}`);
  }

  return response.json();
}

function ensureApiKey() {
  if (!config.steamApiKey) {
    throw new Error("STEAM_API_KEY is missing from the environment");
  }
}

export async function fetchStoreSearch(searchTerm) {
  const data = await fetchJson(STORE_SEARCH_URL, {
    term: searchTerm,
    l: "english",
    cc: "US",
  });

  return Array.isArray(data.items) ? data.items : [];
}

export async function fetchAppDetails(appId) {
  const data = await fetchJson(STORE_DETAILS_URL, {
    appids: appId,
    l: "english",
    cc: "US",
  }, {
    allowedStatuses: [403, 404],
  });

  if (!data) {
    return null;
  }

  const appData = data?.[String(appId)];
  return appData?.success ? appData.data : null;
}

export async function fetchGameNews(appId, count = 8) {
  const data = await fetchJson(GAME_NEWS_URL, {
    appid: appId,
    count,
    maxlength: 300,
    format: "json",
  }, {
    allowedStatuses: [403, 404],
  });

  if (!data) {
    return [];
  }

  return Array.isArray(data?.appnews?.newsitems) ? data.appnews.newsitems : [];
}

export async function fetchGlobalAchievements(appId) {
  const data = await fetchJson(GLOBAL_ACHIEVEMENTS_URL, {
    gameid: appId,
    format: "json",
  }, {
    allowedStatuses: [403, 404],
  });

  if (!data) {
    return [];
  }

  return Array.isArray(data?.achievementpercentages?.achievements)
    ? data.achievementpercentages.achievements
    : [];
}

export async function fetchPlayerSummary(steamId) {
  ensureApiKey();
  const data = await fetchJson(PLAYER_SUMMARIES_URL, {
    key: config.steamApiKey,
    steamids: steamId,
    format: "json",
  });

  return data?.response?.players?.[0] ?? null;
}

export async function fetchOwnedGames(steamId) {
  ensureApiKey();
  const data = await fetchJson(OWNED_GAMES_URL, {
    key: config.steamApiKey,
    steamid: steamId,
    include_appinfo: 1,
    include_played_free_games: 1,
    format: "json",
  });

  return data?.response ?? null;
}

export async function fetchRecentlyPlayed(steamId) {
  ensureApiKey();
  const data = await fetchJson(RECENTLY_PLAYED_URL, {
    key: config.steamApiKey,
    steamid: steamId,
    format: "json",
  });

  return data?.response ?? null;
}

export async function fetchPlayerAchievements(steamId, appId) {
  ensureApiKey();
  const data = await fetchJson(PLAYER_ACHIEVEMENTS_URL, {
    key: config.steamApiKey,
    steamid: steamId,
    appid: appId,
    l: "english",
    format: "json",
  }, {
    allowedStatuses: [403, 404],
  });

  if (!data) {
    return null;
  }

  return data?.playerstats ?? null;
}
