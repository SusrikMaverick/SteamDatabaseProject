import os
import sys
import time
import json
import requests
import psycopg2
from psycopg2.extras import Json
from datetime import date
from dotenv import load_dotenv
from tqdm import tqdm

load_dotenv()

STEAM_API_KEY = os.getenv("STEAM_API_KEY")
DB_CONFIG = {
    "dbname": os.getenv("DB_NAME", "steam_db"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST", "localhost"),
    "port": os.getenv("DB_PORT", "5432"),
}

STEAMSPY_URL = "https://steamspy.com/api.php"
STEAM_STORE_URL = "https://store.steampowered.com/api/appdetails"
STEAM_PLAYERS_URL = (
    "https://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1"
)

CREATE_TABLE_SQL = """
CREATE TABLE IF NOT EXISTS steam_games (
    app_id              INTEGER PRIMARY KEY,
    name                TEXT,
    type                TEXT,
    developer           TEXT,
    publisher           TEXT,
    release_date        TEXT,
    short_description   TEXT,
    header_image        TEXT,
    website             TEXT,
    required_age        INTEGER DEFAULT 0,
    is_free             BOOLEAN DEFAULT FALSE,
    price               INTEGER,
    initial_price       INTEGER,
    discount_percent    INTEGER DEFAULT 0,
    metacritic_score    INTEGER,
    metacritic_url      TEXT,
    categories          JSONB,
    genres              JSONB,
    tags                JSONB,
    platforms_windows   BOOLEAN DEFAULT FALSE,
    platforms_mac       BOOLEAN DEFAULT FALSE,
    platforms_linux     BOOLEAN DEFAULT FALSE,
    supported_languages TEXT,
    estimated_owners    TEXT,
    positive_reviews    INTEGER DEFAULT 0,
    negative_reviews    INTEGER DEFAULT 0,
    review_score        REAL,
    current_players     INTEGER,
    ccu                 INTEGER,
    peak_ccu            INTEGER,
    peak_ccu_date       DATE,
    average_playtime_forever INTEGER DEFAULT 0,
    median_playtime_forever  INTEGER DEFAULT 0,
    average_playtime_2weeks  INTEGER DEFAULT 0,
    median_playtime_2weeks   INTEGER DEFAULT 0,
    last_updated        TIMESTAMP DEFAULT NOW()
);
"""

UPSERT_SQL = """
INSERT INTO steam_games (
    app_id, name, type, developer, publisher, release_date,
    short_description, header_image, website, required_age,
    is_free, price, initial_price, discount_percent,
    metacritic_score, metacritic_url,
    categories, genres, tags,
    platforms_windows, platforms_mac, platforms_linux,
    supported_languages, estimated_owners,
    positive_reviews, negative_reviews, review_score,
    current_players, ccu, peak_ccu, peak_ccu_date,
    average_playtime_forever, median_playtime_forever,
    average_playtime_2weeks, median_playtime_2weeks,
    last_updated
) VALUES (
    %(app_id)s, %(name)s, %(type)s, %(developer)s, %(publisher)s, %(release_date)s,
    %(short_description)s, %(header_image)s, %(website)s, %(required_age)s,
    %(is_free)s, %(price)s, %(initial_price)s, %(discount_percent)s,
    %(metacritic_score)s, %(metacritic_url)s,
    %(categories)s, %(genres)s, %(tags)s,
    %(platforms_windows)s, %(platforms_mac)s, %(platforms_linux)s,
    %(supported_languages)s, %(estimated_owners)s,
    %(positive_reviews)s, %(negative_reviews)s, %(review_score)s,
    %(current_players)s, %(ccu)s, %(peak_ccu)s, %(peak_ccu_date)s,
    %(average_playtime_forever)s, %(median_playtime_forever)s,
    %(average_playtime_2weeks)s, %(median_playtime_2weeks)s,
    NOW()
)
ON CONFLICT (app_id) DO UPDATE SET
    name = EXCLUDED.name,
    type = EXCLUDED.type,
    developer = EXCLUDED.developer,
    publisher = EXCLUDED.publisher,
    release_date = EXCLUDED.release_date,
    short_description = EXCLUDED.short_description,
    header_image = EXCLUDED.header_image,
    website = EXCLUDED.website,
    required_age = EXCLUDED.required_age,
    is_free = EXCLUDED.is_free,
    price = EXCLUDED.price,
    initial_price = EXCLUDED.initial_price,
    discount_percent = EXCLUDED.discount_percent,
    metacritic_score = EXCLUDED.metacritic_score,
    metacritic_url = EXCLUDED.metacritic_url,
    categories = EXCLUDED.categories,
    genres = EXCLUDED.genres,
    tags = EXCLUDED.tags,
    platforms_windows = EXCLUDED.platforms_windows,
    platforms_mac = EXCLUDED.platforms_mac,
    platforms_linux = EXCLUDED.platforms_linux,
    supported_languages = EXCLUDED.supported_languages,
    estimated_owners = EXCLUDED.estimated_owners,
    positive_reviews = EXCLUDED.positive_reviews,
    negative_reviews = EXCLUDED.negative_reviews,
    review_score = EXCLUDED.review_score,
    current_players = EXCLUDED.current_players,
    ccu = EXCLUDED.ccu,
    peak_ccu = GREATEST(steam_games.peak_ccu, EXCLUDED.peak_ccu),
    peak_ccu_date = CASE
        WHEN EXCLUDED.peak_ccu > COALESCE(steam_games.peak_ccu, 0)
        THEN EXCLUDED.peak_ccu_date
        ELSE steam_games.peak_ccu_date
    END,
    average_playtime_forever = EXCLUDED.average_playtime_forever,
    median_playtime_forever = EXCLUDED.median_playtime_forever,
    average_playtime_2weeks = EXCLUDED.average_playtime_2weeks,
    median_playtime_2weeks = EXCLUDED.median_playtime_2weeks,
    last_updated = NOW()
"""


def create_table(conn):
    with conn.cursor() as cur:
        cur.execute(CREATE_TABLE_SQL)
    conn.commit()


def fetch_top_games(count=1000):
    print("Fetching full game list from SteamSpy (may take a moment)...")
    resp = requests.get(STEAMSPY_URL, params={"request": "all"}, timeout=120)
    resp.raise_for_status()
    all_games = resp.json()

    sorted_games = sorted(
        all_games.values(), key=lambda g: g.get("ccu", 0), reverse=True
    )
    top = sorted_games[:count]
    print(f"Selected top {len(top)} games by concurrent players.\n")
    return top


def fetch_store_details(app_id):
    try:
        resp = requests.get(
            STEAM_STORE_URL, params={"appids": app_id, "l": "english"}, timeout=15
        )
        if resp.status_code != 200:
            return None
        data = resp.json()
        entry = data.get(str(app_id), {})
        if entry.get("success"):
            return entry["data"]
    except Exception:
        pass
    return None


def fetch_current_players(app_id):
    try:
        resp = requests.get(
            STEAM_PLAYERS_URL,
            params={"appid": app_id, "key": STEAM_API_KEY},
            timeout=10,
        )
        if resp.status_code != 200:
            return None
        return resp.json().get("response", {}).get("player_count")
    except Exception:
        return None


def safe_int(value, default=0):
    if value is None:
        return default
    try:
        return int(value)
    except (ValueError, TypeError):
        return default


def build_record(spy, store, current_players):
    app_id = spy["appid"]
    today = date.today()

    positive = spy.get("positive", 0) or 0
    negative = spy.get("negative", 0) or 0
    total = positive + negative
    review_score = round(positive / total * 100, 2) if total > 0 else None

    ccu = spy.get("ccu", 0) or 0
    peak_ccu = max(ccu, current_players or 0)

    record = {
        "app_id": app_id,
        "name": spy.get("name"),
        "type": None,
        "developer": spy.get("developer"),
        "publisher": spy.get("publisher"),
        "release_date": None,
        "short_description": None,
        "header_image": None,
        "website": None,
        "required_age": 0,
        "is_free": False,
        "price": spy.get("price"),
        "initial_price": spy.get("initialprice"),
        "discount_percent": spy.get("discount", 0),
        "metacritic_score": None,
        "metacritic_url": None,
        "categories": None,
        "genres": None,
        "tags": Json(spy.get("tags")) if spy.get("tags") else None,
        "platforms_windows": False,
        "platforms_mac": False,
        "platforms_linux": False,
        "supported_languages": None,
        "estimated_owners": spy.get("owners"),
        "positive_reviews": positive,
        "negative_reviews": negative,
        "review_score": review_score,
        "current_players": current_players,
        "ccu": ccu,
        "peak_ccu": peak_ccu,
        "peak_ccu_date": today,
        "average_playtime_forever": spy.get("average_forever", 0) or 0,
        "median_playtime_forever": spy.get("median_forever", 0) or 0,
        "average_playtime_2weeks": spy.get("average_2weeks", 0) or 0,
        "median_playtime_2weeks": spy.get("median_2weeks", 0) or 0,
    }

    if store:
        record["name"] = store.get("name", record["name"])
        record["type"] = store.get("type")

        devs = store.get("developers", [])
        pubs = store.get("publishers", [])
        if devs:
            record["developer"] = ", ".join(devs)
        if pubs:
            record["publisher"] = ", ".join(pubs)

        record["release_date"] = store.get("release_date", {}).get("date")
        record["short_description"] = store.get("short_description")
        record["header_image"] = store.get("header_image")
        record["website"] = store.get("website")
        record["required_age"] = safe_int(store.get("required_age"))
        record["is_free"] = store.get("is_free", False)

        price_info = store.get("price_overview")
        if price_info:
            record["price"] = price_info.get("final")
            record["initial_price"] = price_info.get("initial")
            record["discount_percent"] = price_info.get("discount_percent", 0)

        mc = store.get("metacritic")
        if mc:
            record["metacritic_score"] = mc.get("score")
            record["metacritic_url"] = mc.get("url")

        cats = store.get("categories", [])
        if cats:
            record["categories"] = Json([c["description"] for c in cats])
        gens = store.get("genres", [])
        if gens:
            record["genres"] = Json([g["description"] for g in gens])

        plats = store.get("platforms", {})
        record["platforms_windows"] = plats.get("windows", False)
        record["platforms_mac"] = plats.get("mac", False)
        record["platforms_linux"] = plats.get("linux", False)
        record["supported_languages"] = store.get("supported_languages")

    return record


def main():
    if not STEAM_API_KEY or STEAM_API_KEY == "your_steam_api_key_here":
        print("ERROR: Set your STEAM_API_KEY in the .env file.")
        sys.exit(1)
    if not DB_CONFIG["password"] or DB_CONFIG["password"] == "your_password_here":
        print("ERROR: Set your DB_PASSWORD in the .env file.")
        sys.exit(1)

    conn = psycopg2.connect(**DB_CONFIG)
    create_table(conn)
    print("Database table ready.")

    spy_games = fetch_top_games(1000)

    success = 0
    failed = 0

    with conn.cursor() as cur:
        for spy in tqdm(spy_games, desc="Fetching game details"):
            app_id = spy["appid"]

            store = fetch_store_details(app_id)
            time.sleep(1.5)

            current_players = fetch_current_players(app_id)
            time.sleep(0.3)

            record = build_record(spy, store, current_players)

            try:
                cur.execute("SAVEPOINT sp")
                cur.execute(UPSERT_SQL, record)
                cur.execute("RELEASE SAVEPOINT sp")
                success += 1
            except Exception as e:
                cur.execute("ROLLBACK TO SAVEPOINT sp")
                failed += 1
                tqdm.write(f"  Failed app {app_id} ({spy.get('name')}): {e}")

            if success % 50 == 0 and success > 0:
                conn.commit()

    conn.commit()
    conn.close()

    print(f"\nDone! {success} games stored, {failed} failed.")
    print("Run this script again anytime to update data and track peak players.")


if __name__ == "__main__":
    main()
