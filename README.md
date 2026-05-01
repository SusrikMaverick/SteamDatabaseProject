# Steam Insight Web App

Steam Insight is a full-stack web application for searching Steam games and exploring:

- recent game news
- global achievement completion rates
- Steam profile information
- owned games
- recently played games
- per-game user achievement completion

The app supports guest browsing and logged-in Steam users. Steam API responses
are cached in PostgreSQL and refreshed with TTL-based policies to reduce
duplicate requests and keep the UI responsive.

## Tech Stack

- React + Vite frontend
- Node.js + Express backend
- Steam OpenID authentication with `passport-steam`
- PostgreSQL database

## Project Structure

```text
client/   React frontend
server/   Express backend and Steam API integration
db/       PostgreSQL schema
docs/     Additional documentation
```

## Features

### Guest Features

- Search for Steam games
- Open a game details page
- View recent news for a game
- View global achievement completion percentages

### Logged-In Features

- Sign in with Steam
- View cached Steam profile details
- View owned games
- View recently played games
- View personal achievement completion for a selected game
- View cached status for privacy-restricted Steam endpoints

## Prerequisites

- Node.js 22+
- npm 10+
- PostgreSQL
- Steam Web API key

## Environment Setup

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Set these values in `.env`:

```env
PORT=3001
HOST=127.0.0.1
CLIENT_URL=http://localhost:5173
SESSION_SECRET=replace_me_with_a_long_random_string

STEAM_API_KEY=your_steam_web_api_key
STEAM_REALM=http://127.0.0.1:3001
STEAM_RETURN_URL=http://127.0.0.1:3001/auth/steam/return

DB_HOST=localhost
DB_PORT=5432
DB_NAME=steam_webapp
DB_USER=your_local_postgres_role
DB_PASSWORD=
```

Notes:

- `DB_USER` should be a PostgreSQL role that exists on your machine.
- On many local PostgreSQL setups, the default role is your local system username rather than `postgres`.
- Leave `DB_PASSWORD` blank if your local PostgreSQL role does not use a password.

## Install Dependencies

From the project root:

```bash
npm install
```

## Database Setup

Start PostgreSQL if it is not already running. The exact command depends on how
PostgreSQL was installed on your machine.

Create the app database:

```bash
createdb -h 127.0.0.1 -p 5432 -U your_local_postgres_role steam_webapp
```

If the database already exists, continue to the next step.

Initialize the schema:

```bash
npm run db:init
```

The schema is defined in [db/schema.sql].

## Running the App

Use two terminals from the project root.

Terminal 1:

```bash
npm run dev:server
```

Terminal 2:

```bash
npm run dev:client
```

Then open:

[http://localhost:5173](http://localhost:5173)

## Build

To create a production build:

```bash
npm run build
```

## Main Routes

### Frontend

- `/` search and discovery
- `/games/:appId` game details, news, and global achievements
- `/dashboard` logged-in profile, owned games, and recently played
- `/dashboard/games/:appId/achievements` personal achievement progress

### Backend API

- `GET /api/health`
- `GET /api/games/search?q=...`
- `GET /api/games/:appId`
- `GET /api/me`
- `GET /api/me/owned-games`
- `GET /api/me/recently-played`
- `GET /api/me/games/:appId/achievements`
- `GET /auth/steam`
- `GET /auth/steam/return`
- `POST /auth/logout`

## Troubleshooting

### PostgreSQL connection fails

- Verify that PostgreSQL is running
- Verify that `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT`, and `DB_NAME` are correct
- Verify that the specified PostgreSQL role exists locally

### Steam login fails

- Verify `STEAM_API_KEY`
- Verify `STEAM_REALM`
- Verify `STEAM_RETURN_URL`
- Keep the backend callback values consistent with `127.0.0.1`

### Logged-in data is missing

- Check the Steam account privacy settings
- Some Steam endpoints may not return owned games, recently played games, or player achievements if the account is private
