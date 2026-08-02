import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';

import 'package:yamada/router/app_navigation.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/pages/home.dart';
import 'package:yamada/pages/settings.dart';
import 'package:yamada/pages/settings/general_page.dart';
import 'package:yamada/pages/settings/appearance_page.dart';
import 'package:yamada/pages/settings/about_page.dart';

class AppRoute {
  final String path;
  final GoRouterWidgetBuilder builder;
  final String Function(BuildContext) labelOf;
  final IconData icon;
  final IconData selectedIcon;
  final IconData fluentIcon;
  final List<AppSubRoute> children;

  const AppRoute({
    required this.path,
    required this.builder,
    required this.labelOf,
    required this.icon,
    required this.selectedIcon,
    required this.fluentIcon,
    this.children = const [],
  });
}

class AppSubRoute {
  final String path;
  final GoRouterWidgetBuilder builder;
  final String Function(BuildContext) labelOf;

  const AppSubRoute({
    required this.path,
    required this.builder,
    required this.labelOf,
  });
}

final List<AppRoute> appRoutes = [
  AppRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.home,
    icon: Icons.my_library_music_outlined,
    selectedIcon: Icons.my_library_music_rounded,
    fluentIcon: fluent.WindowsIcons.home,
  ),
  AppRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.settings,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings_rounded,
    fluentIcon: fluent.WindowsIcons.settings,
    children: [
      AppSubRoute(
        path: 'general',
        builder: (context, state) => const GeneralPage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsGeneral,
      ),
      AppSubRoute(
        path: 'appearance',
        builder: (context, state) => const AppearancePage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsAppearance,
      ),
      AppSubRoute(
        path: 'about',
        builder: (context, state) => const AboutPage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsAbout,
      ),
    ],
  ),
];

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: appRoutes.first.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppNavigation(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        for (final route in appRoutes)
          GoRoute(
            path: route.path,
            builder: route.builder,
            routes: [
              for (final sub in route.children)
                GoRoute(
                  path: sub.path,
                  builder: sub.builder,
                ),
            ],
          ),
      ],
    ),
  ],
);
