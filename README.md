# Steam Database - Top 1000 Games

Fetches the top 1000 most popular Steam games and stores them in a PostgreSQL database with detailed info: developer, publisher, release date, reviews, concurrent players, genres, tags, metacritic scores, and more.

Data is pulled from **SteamSpy**, the **Steam Store API**, and the **Steam Web API**.

## Setup

### 1. Create a virtual environment and install dependencies

```bash
python -m venv .venv
.venv\Scripts\activate        # Windows
# source .venv/bin/activate   # Macintosh/Linux
pip install -r requirements.txt
```

### 2. Create the `.env` file

Create a `.env` file in the project root with:

```
STEAM_API_KEY=your_steam_api_key_here
DB_NAME=your_database_name
DB_USER=postgres
DB_PASSWORD=your_postgres_password
DB_HOST=localhost
DB_PORT=5432
```

- `STEAM_API_KEY` — get one at [https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey)
- `DB_NAME` — name of your PostgreSQL database (create it beforehand with `CREATE DATABASE your_database_name;`)
- `DB_USER` — your PostgreSQL username (default: `postgres`)
- `DB_PASSWORD` — your PostgreSQL password
- `DB_HOST` — database host (default: `localhost`)
- `DB_PORT` — database port (default: `5432`)

### 3. Run the script

```bash
python steam_api_handler.py
```

The table is created automatically on first run. Takes ~30 minutes due to Steam API rate limits. A progress bar shows status.

Re-running the script updates all data and tracks peak concurrent players over time.

### 4. Run tests (for testing, don't show instructor)

```bash
python test.py
```

Validates the database: checks table structure, data integrity, review score ranges, and prints the top 5 games.

## Importing the database dump

If a `steam_games_dump.sql` file is included, you can import it directly instead of running the fetcher:

```bash
psql -U postgres -d your_database_name < steam_games_dump.sql
```

