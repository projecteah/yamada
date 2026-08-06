// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get action => 'Acción';

  @override
  String get detail => 'Detalle';

  @override
  String get clear => 'Borrar';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado al portapapeles';

  @override
  String get home => 'Biblioteca';

  @override
  String get search => 'Buscar';

  @override
  String get searchPlaceholder => 'Buscar canciones, artistas, álbumes...';

  @override
  String get searchTabAll => 'Todo';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get searchHistory => 'Historial de búsqueda';

  @override
  String get searchClearHistory => 'Borrar todo';

  @override
  String get searchClearHistoryConfirmTitle => '¿Borrar historial de búsqueda?';

  @override
  String get searchClearHistoryConfirmMessage =>
      'Se eliminará todo el historial de búsqueda.';

  @override
  String get searchHistoryEmpty => 'Aún no hay historial de búsqueda';

  @override
  String get searchNoResults => 'No se encontraron resultados';

  @override
  String get searchError => 'La búsqueda falló, inténtalo de nuevo';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get setting => 'Ajustes';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamiento global';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsRecordSearchHistory => 'Registrar historial de búsqueda';

  @override
  String get settingsRecordSearchHistoryDescription =>
      'Guardar palabras clave de búsqueda para acceso rápido';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsAppearanceDescription => 'Tema, colores dinámicos';

  @override
  String get settingsThemeMode => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsDesign => 'Diseño';

  @override
  String get settingsDesignMaterial => 'Material';

  @override
  String get settingsDesignFluent => 'Fluent UI';

  @override
  String get settingsPlatform => 'Servicio de streaming';

  @override
  String get settingsPlatformDescription =>
      'Gestionar servicios de streaming de terceros, iniciar sesión en cuentas';

  @override
  String get settingsPlatformLogin => 'Iniciar sesión';

  @override
  String get settingsPlatformLogout => 'Cerrar sesión';

  @override
  String get settingsPlatformLoggedIn => 'Sesión iniciada';

  @override
  String get settingsPlatformNotLoggedIn => 'Sesión no iniciada';

  @override
  String get settingsPlatformHint =>
      'Mantén presionado el asa para reordenar, toca una tarjeta para iniciar o cerrar sesión.';

  @override
  String get settingsAdvanced => 'Avanzado';

  @override
  String get settingsAdvancedDescription =>
      'Funciones experimentales, registros, depuración';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsAboutDescription =>
      'Información de versión, actualizaciones';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsLicenses => 'Licencias de código abierto';

  @override
  String get debugBilibili => 'Depuración de la API de Bilibili';

  @override
  String get debugStreamDash => 'DASH audio/vídeo separados';

  @override
  String get debugStreamDurl => 'durl stream mezclado';

  @override
  String get debugRun => 'Ejecutar';

  @override
  String get debugResult => 'Resultado';

  @override
  String get debugResponseEmpty => 'Sin datos de respuesta';

  @override
  String get playerPlay => 'Reproducir';

  @override
  String get playerPause => 'Pausar';

  @override
  String get playerPlayNow => 'Reproducir ahora';

  @override
  String get playerAddToQueue => 'Añadir a la cola';

  @override
  String get playerNext => 'Siguiente';

  @override
  String get playerPrevious => 'Anterior';

  @override
  String get playerShuffle => 'Aleatorio';

  @override
  String get playerShuffleOn => 'Aleatorio activado';

  @override
  String get playerShuffleOff => 'Aleatorio desactivado';

  @override
  String get playerRepeatOff => 'Repetir desactivado';

  @override
  String get playerRepeatAll => 'Repetir todo';

  @override
  String get playerRepeatOne => 'Repetir uno';

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
