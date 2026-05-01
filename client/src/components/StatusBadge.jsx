export function StatusBadge({ status }) {
  const normalized = status || "unknown";

  return (
    <span className={`status-badge status-${normalized}`}>
      {normalized.replace("_", " ")}
    </span>
  );
}
