// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Casino Platform';

  @override
  String get retry => 'Повторити';

  @override
  String get back => 'Назад';

  @override
  String get loading => 'Завантаження…';

  @override
  String get errorGeneric => 'Щось пішло не так. Спробуйте ще раз.';

  @override
  String get navHome => 'Головна';

  @override
  String get navCasino => 'Казино';

  @override
  String get navProfile => 'Профіль';

  @override
  String get authWelcomeBack => 'З поверненням';

  @override
  String get authSignInSubtitle => 'Увійдіть у свій акаунт';

  @override
  String get authCreateAccount => 'Створити акаунт';

  @override
  String get authJoinSubtitle => 'Приєднуйтесь до тисяч гравців';

  @override
  String get authSignIn => 'Увійти';

  @override
  String get authSignUp => 'Зареєструватись';

  @override
  String get authAlreadyHaveAccount => 'Вже є акаунт? ';

  @override
  String get authDontHaveAccount => 'Немає акаунту? ';

  @override
  String get fieldEmail => 'Електронна пошта';

  @override
  String get fieldPassword => 'Пароль';

  @override
  String get fieldFullName => 'Повне ім\'я';

  @override
  String get fieldConfirmPassword => 'Підтвердіть пароль';

  @override
  String get validationEmailRequired => 'Введіть електронну пошту';

  @override
  String get validationEmailInvalid => 'Введіть коректну адресу пошти';

  @override
  String get validationPasswordRequired => 'Введіть пароль';

  @override
  String validationPasswordMinLength(int min) {
    return 'Пароль має бути не менше $min символів';
  }

  @override
  String get validationNameRequired => 'Введіть ім\'я';

  @override
  String get validationNameTooShort => 'Ім\'я занадто коротке';

  @override
  String get validationConfirmPasswordRequired => 'Підтвердіть пароль';

  @override
  String get validationPasswordsDoNotMatch => 'Паролі не збігаються';

  @override
  String get errorEmailAlreadyExists => 'Акаунт з такою поштою вже існує.';

  @override
  String get errorInvalidCredentials => 'Невірна пошта або пароль.';

  @override
  String get errorNoAccountFound => 'Акаунт з такою поштою не знайдено.';

  @override
  String get errorCouldNotLoadProfile => 'Не вдалося завантажити профіль.';

  @override
  String get errorGameNotFound => 'Гру не знайдено.';

  @override
  String get homeTitle => 'Казино';

  @override
  String get gamesAllGames => 'Всі ігри';

  @override
  String get gamesSearchHint => 'Пошук ігор або провайдерів…';

  @override
  String get gamesNoResults => 'Ігор не знайдено';

  @override
  String get gamesAbout => 'Про цю гру';

  @override
  String get gamesPlayNow => 'Грати';

  @override
  String get gamesTryDemo => 'Демо';

  @override
  String get gamesGoBack => 'Повернутись';

  @override
  String get gamesVolatility => 'Волатильність';

  @override
  String get gamesRtp => 'RTP';

  @override
  String get gamesProvider => 'Провайдер';

  @override
  String get volatilityLow => 'Низька';

  @override
  String get volatilityMedium => 'Середня';

  @override
  String get volatilityHigh => 'Висока';

  @override
  String get categoryAll => 'Всі';

  @override
  String get categorySlots => 'Слоти';

  @override
  String get categoryLive => 'Live';

  @override
  String get categoryTable => 'Столи';

  @override
  String get categoryJackpot => 'Джекпот';

  @override
  String get profileTitle => 'Профіль';

  @override
  String get profileMemberSince => 'Учасник з';

  @override
  String get profileAccountId => 'ID акаунту';

  @override
  String get profileSettings => 'Налаштування';

  @override
  String get profileSignOut => 'Вийти';

  @override
  String get profileNotifications => 'Сповіщення';

  @override
  String get profileLanguage => 'Мова';

  @override
  String get profileSecurity => 'Безпека';

  @override
  String get badgeNew => 'NEW';

  @override
  String get badgeHot => 'HOT';
}
