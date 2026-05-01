export function requireAuth(req, res, next) {
  if (req.isAuthenticated && req.isAuthenticated()) {
    next();
    return;
  }

  res.status(401).json({
    error: "Authentication required",
  });
}
