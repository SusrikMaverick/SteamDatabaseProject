import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { apiRequest } from "../api.js";
import { SectionCard } from "../components/SectionCard.jsx";
import { StatusBadge } from "../components/StatusBadge.jsx";

export function DashboardPage({ viewerState }) {
  const [ownedState, setOwnedState] = useState({
    loading: false,
    data: null,
    error: "",
  });
  const [recentState, setRecentState] = useState({
    loading: false,
    data: null,
    error: "",
  });

  useEffect(() => {
    if (!viewerState.authenticated) {
      return;
    }

    let cancelled = false;
    setOwnedState({ loading: true, data: null, error: "" });
    setRecentState({ loading: true, data: null, error: "" });

    apiRequest("/api/me/owned-games")
      .then((payload) => {
        if (!cancelled) {
          setOwnedState({ loading: false, data: payload, error: "" });
        }
      })
      .catch((error) => {
        if (!cancelled) {
          setOwnedState({ loading: false, data: null, error: error.message });
        }
      });

    apiRequest("/api/me/recently-played")
      .then((payload) => {
        if (!cancelled) {
          setRecentState({ loading: false, data: payload, error: "" });
        }
      })
      .catch((error) => {
        if (!cancelled) {
          setRecentState({ loading: false, data: null, error: error.message });
        }
      });

    return () => {
      cancelled = true;
    };
  }, [viewerState.authenticated]);

  if (viewerState.loading) {
    return <p>Loading your Steam session...</p>;
  }

  if (!viewerState.authenticated || !viewerState.viewer) {
    return (
      <section className="hero-panel">
        <div className="hero-copy">
          <div className="eyebrow">Steam login required</div>
          <h1>Connect your Steam account to unlock the personalized dashboard.</h1>
          <p>
            After logging in, the app can display your profile, owned games,
            recently played titles, and your achievement progress for any game.
          </p>
          <a className="primary-button" href="/auth/steam">
            Log in with Steam
          </a>
        </div>
      </section>
    );
  }

  const viewer = viewerState.viewer;

  return (
    <div className="stack-lg">
      <section className="profile-banner">
        <img className="profile-avatar" src={viewer.avatarUrl} alt={viewer.displayName} />
        <div>
          <div className="eyebrow">Connected profile</div>
          <h1>{viewer.displayName}</h1>
          <p>Steam ID: {viewer.steamId}</p>
          {viewer.profileUrl ? (
            <a href={viewer.profileUrl} target="_blank" rel="noreferrer">
              View Steam community profile
            </a>
          ) : null}
        </div>
      </section>

      <SectionCard
        eyebrow="Owned games"
        title="Your library"
        actions={
          ownedState.data ? <StatusBadge status={ownedState.data.status} /> : null
        }
      >
        {ownedState.loading ? <p>Loading owned games...</p> : null}
        {ownedState.error ? <p className="error-text">{ownedState.error}</p> : null}
        {ownedState.data?.status === "private" ? (
          <p className="muted-text">
            Steam privacy settings prevented access to owned games.
            {ownedState.data.details ? ` ${ownedState.data.details}` : ""}
          </p>
        ) : null}
        <div className="list-grid">
          {ownedState.data?.games?.map((game) => (
            <div className="library-row" key={game.appId}>
              <div>
                <strong>{game.name}</strong>
                <p>{Math.round(game.playtimeForever / 60)} hours played</p>
              </div>
              <Link className="ghost-button" to={`/dashboard/games/${game.appId}/achievements`}>
                My achievements
              </Link>
            </div>
          ))}
        </div>
      </SectionCard>

      <SectionCard
        eyebrow="Recently played"
        title="What you've been playing"
        actions={
          recentState.data ? <StatusBadge status={recentState.data.status} /> : null
        }
      >
        {recentState.loading ? <p>Loading recently played games...</p> : null}
        {recentState.error ? <p className="error-text">{recentState.error}</p> : null}
        {recentState.data?.status === "private" ? (
          <p className="muted-text">
            Steam privacy settings prevented access to recently played games.
            {recentState.data.details ? ` ${recentState.data.details}` : ""}
          </p>
        ) : null}
        <div className="list-grid">
          {recentState.data?.games?.map((game) => (
            <div className="library-row" key={game.appId}>
              <div>
                <strong>{game.name}</strong>
                <p>{Math.round(game.playtime2Weeks / 60)} hours in the last two weeks</p>
              </div>
              <Link className="ghost-button" to={`/games/${game.appId}`}>
                Open game page
              </Link>
            </div>
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
