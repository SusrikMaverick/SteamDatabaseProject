CREATE TABLE IF NOT EXISTS users (
    steam_id VARCHAR(32) PRIMARY KEY,
    display_name VARCHAR(255),
    avatar_url TEXT,
    profile_url TEXT,
    profile_last_fetched_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS games (
    app_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    header_image TEXT,
    capsule_image TEXT,
    short_description TEXT,
    detailed_description TEXT,
    website TEXT,
    developers JSONB,
    publishers JSONB,
    genres JSONB,
    categories JSONB,
    platforms JSONB,
    release_date TEXT,
    is_free BOOLEAN DEFAULT FALSE,
    price_overview JSONB,
    game_last_fetched_at TIMESTAMP,
    news_last_fetched_at TIMESTAMP,
    global_achievements_last_fetched_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS endpoint (
    endpoint_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS news_articles (
    gid VARCHAR(64) PRIMARY KEY,
    app_id INTEGER NOT NULL REFERENCES games(app_id) ON DELETE CASCADE,
    title TEXT,
    url TEXT,
    author TEXT,
    contents TEXT,
    feed_type INTEGER,
    published_at TIMESTAMPTZ,
    article_last_fetched_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS achievements (
    app_id INTEGER NOT NULL REFERENCES games(app_id) ON DELETE CASCADE,
    api_name VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    description TEXT,
    icon TEXT,
    icon_gray TEXT,
    global_percent DECIMAL(6, 3),
    global_stat_last_fetched_at TIMESTAMP,
    PRIMARY KEY (app_id, api_name)
);

CREATE TABLE IF NOT EXISTS owns (
    steam_id VARCHAR(32) NOT NULL REFERENCES users(steam_id) ON DELETE CASCADE,
    app_id INTEGER NOT NULL REFERENCES games(app_id) ON DELETE CASCADE,
    playtime_forever INTEGER DEFAULT 0,
    ownership_last_fetched_at TIMESTAMP,
    PRIMARY KEY (steam_id, app_id)
);

CREATE TABLE IF NOT EXISTS recently_played (
    steam_id VARCHAR(32) NOT NULL REFERENCES users(steam_id) ON DELETE CASCADE,
    app_id INTEGER NOT NULL REFERENCES games(app_id) ON DELETE CASCADE,
    playtime_2weeks INTEGER DEFAULT 0,
    playtime_forever INTEGER DEFAULT 0,
    recent_last_fetched_at TIMESTAMP,
    last_played_at TIMESTAMPTZ,
    PRIMARY KEY (steam_id, app_id)
);

CREATE TABLE IF NOT EXISTS completes (
    steam_id VARCHAR(32) NOT NULL REFERENCES users(steam_id) ON DELETE CASCADE,
    app_id INTEGER NOT NULL,
    api_name VARCHAR(255) NOT NULL,
    achieved BOOLEAN,
    unlock_time TIMESTAMPTZ,
    user_achievement_last_fetched_at TIMESTAMP,
    PRIMARY KEY (steam_id, app_id, api_name),
    FOREIGN KEY (app_id, api_name) REFERENCES achievements(app_id, api_name) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_endpoint_status (
    steam_id VARCHAR(32) NOT NULL REFERENCES users(steam_id) ON DELETE CASCADE,
    endpoint_name VARCHAR(100) NOT NULL REFERENCES endpoint(endpoint_name) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL,
    last_checked_at TIMESTAMP,
    details TEXT,
    PRIMARY KEY (steam_id, endpoint_name)
);

CREATE INDEX IF NOT EXISTS idx_games_name_lower ON games (LOWER(name));
CREATE INDEX IF NOT EXISTS idx_news_articles_app_id ON news_articles (app_id);
CREATE INDEX IF NOT EXISTS idx_news_articles_published_at ON news_articles (published_at DESC);
CREATE INDEX IF NOT EXISTS idx_achievements_app_id ON achievements (app_id);
CREATE INDEX IF NOT EXISTS idx_owns_steam_id ON owns (steam_id);
CREATE INDEX IF NOT EXISTS idx_recently_played_steam_id ON recently_played (steam_id);
CREATE INDEX IF NOT EXISTS idx_completes_lookup ON completes (steam_id, app_id);

INSERT INTO endpoint (endpoint_name)
VALUES
    ('owned_games'),
    ('recently_played'),
    ('player_achievements')
ON CONFLICT (endpoint_name) DO NOTHING;
