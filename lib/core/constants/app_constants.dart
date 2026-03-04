/// App-wide string constants.
///
/// Centralise all magic strings here — session keys, DB names, route paths,
/// asset paths — so they're easy to find and update in one place.
abstract final class AppConstants {
  // ── Storage ─────────────────────────────────────────────────────────────
  static const String dbFileName = 'casino_platform.db';
  static const String sessionUserIdKey = 'session_uid';

  // ── Routes ───────────────────────────────────────────────────────────────
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeHome = '/home';
  static const String routeGames = '/games';
  static const String routeGameDetail = '/games/:id';
  static const String routeProfile = '/profile';
  static const String routeNotifications = '/notifications';
  static const String routeLanguage = '/language';
  static const String routeTheme = '/theme';
  static const String routeChangePassword = '/change-password';

  // ── App ──────────────────────────────────────────────────────────────────
  static const String appName = 'Casino Platform';
  static const int autoScrollIntervalSeconds = 4;
  static const int gameGridCrossAxisCount = 4;
}
