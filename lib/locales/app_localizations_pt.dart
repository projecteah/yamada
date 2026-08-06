// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get action => 'Ação';

  @override
  String get detail => 'Detalhe';

  @override
  String get clear => 'Limpar';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado para a área de transferência';

  @override
  String get home => 'Biblioteca';

  @override
  String get search => 'Pesquisar';

  @override
  String get searchPlaceholder => 'Pesquisar músicas, artistas, álbuns...';

  @override
  String get searchTabAll => 'Tudo';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get searchHistory => 'Histórico de pesquisa';

  @override
  String get searchClearHistory => 'Limpar tudo';

  @override
  String get searchClearHistoryConfirmTitle => 'Limpar histórico de pesquisa?';

  @override
  String get searchClearHistoryConfirmMessage =>
      'Todo o histórico de pesquisa será removido.';

  @override
  String get searchHistoryEmpty => 'Ainda não há histórico de pesquisa';

  @override
  String get searchNoResults => 'Nenhum resultado encontrado';

  @override
  String get searchError => 'A pesquisa falhou, tente novamente';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get setting => 'Definições';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamento global';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsRecordSearchHistory => 'Registar histórico de pesquisa';

  @override
  String get settingsRecordSearchHistoryDescription =>
      'Guardar palavras-chave de pesquisa para acesso rápido';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsAppearanceDescription => 'Tema, cores dinâmicas';

  @override
  String get settingsThemeMode => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsDesign => 'Desenho';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsPlatform => 'Serviço de streaming';

  @override
  String get settingsPlatformDescription =>
      'Gerir serviços de streaming de terceiros, iniciar sessão em contas';

  @override
  String get settingsPlatformLogin => 'Iniciar sessão';

  @override
  String get settingsPlatformLogout => 'Terminar sessão';

  @override
  String get settingsPlatformLoggedIn => 'Sessão iniciada';

  @override
  String get settingsPlatformNotLoggedIn => 'Sem sessão';

  @override
  String get settingsPlatformHint =>
      'Mantenha o controlo premido para reordenar, toque num mosaico para iniciar ou terminar sessão.';

  @override
  String get settingsAdvanced => 'Avançado';

  @override
  String get settingsAdvancedDescription =>
      'Funcionalidades experimentais, registos, depuração';

  @override
  String get settingsAbout => 'Acerca';

  @override
  String get settingsAboutDescription => 'Informação da versão, atualizações';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicenses => 'Licenças de código aberto';

  @override
  String get debugBilibili => 'Depuração da API Bilibili';

  @override
  String get debugStreamDash => 'DASH áudio/vídeo separados';

  @override
  String get debugStreamDurl => 'durl stream misturado';

  @override
  String get debugRun => 'Executar';

  @override
  String get debugResult => 'Resultado';

  @override
  String get debugResponseEmpty => 'Sem dados de resposta';

  @override
  String get playerPlay => 'Reproduzir';

  @override
  String get playerPause => 'Pausar';

  @override
  String get playerPlayNow => 'Reproduzir agora';

  @override
  String get playerAddToQueue => 'Adicionar à fila';

  @override
  String get playerNext => 'Próxima';

  @override
  String get playerPrevious => 'Anterior';

  @override
  String get playerShuffle => 'Aleatório';

  @override
  String get playerShuffleOn => 'Aleatório ativado';

  @override
  String get playerShuffleOff => 'Aleatório desativado';

  @override
  String get playerRepeatOff => 'Repetir desativado';

  @override
  String get playerRepeatAll => 'Repetir tudo';

  @override
  String get playerRepeatOne => 'Repetir uma';

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

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get action => 'Ação';

  @override
  String get detail => 'Detalhe';

  @override
  String get clear => 'Limpar';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado para a área de transferência';

  @override
  String get home => 'Biblioteca';

  @override
  String get search => 'Pesquisar';

  @override
  String get searchPlaceholder => 'Pesquisar músicas, artistas, álbuns...';

  @override
  String get searchTabAll => 'Tudo';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get searchHistory => 'Histórico de pesquisa';

  @override
  String get searchClearHistory => 'Limpar tudo';

  @override
  String get searchClearHistoryConfirmTitle => 'Limpar histórico de pesquisa?';

  @override
  String get searchClearHistoryConfirmMessage =>
      'Todo o histórico de pesquisa será removido.';

  @override
  String get searchHistoryEmpty => 'Ainda não há histórico de pesquisa';

  @override
  String get searchNoResults => 'Nenhum resultado encontrado';

  @override
  String get searchError => 'A pesquisa falhou, tente novamente';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get setting => 'Configurações';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamento global';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsRecordSearchHistory => 'Registrar histórico de pesquisa';

  @override
  String get settingsRecordSearchHistoryDescription =>
      'Salvar palavras-chave de pesquisa para acesso rápido';

  @override
  String get settingsAppearance => 'Aparência';

  @override
  String get settingsAppearanceDescription => 'Tema, cores dinâmicas';

  @override
  String get settingsThemeMode => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsDesign => 'Design';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsPlatform => 'Serviço de streaming';

  @override
  String get settingsPlatformDescription =>
      'Gerenciar serviços de streaming de terceiros, entrar em contas';

  @override
  String get settingsPlatformLogin => 'Entrar';

  @override
  String get settingsPlatformLogout => 'Sair';

  @override
  String get settingsPlatformLoggedIn => 'Conectado';

  @override
  String get settingsPlatformNotLoggedIn => 'Desconectado';

  @override
  String get settingsPlatformHint =>
      'Segure a alça para reordenar, toque em um cartão para entrar ou sair.';

  @override
  String get settingsAdvanced => 'Avançado';

  @override
  String get settingsAdvancedDescription =>
      'Funcionalidades experimentais, logs, depuração';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get settingsAboutDescription => 'Informações da versão, atualizações';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicenses => 'Licenças de código aberto';

  @override
  String get debugBilibili => 'Depuração da API Bilibili';

  @override
  String get debugStreamDash => 'DASH áudio/vídeo separados';

  @override
  String get debugStreamDurl => 'durl stream misturado';

  @override
  String get debugRun => 'Executar';

  @override
  String get debugResult => 'Resultado';

  @override
  String get debugResponseEmpty => 'Sem dados de resposta';

  @override
  String get playerPlay => 'Reproduzir';

  @override
  String get playerPause => 'Pausar';

  @override
  String get playerPlayNow => 'Reproduzir agora';

  @override
  String get playerAddToQueue => 'Adicionar à fila';

  @override
  String get playerNext => 'Próxima';

  @override
  String get playerPrevious => 'Anterior';

  @override
  String get playerShuffle => 'Aleatório';

  @override
  String get playerShuffleOn => 'Aleatório ativado';

  @override
  String get playerShuffleOff => 'Aleatório desativado';

  @override
  String get playerRepeatOff => 'Repetir desativado';

  @override
  String get playerRepeatAll => 'Repetir tudo';

  @override
  String get playerRepeatOne => 'Repetir uma';
}
