// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Biblioteca';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamiento global';

  @override
  String get settingsLanguage => 'Idioma';

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
  String get settingsPlatform => 'Plataforma de streaming';

  @override
  String get settingsPlatformDescription =>
      'Gestionar plataformas de streaming de terceros, iniciar sesión en cuentas';

  @override
  String get settingsPlatformYouTube => 'YouTube';

  @override
  String get settingsPlatformBilibili => 'bilibili';

  @override
  String get settingsPlatformNetease => 'Netease Cloud Music';

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
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsAboutDescription =>
      'Información de versión, actualizaciones';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsLicenses => 'Licencias de código abierto';
}
