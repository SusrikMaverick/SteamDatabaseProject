import { useEffect, useState } from "react";
import { useSearchParams } from "react-router-dom";
import { apiRequest } from "../api.js";
import { GameCard } from "../components/GameCard.jsx";
import { SectionCard } from "../components/SectionCard.jsx";

export function HomePage({ viewerState }) {
  const [searchParams, setSearchParams] = useSearchParams();
  const [query, setQuery] = useState(searchParams.get("q") || "");
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    const currentQuery = searchParams.get("q");

    if (!currentQuery) {
      setResults([]);
      return;
    }

    let cancelled = false;
    setLoading(true);
    setError("");

    apiRequest(`/api/games/search?q=${encodeURIComponent(currentQuery)}`)
      .then((payload) => {
        if (!cancelled) {
          setResults(payload.results || []);
        }
      })
      .catch((requestError) => {
        if (!cancelled) {
          setError(requestError.message);
        }
      })
      .finally(() => {
        if (!cancelled) {
          setLoading(false);
        }
      });

    return () => {
      cancelled = true;
    };
  }, [searchParams]);

  function handleSubmit(event) {
    event.preventDefault();
    const nextQuery = query.trim();

    if (!nextQuery) {
      setSearchParams({});
      return;
    }

    setSearchParams({ q: nextQuery });
  }

  return (
    <div className="stack-lg">
      <section className="hero-panel">
        <div className="hero-copy">
          <div className="eyebrow">Guest mode</div>
          <h1>Search any Steam game and inspect live news plus global achievement stats.</h1>
          <p>
            Browse as a guest, then log in with Steam to unlock your own library,
            recently played games, and per-game achievement completion.
          </p>

          <form className="search-form" onSubmit={handleSubmit}>
            <input
              type="text"
              value={query}
              onChange={(event) => setQuery(event.target.value)}
              placeholder="Search for Elden Ring, Hades, Counter-Strike..."
            />
            <button className="primary-button" type="submit">
              Search
            </button>
          </form>
        </div>

        <div className="hero-side">
          <div className="stat-tile">
            <strong>Guest browsing</strong>
            <span>Search games without signing in.</span>
          </div>
          <div className="stat-tile">
            <strong>Steam login</strong>
            <span>
              {viewerState.authenticated
                ? "Your Steam account is connected."
                : "Connect Steam for personal library data."}
            </span>
          </div>
          <div className="stat-tile">
            <strong>Cached data</strong>
            <span>API responses are stored and refreshed with TTL policies.</span>
          </div>
        </div>
      </section>

      <SectionCard
        eyebrow="Search results"
        title={searchParams.get("q") ? `Results for "${searchParams.get("q")}"` : "Try a game search"}
      >
        {loading ? <p>Loading search results...</p> : null}
        {error ? <p className="error-text">{error}</p> : null}
        {!loading && !error && results.length === 0 ? (
          <p className="muted-text">
            Search for a Steam game to open the detail page with cached news and
            global achievements.
          </p>
        ) : null}

        <div className="grid-cards">
          {results.map((game) => (
            <GameCard
              key={game.appId}
              game={game}
              to={`/games/${game.appId}`}
              subtitle={game.isFree ? "Free to play" : "View details"}
            />
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
