import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Casino Platform';

  @override
  String get retry => 'Retry';

  @override
  String get back => 'Back';

  @override
  String get loading => 'Loading…';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get navHome => 'Home';

  @override
  String get navCasino => 'Casino';

  @override
  String get navProfile => 'Profile';

  @override
  String get authWelcomeBack => 'Welcome back';

  @override
  String get authSignInSubtitle => 'Sign in to your account';

  @override
  String get authCreateAccount => 'Create Account';

  @override
  String get authJoinSubtitle => 'Join thousands of players today';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authAlreadyHaveAccount => 'Already have an account? ';

  @override
  String get authDontHaveAccount => 'Don\'t have an account? ';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldFullName => 'Full Name';

  @override
  String get fieldConfirmPassword => 'Confirm Password';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String validationPasswordMinLength(int min) {
    return 'Password must be at least $min characters';
  }

  @override
  String get validationNameRequired => 'Name is required';

  @override
  String get validationNameTooShort => 'Name is too short';

  @override
  String get validationConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get validationPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get errorEmailAlreadyExists => 'An account with that email already exists.';

  @override
  String get errorInvalidCredentials => 'Invalid email or password.';

  @override
  String get errorNoAccountFound => 'No account found with that email.';

  @override
  String get errorCouldNotLoadProfile => 'Could not load profile.';

  @override
  String get errorGameNotFound => 'Game not found.';

  @override
  String get homeTitle => 'Casino';

  @override
  String get gamesAllGames => 'All Games';

  @override
  String get gamesSearchHint => 'Search games or providers…';

  @override
  String get gamesNoResults => 'No games found';

  @override
  String get gamesAbout => 'About this game';

  @override
  String get gamesPlayNow => 'Play Now';

  @override
  String get gamesTryDemo => 'Try Demo';

  @override
  String get gamesGoBack => 'Go Back';

  @override
  String get gamesVolatility => 'Volatility';

  @override
  String get gamesRtp => 'RTP';

  @override
  String get gamesProvider => 'Provider';

  @override
  String get volatilityLow => 'Low';

  @override
  String get volatilityMedium => 'Medium';

  @override
  String get volatilityHigh => 'High';

  @override
  String get categoryAll => 'All';

  @override
  String get categorySlots => 'Slots';

  @override
  String get categoryLive => 'Live';

  @override
  String get categoryTable => 'Table';

  @override
  String get categoryJackpot => 'Jackpot';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileMemberSince => 'Member Since';

  @override
  String get profileAccountId => 'Account ID';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileSecurity => 'Security';

  @override
  String get badgeNew => 'NEW';

  @override
  String get badgeHot => 'HOT';
}
