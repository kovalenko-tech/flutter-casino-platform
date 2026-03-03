/// App-wide string constants.
///
/// Centralise all magic strings here — session keys, DB names, route paths,
/// asset paths — so they're easy to find and update in one place.
abstract final class AppConstants {
  // ── Storage ─────────────────────────────────────────────────────────────
  static const String isarDbName = 'casino_platform';
  static const String sessionUserIdKey = 'session_uid';

  // ── Routes ───────────────────────────────────────────────────────────────
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeHome = '/home';
  static const String routeGames = '/games';
  static const String routeGameDetail = '/games/:id';
  static const String routeProfile = '/profile';

  // ── App ──────────────────────────────────────────────────────────────────
  static const String appName = 'Casino Platform';
  static const int autoScrollIntervalSeconds = 4;
  static const int gameGridCrossAxisCount = 4;
}
