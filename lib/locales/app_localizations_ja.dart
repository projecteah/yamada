// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navHome => 'ライブラリ';

  @override
  String get navSettings => '設定';

  @override
  String get settingsGeneral => '一般';

  @override
  String get settingsGeneralDescription => '言語、グローバル設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsAppearance => '外観';

  @override
  String get settingsAppearanceDescription => 'テーマ、ダイナミックカラー';

  @override
  String get settingsThemeMode => 'テーマ';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsDesign => 'デザイン';

  @override
  String get settingsDesignMaterial => 'マテリアル';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsPlatform => 'ストリーミングプラットフォーム';

  @override
  String get settingsPlatformDescription =>
      'サードパーティのストリーミングプラットフォームを管理、アカウントにログイン';

  @override
  String get settingsPlatformYouTube => 'YouTube';

  @override
  String get settingsPlatformBilibili => 'bilibili';

  @override
  String get settingsPlatformNetease => 'Netease Cloud Music';

  @override
  String get settingsPlatformLogin => 'ログイン';

  @override
  String get settingsPlatformLogout => 'ログアウト';

  @override
  String get settingsPlatformLoggedIn => 'ログイン済み';

  @override
  String get settingsPlatformNotLoggedIn => '未ログイン';

  @override
  String get settingsPlatformHint => 'ドラッグで並べ替え、カードをタップしてログインまたはログアウト。';

  @override
  String get settingsAbout => 'について';

  @override
  String get settingsAboutDescription => 'バージョン情報、アップデート';

  @override
  String get settingsVersion => 'バージョン';

  @override
  String get settingsLicenses => 'オープンソースライセンス';
}
