// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

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
  String get validationConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get validationPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get validationPasswordUppercase =>
      'Password must contain an uppercase letter';

  @override
  String get validationPasswordLowercase =>
      'Password must contain a lowercase letter';

  @override
  String get validationPasswordDigit => 'Password must contain a digit';

  @override
  String get passwordRequirementsHint =>
      'Min 8 characters: uppercase, lowercase, and digit';

  @override
  String get errorEmailAlreadyExists =>
      'An account with that email already exists.';

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

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsEmpty => 'No notifications yet';

  @override
  String get securityTitle => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get fieldCurrentPassword => 'Current Password';

  @override
  String get fieldNewPassword => 'New Password';

  @override
  String get fieldConfirmNewPassword => 'Confirm New Password';

  @override
  String get validationCurrentPasswordRequired =>
      'Current password is required';

  @override
  String get errorWrongCurrentPassword => 'Current password is incorrect';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';
}
