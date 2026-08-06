// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get action => 'アクション';

  @override
  String get detail => '詳細';

  @override
  String get clear => 'クリア';

  @override
  String get copy => 'コピー';

  @override
  String get copied => 'クリップボードにコピーしました';

  @override
  String get home => 'ライブラリ';

  @override
  String get search => '検索';

  @override
  String get searchPlaceholder => '曲、アーティスト、アルバムを検索...';

  @override
  String get searchTabAll => 'すべて';

  @override
  String get searchTabLocal => 'ローカル';

  @override
  String get searchHistory => '検索履歴';

  @override
  String get searchClearHistory => 'すべて消去';

  @override
  String get searchClearHistoryConfirmTitle => '検索履歴を消去しますか？';

  @override
  String get searchClearHistoryConfirmMessage => 'すべての検索履歴が削除されます。';

  @override
  String get searchHistoryEmpty => '検索履歴はまだありません';

  @override
  String get searchNoResults => '結果が見つかりません';

  @override
  String get searchError => '検索に失敗しました。再試行してください';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get setting => '設定';

  @override
  String get settingsGeneral => '一般';

  @override
  String get settingsGeneralDescription => '言語、グローバル設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsRecordSearchHistory => '検索履歴を記録';

  @override
  String get settingsRecordSearchHistoryDescription => '検索キーワードを保存して素早くアクセス';

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
  String get settingsPlatform => 'ストリーミングサービス';

  @override
  String get settingsPlatformDescription => 'サードパーティのストリーミングサービスを管理、アカウントにログイン';

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
  String get settingsAdvanced => '詳細設定';

  @override
  String get settingsAdvancedDescription => '実験的機能、ログ、デバッグ';

  @override
  String get settingsAbout => 'について';

  @override
  String get settingsAboutDescription => 'バージョン情報、アップデート';

  @override
  String get settingsVersion => 'バージョン';

  @override
  String get settingsLicenses => 'オープンソースライセンス';

  @override
  String get debugBilibili => 'Bilibili API デバッグ';

  @override
  String get debugStreamDash => 'DASH 音声/動画分離';

  @override
  String get debugStreamDurl => 'durl ミュックスストリーム';

  @override
  String get debugRun => '実行';

  @override
  String get debugResult => '結果';

  @override
  String get debugResponseEmpty => 'レスポンスがありません';

  @override
  String get playerPlay => '再生';

  @override
  String get playerPause => '一時停止';

  @override
  String get playerPlayNow => '今すぐ再生';

  @override
  String get playerAddToQueue => 'キューに追加';

  @override
  String get playerNext => '次の曲';

  @override
  String get playerPrevious => '前の曲';

  @override
  String get playerShuffle => 'シャッフル';

  @override
  String get playerShuffleOn => 'シャッフルオン';

  @override
  String get playerShuffleOff => 'シャッフルオフ';

  @override
  String get playerRepeatOff => 'リピートオフ';

  @override
  String get playerRepeatAll => '全曲リピート';

  @override
  String get playerRepeatOne => '1曲リピート';

  @override
  String get libraryTabLocal => 'Local';

  @override
  String get libraryViewGrid => 'Grid view';

  @override
  String get libraryViewList => 'List view';

  @override
  String get libraryCreatePlaylist => 'Create playlist';

  @override
  String get libraryPlaylistName => 'Playlist name';

  @override
  String get libraryPlaylistDescription => 'Description (optional)';

  @override
  String get libraryPlaylistEmpty => 'No playlists yet';

  @override
  String get libraryPlaylistEmptyHint =>
      'Create a playlist to start collecting tracks';

  @override
  String get libraryPlaylistDetailEmpty => 'No tracks in this playlist';

  @override
  String get libraryPlaylistDetailEmptyHint => 'Add tracks from search results';

  @override
  String get libraryAddToPlaylist => 'Add to playlist';

  @override
  String get libraryCreateNewPlaylist => 'Create new playlist';

  @override
  String get libraryAddedToPlaylist => 'Added to playlist';

  @override
  String get libraryTrackAlreadyInPlaylist => 'Already in this playlist';

  @override
  String libraryPlaylistTracksCount(Object count) {
    return '$count tracks';
  }

  @override
  String get libraryPlaylistRename => 'Rename';

  @override
  String get libraryPlaylistDelete => 'Delete';

  @override
  String get libraryPlaylistDeleteConfirmTitle => 'Delete playlist?';

  @override
  String get libraryPlaylistDeleteConfirmMessage =>
      'This playlist and all its tracks will be removed.';

  @override
  String get libraryRemoveFromPlaylist => 'Remove from playlist';

  @override
  String get libraryStreamingComingSoon => 'Coming soon';

  @override
  String get libraryStreamingComingSoonHint =>
      'Streaming platform integration is not yet available.';
}
