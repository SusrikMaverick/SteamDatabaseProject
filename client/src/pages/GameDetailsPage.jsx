import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { apiRequest } from "../api.js";
import { SectionCard } from "../components/SectionCard.jsx";

export function GameDetailsPage({ viewerState }) {
  const { appId } = useParams();
  const [state, setState] = useState({
    loading: true,
    error: "",
    data: null,
  });

  useEffect(() => {
    let cancelled = false;
    setState({ loading: true, error: "", data: null });

    apiRequest(`/api/games/${appId}`)
      .then((payload) => {
        if (!cancelled) {
          setState({ loading: false, error: "", data: payload });
        }
      })
      .catch((error) => {
        if (!cancelled) {
          setState({ loading: false, error: error.message, data: null });
        }
      });

    return () => {
      cancelled = true;
    };
  }, [appId]);

  if (state.loading) {
    return <p>Loading game details...</p>;
  }

  if (state.error || !state.data) {
    return <p className="error-text">{state.error || "Game not found."}</p>;
  }

  const { game, news, achievements } = state.data;
  const steamStoreUrl = `https://store.steampowered.com/app/${game.appId}`;

  return (
    <div className="stack-lg">
      <section className="game-hero">
        <div className="game-hero-media">
          {game.headerImage ? <img src={game.headerImage} alt={game.name} /> : null}
        </div>
        <div className="game-hero-copy">
          <div className="eyebrow">Game details</div>
          <h1>{game.name}</h1>
          <p>{game.shortDescription || "No short description was returned by Steam."}</p>

          <div className="chip-row">
            {game.releaseDate ? <span className="chip">Released: {game.releaseDate}</span> : null}
            <span className="chip">{game.isFree ? "Free to play" : "Paid title"}</span>
            {game.developers?.length ? (
              <span className="chip">Developer: {game.developers.join(", ")}</span>
            ) : null}
          </div>

          <div className="inline-actions">
            <a className="ghost-button" href={steamStoreUrl} target="_blank" rel="noreferrer">
              View on Steam
            </a>
            {viewerState.authenticated ? (
              <Link
                className="primary-button"
                to={`/dashboard/games/${game.appId}/achievements`}
              >
                View my achievements
              </Link>
            ) : (
              <a className="primary-button" href="/auth/steam">
                Log in for personal stats
              </a>
            )}
          </div>
        </div>
      </section>

      <SectionCard eyebrow="Recent news" title="Latest articles">
        {news.length === 0 ? (
          <p className="muted-text">Steam did not return recent news for this game.</p>
        ) : (
          <div className="stack-md">
            {news.map((article) => (
              <a
                className="news-card news-card-link"
                key={article.gid}
                href={article.url}
                target="_blank"
                rel="noreferrer"
              >
                <div className="news-meta">
                  <span>{article.author || "Steam News"}</span>
                  <span>
                    {article.publishedAt
                      ? new Date(article.publishedAt).toLocaleDateString()
                      : "Unknown date"}
                  </span>
                </div>
                <h3>{article.title}</h3>
                <p>{article.contents || "No summary available."}</p>
              </a>
            ))}
          </div>
        )}
      </SectionCard>

      <SectionCard eyebrow="Global progress" title="Achievement completion rates">
        {achievements.length === 0 ? (
          <p className="muted-text">
            Global achievement percentages were not available for this game.
          </p>
        ) : (
          <div className="achievement-table">
            {achievements.map((achievement) => (
              <div className="achievement-row" key={achievement.apiName}>
                <div>
                  <strong>{achievement.displayName || achievement.apiName}</strong>
                  <p>{achievement.description || "No description provided."}</p>
                </div>
                <span className="achievement-percent">
                  {achievement.globalPercent !== null && achievement.globalPercent !== undefined
                    ? `${Number(achievement.globalPercent).toFixed(1)}%`
                    : "N/A"}
                </span>
              </div>
            ))}
          </div>
        )}
      </SectionCard>
    </div>
  );
}
