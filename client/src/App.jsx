import { useEffect, useState } from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import { apiRequest } from "./api.js";
import { Header } from "./components/Header.jsx";
import { AchievementsPage } from "./pages/AchievementsPage.jsx";
import { DashboardPage } from "./pages/DashboardPage.jsx";
import { GameDetailsPage } from "./pages/GameDetailsPage.jsx";
import { HomePage } from "./pages/HomePage.jsx";

export function App() {
  const [viewerState, setViewerState] = useState({
    loading: true,
    authenticated: false,
    viewer: null,
  });

  async function refreshViewer() {
    try {
      const payload = await apiRequest("/api/me");
      setViewerState({
        loading: false,
        authenticated: Boolean(payload.authenticated),
        viewer: payload.viewer || null,
      });
    } catch (_error) {
      setViewerState({
        loading: false,
        authenticated: false,
        viewer: null,
      });
    }
  }

  useEffect(() => {
    refreshViewer();
  }, []);

  return (
    <div className="app-shell">
      <Header viewerState={viewerState} onLogout={refreshViewer} />
      <main className="page-shell">
        <Routes>
          <Route
            path="/"
            element={<HomePage viewerState={viewerState} />}
          />
          <Route
            path="/games/:appId"
            element={<GameDetailsPage viewerState={viewerState} />}
          />
          <Route
            path="/dashboard"
            element={<DashboardPage viewerState={viewerState} />}
          />
          <Route
            path="/dashboard/games/:appId/achievements"
            element={<AchievementsPage viewerState={viewerState} />}
          />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </main>
    </div>
  );
}
