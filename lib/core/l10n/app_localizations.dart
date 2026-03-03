import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'package:flutter_casino_platform/core/l10n/app_localizations_en.dart';
import 'package:flutter_casino_platform/core/l10n/app_localizations_uk.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'Casino Platform'**
  String get appName;

  /// Generic retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Generic back navigation label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Generic loading placeholder
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// Bottom nav: home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom nav: casino tab label
  ///
  /// In en, this message translates to:
  /// **'Casino'**
  String get navCasino;

  /// Bottom nav: profile tab label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Login screen heading
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authWelcomeBack;

  /// Login screen subheading
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get authSignInSubtitle;

  /// Register screen heading and button label
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccount;

  /// Register screen subheading
  ///
  /// In en, this message translates to:
  /// **'Join thousands of players today'**
  String get authJoinSubtitle;

  /// Login button label / link to login screen
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// Link to register screen
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// Prefix before Sign In link on register screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authAlreadyHaveAccount;

  /// Prefix before Sign Up link on login screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get authDontHaveAccount;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fieldFullName;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get fieldConfirmPassword;

  /// Validation: email field is empty
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// Validation: email format is wrong
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmailInvalid;

  /// Validation: password field is empty
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// Validation: password is too short
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {min} characters'**
  String validationPasswordMinLength(int min);

  /// Validation: name field is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get validationNameRequired;

  /// Validation: name is below minimum length
  ///
  /// In en, this message translates to:
  /// **'Name is too short'**
  String get validationNameTooShort;

  /// Validation: confirm password field is empty
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmPasswordRequired;

  /// Validation: password and confirm password differ
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsDoNotMatch;

  /// Error: duplicate email on registration
  ///
  /// In en, this message translates to:
  /// **'An account with that email already exists.'**
  String get errorEmailAlreadyExists;

  /// Error: wrong login credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get errorInvalidCredentials;

  /// Error: email not registered
  ///
  /// In en, this message translates to:
  /// **'No account found with that email.'**
  String get errorNoAccountFound;

  /// Error: profile load failure
  ///
  /// In en, this message translates to:
  /// **'Could not load profile.'**
  String get errorCouldNotLoadProfile;

  /// Error: game ID does not exist
  ///
  /// In en, this message translates to:
  /// **'Game not found.'**
  String get errorGameNotFound;

  /// Home screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Casino'**
  String get homeTitle;

  /// Games screen title and 'All' filter chip
  ///
  /// In en, this message translates to:
  /// **'All Games'**
  String get gamesAllGames;

  /// Search field placeholder in games screen
  ///
  /// In en, this message translates to:
  /// **'Search games or providers…'**
  String get gamesSearchHint;

  /// Empty state when search/filter returns nothing
  ///
  /// In en, this message translates to:
  /// **'No games found'**
  String get gamesNoResults;

  /// Section heading on game detail screen
  ///
  /// In en, this message translates to:
  /// **'About this game'**
  String get gamesAbout;

  /// Primary CTA button on game detail screen
  ///
  /// In en, this message translates to:
  /// **'Play Now'**
  String get gamesPlayNow;

  /// Secondary CTA button on game detail screen
  ///
  /// In en, this message translates to:
  /// **'Try Demo'**
  String get gamesTryDemo;

  /// Error state back button on game detail screen
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get gamesGoBack;

  /// Volatility row label on game detail screen
  ///
  /// In en, this message translates to:
  /// **'Volatility'**
  String get gamesVolatility;

  /// RTP row label on game detail screen
  ///
  /// In en, this message translates to:
  /// **'RTP'**
  String get gamesRtp;

  /// Provider row label on game detail screen
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get gamesProvider;

  /// Volatility level: low
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get volatilityLow;

  /// Volatility level: medium
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get volatilityMedium;

  /// Volatility level: high
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get volatilityHigh;

  /// Game category filter chip: all games
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// Game category: slots
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get categorySlots;

  /// Game category: live casino
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get categoryLive;

  /// Game category: table games
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get categoryTable;

  /// Game category: jackpot games
  ///
  /// In en, this message translates to:
  /// **'Jackpot'**
  String get categoryJackpot;

  /// Profile screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Profile stat label: account creation date
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// Profile stat label: unique account ID
  ///
  /// In en, this message translates to:
  /// **'Account ID'**
  String get profileAccountId;

  /// Profile settings section heading
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// Settings item: notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// Settings item: language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// Settings item: security
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get profileSecurity;

  /// Badge overlay on new game cards
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get badgeNew;

  /// Badge overlay on hot/popular game cards
  ///
  /// In en, this message translates to:
  /// **'HOT'**
  String get badgeHot;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
