export function isStale(lastFetchedAt, ttlHours) {
  if (!lastFetchedAt) {
    return true;
  }

  const lastFetched = new Date(lastFetchedAt).getTime();
  const ttlMs = ttlHours * 60 * 60 * 1000;

  return Number.isNaN(lastFetched) || Date.now() - lastFetched > ttlMs;
}

export function fromUnixSeconds(value) {
  if (!value) {
    return null;
  }

  return new Date(Number(value) * 1000);
}
