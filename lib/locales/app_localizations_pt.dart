// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get home => 'Biblioteca';

  @override
  String get search => 'Pesquisar';

  @override
  String get setting => 'Definições';

  @override
  String get searchPlaceholder => 'Pesquisar músicas, artistas, álbuns...';

  @override
  String get searchTabAll => 'Tudo';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamento global';

  @override
  String get settingsLanguage => 'Idioma';

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
  String get settingsAbout => 'Acerca';

  @override
  String get settingsAboutDescription => 'Informação da versão, atualizações';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicenses => 'Licenças de código aberto';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get home => 'Biblioteca';

  @override
  String get search => 'Pesquisar';

  @override
  String get setting => 'Configurações';

  @override
  String get searchPlaceholder => 'Pesquisar músicas, artistas, álbuns...';

  @override
  String get searchTabAll => 'Tudo';

  @override
  String get searchTabLocal => 'Local';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformBilibili => 'bilibili';

  @override
  String get platformNetease => 'Netease Cloud Music';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get settingsGeneralDescription => 'Idioma, comportamento global';

  @override
  String get settingsLanguage => 'Idioma';

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
  String get settingsAbout => 'Sobre';

  @override
  String get settingsAboutDescription => 'Informações da versão, atualizações';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsLicenses => 'Licenças de código aberto';
}
