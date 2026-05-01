# User Manual

## Overview

Steam Insight is a web application for searching Steam games and viewing:

- recent news about a game
- global achievement completion percentages
- Steam profile details after login
- owned games
- recently played games
- personal achievement completion for a game

## Requirements

- Node.js 22+
- npm 10+
- PostgreSQL 14+
- Steam Web API key

## Setup

1. Open a terminal in `/Users/juan/Downloads/SteamDatabaseProject-main-2`.
2. Copy `.env.example` to `.env`.
3. Fill in the Steam API key and PostgreSQL connection settings.
4. Set `HOST=127.0.0.1` for local development if it is not already set.
5. Set `STEAM_REALM=http://127.0.0.1:3001` and `STEAM_RETURN_URL=http://127.0.0.1:3001/auth/steam/return`.
6. Set `DB_USER` to your local PostgreSQL role. On many Homebrew macOS setups this is your macOS username.
7. Leave `DB_PASSWORD=` blank if your local role does not use a password.
8. Run `npm install`.
9. Create the PostgreSQL database.
10. Run `npm run db:init`.

## Starting the App

Start the backend:

```bash
npm run dev:server
```

Start the frontend in a second terminal:

```bash
npm run dev:client
```

Open `http://localhost:5173`.

## How To Use the Application

### 1. Search as a Guest

1. Open the home page.
2. Enter a game name in the search bar.
3. Click `Search`.
4. Select a game from the results.

Screenshot to add:

- Home page with a search term entered
- Search results grid

### 2. View Game Details

On the game details page, the user can:

- read the game's summary
- open recent news articles
- inspect global achievement percentages

Screenshot to add:

- Game details page
- News section
- Achievement section

### 3. Log In With Steam

1. Click `Log in with Steam`.
2. Complete the Steam OpenID login flow.
3. Return to the dashboard.

Screenshot to add:

- Dashboard after successful login

### 4. View Owned Games

The dashboard shows the user's owned games sorted by playtime.

Screenshot to add:

- Owned games section

### 5. View Recently Played Games

The dashboard also shows recently played games from Steam when the user's
privacy settings allow it.

Screenshot to add:

- Recently played section

### 6. View Personal Achievement Progress

1. From the dashboard, click `My achievements` for a game.
2. Review unlocked vs. locked achievements.
3. Compare the user's progress against the global completion percentage.

Screenshot to add:

- Personal achievements page

## Privacy and Access Notes

Some Steam user data may be unavailable because of account privacy settings.
When that happens, the app keeps a cached status record and shows the user that
the endpoint was private or unavailable instead of failing silently.

## Troubleshooting

### The frontend does not load

- Confirm `npm run dev:client` is running
- Confirm the browser is opening `http://localhost:5173`

### The backend does not load

- Confirm `npm run dev:server` is running
- Confirm the `.env` file exists and PostgreSQL is reachable

### Steam login fails

- Verify `STEAM_REALM`
- Verify `STEAM_RETURN_URL`
- Prefer `127.0.0.1` instead of mixing `localhost` and `127.0.0.1`
- Verify the Steam API key

### No owned games or achievements appear

- Check Steam privacy settings
- Confirm the Steam account exposes those endpoints

## Database Dump for Submission

After the database is populated, generate a final dump with:

```bash
pg_dump -U your_local_postgres_role -d steam_webapp > steam_webapp_final_dump.sql
```

Include that dump file in the final submission or repository.
