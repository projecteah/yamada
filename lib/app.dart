import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';
import 'pages/_router.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  static const _locales = [
    Locale('en'),
    Locale('ja'),
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
  ];

  @override
  Widget build(BuildContext context) {
    return Platform.isWindows ? _buildFluentApp() : _buildMaterialApp();
  }

  Widget _buildMaterialApp() {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark)),
      supportedLocales: _locales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }

  Widget _buildFluentApp() {
    final glowFactor = fluent.is10footScreen(context) ? 2.0 : 0.0;
    final baseTheme = fluent.FluentThemeData(
      visualDensity: VisualDensity.standard,
      accentColor: fluent.Colors.blue,
      focusTheme: fluent.FocusThemeData(glowFactor: glowFactor),
    );

    return fluent.FluentApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: baseTheme,
      darkTheme: baseTheme.copyWith(brightness: fluent.Brightness.dark),
      supportedLocales: _locales,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
