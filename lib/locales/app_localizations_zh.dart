// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '首页';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get themeMode => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get design => '设计';

  @override
  String get designMaterial => 'Material';

  @override
  String get designFluent => 'Fluent UI';

  @override
  String get appearance => '外观';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get licenses => '开放源代码许可';
}

/// The translations for Chinese, as used in Taiwan, using the Han script (`zh_Hant_TW`).
class AppLocalizationsZhHantTw extends AppLocalizationsZh {
  AppLocalizationsZhHantTw() : super('zh_Hant_TW');

  @override
  String get home => '首頁';

  @override
  String get settings => '設定';

  @override
  String get language => '語言';

  @override
  String get themeMode => '主題';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get design => '設計';

  @override
  String get designMaterial => 'Material';

  @override
  String get designFluent => 'Fluent UI';

  @override
  String get appearance => '外觀';

  @override
  String get about => '關於';

  @override
  String get version => '版本';

  @override
  String get licenses => '開放原始碼授權';
}
