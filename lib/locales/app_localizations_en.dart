// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Library';

  @override
  String get search => 'Search';

  @override
  String get setting => 'Setting';

  @override
  String get searchPlaceholder => 'Search songs, artists, albums...';

  @override
  String get searchTabAll => 'All';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

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

  @override
  String get settingsRecordSearchHistory => 'Record search history';

  @override
  String get settingsRecordSearchHistoryDescription =>
      'Save search keywords for quick access';

  @override
  String get searchHistory => 'Search History';

  @override
  String get clearSearchHistory => 'Clear All';

  @override
  String get clearSearchHistoryConfirmTitle => 'Clear search history?';

  @override
  String get clearSearchHistoryConfirmMessage =>
      'All search history will be removed.';

  @override
  String get searchHistoryEmpty => 'No search history yet';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get searchError => 'Search failed, please try again';
}
