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
  String get settingsGeneralDescription => '语言、全局行为';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsAppearance => '外观';

  @override
  String get settingsAppearanceDescription => '主题、动态色调';

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
  String get settingsPlatform => '流媒体平台';

  @override
  String get settingsPlatformDescription => '管理第三方流媒体平台、登录账号';

  @override
  String get settingsPlatformYouTube => 'YouTube';

  @override
  String get settingsPlatformBilibili => '哔哩哔哩';

  @override
  String get settingsPlatformNetease => '网易云音乐';

  @override
  String get settingsPlatformLogin => '登录';

  @override
  String get settingsPlatformLogout => '退出登录';

  @override
  String get settingsPlatformLoggedIn => '已登录';

  @override
  String get settingsPlatformNotLoggedIn => '未登录';

  @override
  String get settingsPlatformHint => '长按拖拽手柄排序，启用后点击卡片可登录或退出。';

  @override
  String get settingsAbout => '关于';

  @override
  String get settingsAboutDescription => '版本信息、更新';

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
  String get settingsGeneralDescription => '語言、全域行為';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsAppearance => '外觀';

  @override
  String get settingsAppearanceDescription => '主題、動態色調';

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
  String get settingsPlatform => '串流媒體服務';

  @override
  String get settingsPlatformDescription => '管理第三方串流媒體服務、登入帳號';

  @override
  String get settingsPlatformYouTube => 'YouTube';

  @override
  String get settingsPlatformBilibili => '嗶哩嗶哩';

  @override
  String get settingsPlatformNetease => '網易雲音樂';

  @override
  String get settingsPlatformLogin => '登入';

  @override
  String get settingsPlatformLogout => '登出';

  @override
  String get settingsPlatformLoggedIn => '已登入';

  @override
  String get settingsPlatformNotLoggedIn => '未登入';

  @override
  String get settingsPlatformHint => '拖曳手把排序，點擊卡片可登入或登出。';

  @override
  String get settingsAbout => '關於';

  @override
  String get settingsAboutDescription => '版本資訊、更新';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsLicenses => '開放原始碼授權';
}
