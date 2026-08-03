// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '音乐库';

  @override
  String get search => '搜索';

  @override
  String get setting => '设置';

  @override
  String get searchPlaceholder => '搜索歌曲、艺术家、专辑...';

  @override
  String get searchTabAll => '全部';

  @override
  String get searchTabLocal => '本地';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => '哔哩哔哩';

  @override
  String get platformNetease => '网易云音乐';

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
  String get settingsPlatform => '流媒体服务';

  @override
  String get settingsPlatformDescription => '管理第三方流媒体服务、登录账号';

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
  String get home => '音樂庫';

  @override
  String get search => '搜尋';

  @override
  String get setting => '設定';

  @override
  String get searchPlaceholder => '搜尋歌曲、藝術家、專輯...';

  @override
  String get searchTabAll => '全部';

  @override
  String get searchTabLocal => '本機';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => '嗶哩嗶哩';

  @override
  String get platformNetease => '網易雲音樂';

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
