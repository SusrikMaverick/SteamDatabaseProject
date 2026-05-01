import { Link } from "react-router-dom";

export function GameCard({ game, to, subtitle }) {
  return (
    <Link className="game-card" to={to}>
      {game.imageUrl || game.headerImage ? (
        <img
          className="game-card-image"
          src={game.imageUrl || game.headerImage}
          alt={game.name}
        />
      ) : (
        <div className="game-card-image placeholder">Steam</div>
      )}

      <div className="game-card-body">
        <h3>{game.name}</h3>
        {subtitle ? <p>{subtitle}</p> : null}
      </div>
    </Link>
  );
}
