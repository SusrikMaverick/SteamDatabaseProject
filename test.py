import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    "dbname": os.getenv("DB_NAME", "steam_db"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST", "localhost"),
    "port": os.getenv("DB_PORT", "5432"),
}

EXPECTED_COLUMNS = [
    "app_id", "name", "type", "developer", "publisher", "release_date",
    "short_description", "header_image", "website", "required_age",
    "is_free", "price", "initial_price", "discount_percent",
    "metacritic_score", "metacritic_url", "categories", "genres", "tags",
    "platforms_windows", "platforms_mac", "platforms_linux",
    "supported_languages", "estimated_owners",
    "positive_reviews", "negative_reviews", "review_score",
    "current_players", "ccu", "peak_ccu", "peak_ccu_date",
    "average_playtime_forever", "median_playtime_forever",
    "average_playtime_2weeks", "median_playtime_2weeks", "last_updated",
]

passed = 0
failed = 0


def test(name, condition, detail=""):
    global passed, failed
    if condition:
        passed += 1
        print(f"  PASS: {name}")
    else:
        failed += 1
        msg = f"  FAIL: {name}"
        if detail:
            msg += f" -- {detail}"
        print(msg)


def run_tests():
    # --- Test 1: Database connection ---
    print("\n[Connection]")
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor()
        test("Can connect to database", True)
    except Exception as e:
        test("Can connect to database", False, str(e))
        return

    # --- Test 2: Table exists ---
    print("\n[Table Structure]")
    cur.execute("""
        SELECT EXISTS (
            SELECT 1 FROM information_schema.tables
            WHERE table_name = 'steam_games'
        )
    """)
    test("steam_games table exists", cur.fetchone()[0])

    # --- Test 3: All expected columns present ---
    cur.execute("""
        SELECT column_name FROM information_schema.columns
        WHERE table_name = 'steam_games'
    """)
    actual_columns = {row[0] for row in cur.fetchall()}
    missing = set(EXPECTED_COLUMNS) - actual_columns
    test("All expected columns present", len(missing) == 0,
         f"missing: {missing}" if missing else "")

    # --- Test 4: Row count ---
    print("\n[Data Integrity]")
    cur.execute("SELECT COUNT(*) FROM steam_games")
    count = cur.fetchone()[0]
    test(f"Has data ({count} rows)", count > 0)
    test("Has close to 1000 games", count >= 900,
         f"only {count} rows" if count < 900 else "")

    # --- Test 5: No null app_id or name ---
    cur.execute("SELECT COUNT(*) FROM steam_games WHERE app_id IS NULL")
    test("No null app_id", cur.fetchone()[0] == 0)

    cur.execute("SELECT COUNT(*) FROM steam_games WHERE name IS NULL")
    null_names = cur.fetchone()[0]
    test("No null names", null_names == 0,
         f"{null_names} rows with null name" if null_names else "")

    # --- Test 6: Review score range ---
    cur.execute("""
        SELECT COUNT(*) FROM steam_games
        WHERE review_score IS NOT NULL AND (review_score < 0 OR review_score > 100)
    """)
    test("Review scores between 0-100", cur.fetchone()[0] == 0)

    # --- Test 7: Peak CCU >= CCU ---
    cur.execute("""
        SELECT COUNT(*) FROM steam_games
        WHERE peak_ccu IS NOT NULL AND ccu IS NOT NULL AND peak_ccu < ccu
    """)
    bad_peaks = cur.fetchone()[0]
    test("peak_ccu >= ccu for all rows", bad_peaks == 0,
         f"{bad_peaks} rows where peak < ccu" if bad_peaks else "")

    # --- Test 8: Positive/negative reviews are non-negative ---
    cur.execute("""
        SELECT COUNT(*) FROM steam_games
        WHERE positive_reviews < 0 OR negative_reviews < 0
    """)
    test("No negative review counts", cur.fetchone()[0] == 0)

    # --- Test 9: At least some games have store data ---
    print("\n[Store API Coverage]")
    cur.execute("SELECT COUNT(*) FROM steam_games WHERE release_date IS NOT NULL")
    with_date = cur.fetchone()[0]
    test(f"Games with release_date: {with_date}/{count}", with_date > count * 0.5)

    cur.execute("SELECT COUNT(*) FROM steam_games WHERE developer IS NOT NULL")
    with_dev = cur.fetchone()[0]
    test(f"Games with developer: {with_dev}/{count}", with_dev > count * 0.8)

    cur.execute("SELECT COUNT(*) FROM steam_games WHERE genres IS NOT NULL")
    with_genres = cur.fetchone()[0]
    test(f"Games with genres: {with_genres}/{count}", with_genres > count * 0.5)

    cur.execute("SELECT COUNT(*) FROM steam_games WHERE metacritic_score IS NOT NULL")
    with_mc = cur.fetchone()[0]
    print(f"  INFO: Games with metacritic score: {with_mc}/{count}")

    # --- Test 10: Sample a few top games ---
    print("\n[Sample Data - Top 5 by peak_ccu]")
    cur.execute("""
        SELECT app_id, name, developer, peak_ccu, review_score, release_date
        FROM steam_games
        ORDER BY peak_ccu DESC NULLS LAST
        LIMIT 5
    """)
    rows = cur.fetchall()
    for row in rows:
        app_id, name, dev, peak, score, rdate = row
        print(f"  {name} | dev: {dev} | peak: {peak} | score: {score} | released: {rdate}")
    test("Top 5 query returned results", len(rows) == 5)

    cur.close()
    conn.close()

    # --- Summary ---
    total = passed + failed
    print(f"\n{'='*40}")
    print(f"Results: {passed}/{total} passed, {failed} failed")
    print(f"{'='*40}")


if __name__ == "__main__":
    run_tests()
