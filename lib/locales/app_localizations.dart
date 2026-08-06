import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'locales/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('zh'),
    Locale.fromSubtags(
        languageCode: 'zh', countryCode: 'TW', scriptCode: 'Hant')
  ];

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copied;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search songs, artists, albums...'**
  String get searchPlaceholder;

  /// No description provided for @searchTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchTabAll;

  /// No description provided for @searchTabLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get searchTabLocal;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get searchHistory;

  /// No description provided for @searchClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get searchClearHistory;

  /// No description provided for @searchClearHistoryConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear search history?'**
  String get searchClearHistoryConfirmTitle;

  /// No description provided for @searchClearHistoryConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'All search history will be removed.'**
  String get searchClearHistoryConfirmMessage;

  /// No description provided for @searchHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No search history yet'**
  String get searchHistoryEmpty;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searchNoResults;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Search failed, please try again'**
  String get searchError;

  /// No description provided for @platformYouTube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get platformYouTube;

  /// No description provided for @platformBilibili.
  ///
  /// In en, this message translates to:
  /// **'bilibili'**
  String get platformBilibili;

  /// No description provided for @platformNetease.
  ///
  /// In en, this message translates to:
  /// **'Netease Cloud Music'**
  String get platformNetease;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @settingsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneral;

  /// No description provided for @settingsGeneralDescription.
  ///
  /// In en, this message translates to:
  /// **'Language, global behavior'**
  String get settingsGeneralDescription;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsRecordSearchHistory.
  ///
  /// In en, this message translates to:
  /// **'Record search history'**
  String get settingsRecordSearchHistory;

  /// No description provided for @settingsRecordSearchHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Save search keywords for quick access'**
  String get settingsRecordSearchHistoryDescription;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Theme, dynamic colors'**
  String get settingsAppearanceDescription;

  /// No description provided for @settingsThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeMode;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get settingsDesign;

  /// No description provided for @settingsDesignMaterial.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get settingsDesignMaterial;

  /// No description provided for @settingsDesignFluent.
  ///
  /// In en, this message translates to:
  /// **'Fluent UI'**
  String get settingsDesignFluent;

  /// No description provided for @settingsPlatform.
  ///
  /// In en, this message translates to:
  /// **'Streaming Platform'**
  String get settingsPlatform;

  /// No description provided for @settingsPlatformDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage third-party streaming platforms, sign in accounts'**
  String get settingsPlatformDescription;

  /// No description provided for @settingsPlatformLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get settingsPlatformLogin;

  /// No description provided for @settingsPlatformLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsPlatformLogout;

  /// No description provided for @settingsPlatformLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Logged in'**
  String get settingsPlatformLoggedIn;

  /// No description provided for @settingsPlatformNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get settingsPlatformNotLoggedIn;

  /// No description provided for @settingsPlatformHint.
  ///
  /// In en, this message translates to:
  /// **'Long press the handle to reorder, tap a tile to sign in or out.'**
  String get settingsPlatformHint;

  /// No description provided for @settingsAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get settingsAdvanced;

  /// No description provided for @settingsAdvancedDescription.
  ///
  /// In en, this message translates to:
  /// **'Experimental features, logs, debugging'**
  String get settingsAdvancedDescription;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Version info, updates'**
  String get settingsAboutDescription;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get settingsLicenses;

  /// No description provided for @debugBilibili.
  ///
  /// In en, this message translates to:
  /// **'Bilibili API Debug'**
  String get debugBilibili;

  /// No description provided for @debugStreamDash.
  ///
  /// In en, this message translates to:
  /// **'DASH audio/video separated'**
  String get debugStreamDash;

  /// No description provided for @debugStreamDurl.
  ///
  /// In en, this message translates to:
  /// **'durl muxed stream'**
  String get debugStreamDurl;

  /// No description provided for @debugRun.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get debugRun;

  /// No description provided for @debugResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get debugResult;

  /// No description provided for @debugResponseEmpty.
  ///
  /// In en, this message translates to:
  /// **'No response data'**
  String get debugResponseEmpty;

  /// No description provided for @playerPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playerPlay;

  /// No description provided for @playerPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get playerPause;

  /// No description provided for @playerPlayNow.
  ///
  /// In en, this message translates to:
  /// **'Play now'**
  String get playerPlayNow;

  /// No description provided for @playerAddToQueue.
  ///
  /// In en, this message translates to:
  /// **'Add to queue'**
  String get playerAddToQueue;

  /// No description provided for @playerNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get playerNext;

  /// No description provided for @playerPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get playerPrevious;

  /// No description provided for @playerShuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get playerShuffle;

  /// No description provided for @playerShuffleOn.
  ///
  /// In en, this message translates to:
  /// **'Shuffle on'**
  String get playerShuffleOn;

  /// No description provided for @playerShuffleOff.
  ///
  /// In en, this message translates to:
  /// **'Shuffle off'**
  String get playerShuffleOff;

  /// No description provided for @playerRepeatOff.
  ///
  /// In en, this message translates to:
  /// **'Repeat off'**
  String get playerRepeatOff;

  /// No description provided for @playerRepeatAll.
  ///
  /// In en, this message translates to:
  /// **'Repeat all'**
  String get playerRepeatAll;

  /// No description provided for @playerRepeatOne.
  ///
  /// In en, this message translates to:
  /// **'Repeat one'**
  String get playerRepeatOne;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ja', 'pt', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script+country codes are specified.
  switch (locale.toString()) {
    case 'zh_Hant_TW':
      return AppLocalizationsZhHantTw();
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
