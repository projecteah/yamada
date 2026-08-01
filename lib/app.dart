import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/constants.dart';
import 'package:yamada/router/router.dart';
import 'package:yamada/providers/preferences_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static const _localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final design = ref.watch(designProvider);

    return design.isFluent
        ? _buildFluentApp(themeMode, locale)
        : _buildMaterialApp(themeMode, locale);
  }

  Widget _buildMaterialApp(ThemeMode themeMode, Locale? locale) {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: supportedLocales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }

  Widget _buildFluentApp(ThemeMode themeMode, Locale? locale) {
    return fluent.FluentApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: fluent.FluentThemeData(
        visualDensity: VisualDensity.standard,
        accentColor: fluent.Colors.blue,
      ),
      darkTheme: fluent.FluentThemeData(
        brightness: fluent.Brightness.dark,
        visualDensity: VisualDensity.standard,
        accentColor: fluent.Colors.blue,
      ),
      themeMode: _toFluentThemeMode(themeMode),
      locale: locale,
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: supportedLocales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }

  fluent.ThemeMode _toFluentThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return fluent.ThemeMode.light;
      case ThemeMode.dark:
        return fluent.ThemeMode.dark;
      case ThemeMode.system:
        return fluent.ThemeMode.system;
    }
  }
}
