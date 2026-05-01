import { Link, NavLink, useNavigate } from "react-router-dom";
import { apiRequest } from "../api.js";

export function Header({ viewerState, onLogout }) {
  const navigate = useNavigate();
  const viewer = viewerState.viewer;

  async function handleLogout() {
    await apiRequest("/auth/logout", { method: "POST" });
    await onLogout();
    navigate("/");
  }

  return (
    <header className="topbar">
      <Link className="brand" to="/">
        <span className="brand-mark">SI</span>
        <span>
          <strong>Steam Insight</strong>
          <small>Search games, news, and achievements</small>
        </span>
      </Link>

      <nav className="nav-links">
        <NavLink to="/">Discover</NavLink>
        <NavLink to="/dashboard">Dashboard</NavLink>
      </nav>

      <div className="viewer-pill">
        {viewerState.authenticated && viewer ? (
          <>
            <img
              className="avatar"
              src={viewer.avatarUrl}
              alt={viewer.displayName}
            />
            <div>
              <strong>{viewer.displayName}</strong>
              <small>Steam connected</small>
            </div>
            <button className="ghost-button" onClick={handleLogout}>
              Log out
            </button>
          </>
        ) : (
          <a className="primary-button" href="/auth/steam">
            Log in with Steam
          </a>
        )}
      </div>
    </header>
  );
}
