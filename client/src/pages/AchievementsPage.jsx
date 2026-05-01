import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { apiRequest } from "../api.js";
import { SectionCard } from "../components/SectionCard.jsx";
import { StatusBadge } from "../components/StatusBadge.jsx";

export function AchievementsPage({ viewerState }) {
  const { appId } = useParams();
  const [gameState, setGameState] = useState({
    loading: true,
    error: "",
    game: null,
  });
  const [achievementState, setAchievementState] = useState({
    loading: true,
    error: "",
    data: null,
  });

  useEffect(() => {
    let cancelled = false;

    setGameState({ loading: true, error: "", game: null });
    setAchievementState({ loading: true, error: "", data: null });

    apiRequest(`/api/games/${appId}`)
      .then((payload) => {
        if (!cancelled) {
          setGameState({ loading: false, error: "", game: payload.game });
        }
      })
      .catch((error) => {
        if (!cancelled) {
          setGameState({ loading: false, error: error.message, game: null });
        }
      });

    if (viewerState.authenticated) {
      apiRequest(`/api/me/games/${appId}/achievements`)
        .then((payload) => {
          if (!cancelled) {
            setAchievementState({ loading: false, error: "", data: payload });
          }
        })
        .catch((error) => {
          if (!cancelled) {
            setAchievementState({ loading: false, error: error.message, data: null });
          }
        });
    } else {
      setAchievementState({
        loading: false,
        error: "Log in with Steam to view personal achievement completion.",
        data: null,
      });
    }

    return () => {
      cancelled = true;
    };
  }, [appId, viewerState.authenticated]);

  return (
    <div className="stack-lg">
      <div className="inline-actions">
        <Link className="ghost-button" to={`/games/${appId}`}>
          Back to game page
        </Link>
      </div>

      <SectionCard
        eyebrow="Personal progress"
        title={gameState.game ? `${gameState.game.name} achievements` : "Achievement progress"}
        actions={
          achievementState.data ? (
            <StatusBadge status={achievementState.data.status} />
          ) : null
        }
      >
        {gameState.loading || achievementState.loading ? <p>Loading achievements...</p> : null}
        {gameState.error ? <p className="error-text">{gameState.error}</p> : null}
        {achievementState.error ? <p className="error-text">{achievementState.error}</p> : null}

        {achievementState.data?.status === "private" ? (
          <p className="muted-text">
            Your Steam privacy settings may be hiding your achievement data for
            this game.
          </p>
        ) : null}

        <div className="achievement-table">
          {achievementState.data?.achievements?.map((achievement) => (
            <div className="achievement-row" key={achievement.apiName}>
              <div>
                <strong>{achievement.displayName || achievement.apiName}</strong>
                <p>{achievement.description || "No description provided."}</p>
              </div>
              <div className="achievement-right">
                <span className="achievement-percent">
                  {achievement.globalPercent !== null && achievement.globalPercent !== undefined
                    ? `${Number(achievement.globalPercent).toFixed(1)}% global`
                    : "Global N/A"}
                </span>
                <span
                  className={
                    achievement.achieved ? "status-badge status-available" : "status-badge status-unknown"
                  }
                >
                  {achievement.achieved ? "Unlocked" : "Locked"}
                </span>
              </div>
            </div>
          ))}
        </div>
      </SectionCard>
    </div>
  );
}
