// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navHome => '音乐库';

  @override
  String get navSettings => '设置';

  @override
  String get settingsGeneral => '通用';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsAbout => '关于';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsThemeMode => '主题';

  @override
  String get settingsThemeSystem => '跟随系统';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsDesign => '设计';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsLicenses => '开放源代码许可';
}

/// The translations for Chinese, as used in Taiwan, using the Han script (`zh_Hant_TW`).
class AppLocalizationsZhHantTw extends AppLocalizationsZh {
  AppLocalizationsZhHantTw() : super('zh_Hant_TW');

  @override
  String get navHome => '音樂庫';

  @override
  String get navSettings => '設定';

  @override
  String get settingsGeneral => '一般';

  @override
  String get settingsAppearance => '外觀';

  @override
  String get settingsAbout => '關於';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsThemeMode => '主題';

  @override
  String get settingsThemeSystem => '跟隨系統';

  @override
  String get settingsThemeLight => '淺色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsDesign => '設計';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsLicenses => '開放原始碼授權';
}
