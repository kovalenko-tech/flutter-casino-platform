// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Casino Platform';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get back => 'Zurück';

  @override
  String get loading => 'Wird geladen…';

  @override
  String get errorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get navHome => 'Startseite';

  @override
  String get navCasino => 'Casino';

  @override
  String get navProfile => 'Profil';

  @override
  String get authWelcomeBack => 'Willkommen zurück';

  @override
  String get authSignInSubtitle => 'Melde dich in deinem Konto an';

  @override
  String get authCreateAccount => 'Konto erstellen';

  @override
  String get authJoinSubtitle => 'Schließe dich tausenden Spielern an';

  @override
  String get authSignIn => 'Anmelden';

  @override
  String get authSignUp => 'Registrieren';

  @override
  String get authAlreadyHaveAccount => 'Bereits ein Konto? ';

  @override
  String get authDontHaveAccount => 'Kein Konto? ';

  @override
  String get fieldEmail => 'E-Mail';

  @override
  String get fieldPassword => 'Passwort';

  @override
  String get fieldFullName => 'Vollständiger Name';

  @override
  String get fieldConfirmPassword => 'Passwort bestätigen';

  @override
  String get validationEmailRequired => 'E-Mail ist erforderlich';

  @override
  String get validationEmailInvalid => 'Gib eine gültige E-Mail-Adresse ein';

  @override
  String get validationPasswordRequired => 'Passwort ist erforderlich';

  @override
  String validationPasswordMinLength(int min) {
    return 'Passwort muss mindestens $min Zeichen lang sein';
  }

  @override
  String get validationNameRequired => 'Name ist erforderlich';

  @override
  String get validationNameTooShort => 'Name ist zu kurz';

  @override
  String get validationConfirmPasswordRequired =>
      'Bitte bestätige dein Passwort';

  @override
  String get validationPasswordsDoNotMatch =>
      'Passwörter stimmen nicht überein';

  @override
  String get validationPasswordUppercase =>
      'Passwort muss einen Großbuchstaben enthalten';

  @override
  String get validationPasswordLowercase =>
      'Passwort muss einen Kleinbuchstaben enthalten';

  @override
  String get validationPasswordDigit => 'Passwort muss eine Ziffer enthalten';

  @override
  String get passwordRequirementsHint =>
      'Min. 8 Zeichen: Groß-, Kleinbuchstabe und Ziffer';

  @override
  String get errorEmailAlreadyExists =>
      'Ein Konto mit dieser E-Mail existiert bereits.';

  @override
  String get errorInvalidCredentials => 'Ungültige E-Mail oder Passwort.';

  @override
  String get errorNoAccountFound => 'Kein Konto mit dieser E-Mail gefunden.';

  @override
  String get errorCouldNotLoadProfile => 'Profil konnte nicht geladen werden.';

  @override
  String get errorGameNotFound => 'Spiel nicht gefunden.';

  @override
  String get homeTitle => 'Casino';

  @override
  String get gamesAllGames => 'Alle Spiele';

  @override
  String get gamesSearchHint => 'Spiele oder Anbieter suchen…';

  @override
  String get gamesNoResults => 'Keine Spiele gefunden';

  @override
  String get gamesAbout => 'Über dieses Spiel';

  @override
  String get gamesPlayNow => 'Jetzt spielen';

  @override
  String get gamesTryDemo => 'Demo testen';

  @override
  String get gamesGoBack => 'Zurück';

  @override
  String get gamesVolatility => 'Volatilität';

  @override
  String get gamesRtp => 'RTP';

  @override
  String get gamesProvider => 'Anbieter';

  @override
  String get volatilityLow => 'Niedrig';

  @override
  String get volatilityMedium => 'Mittel';

  @override
  String get volatilityHigh => 'Hoch';

  @override
  String get categoryAll => 'Alle';

  @override
  String get categorySlots => 'Slots';

  @override
  String get categoryLive => 'Live';

  @override
  String get categoryTable => 'Tisch';

  @override
  String get categoryJackpot => 'Jackpot';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileMemberSince => 'Mitglied seit';

  @override
  String get profileAccountId => 'Konto-ID';

  @override
  String get profileSettings => 'Einstellungen';

  @override
  String get profileSignOut => 'Abmelden';

  @override
  String get profileNotifications => 'Benachrichtigungen';

  @override
  String get profileLanguage => 'Sprache';

  @override
  String get profileSecurity => 'Sicherheit';

  @override
  String get badgeNew => 'NEU';

  @override
  String get badgeHot => 'HOT';

  @override
  String get settingsTheme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notificationsEmpty => 'Noch keine Benachrichtigungen';

  @override
  String get securityTitle => 'Sicherheit';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get fieldCurrentPassword => 'Aktuelles Passwort';

  @override
  String get fieldNewPassword => 'Neues Passwort';

  @override
  String get fieldConfirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get validationCurrentPasswordRequired =>
      'Aktuelles Passwort ist erforderlich';

  @override
  String get errorWrongCurrentPassword => 'Aktuelles Passwort ist falsch';

  @override
  String get passwordChangeSuccess => 'Passwort erfolgreich geändert';
}
