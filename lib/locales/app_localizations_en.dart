// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Library';

  @override
  String get navSettings => 'Settings';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsGeneralDescription => 'Language, global behavior';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceDescription => 'Theme, dynamic colors';

  @override
  String get settingsThemeMode => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsDesign => 'Design';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsPlatform => 'Streaming Platform';

  @override
  String get settingsPlatformDescription =>
      'Manage third-party streaming platforms, sign in accounts';

  @override
  String get settingsPlatformYouTube => 'YouTube';

  @override
  String get settingsPlatformBilibili => 'bilibili';

  @override
  String get settingsPlatformNetease => 'Netease Cloud Music';

  @override
  String get settingsPlatformLogin => 'Login';

  @override
  String get settingsPlatformLogout => 'Logout';

  @override
  String get settingsPlatformLoggedIn => 'Logged in';

  @override
  String get settingsPlatformNotLoggedIn => 'Not logged in';

  @override
  String get settingsPlatformHint =>
      'Long press the handle to reorder, tap a tile to sign in or out.';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutDescription => 'Version info, updates';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicenses => 'Open Source Licenses';
}
