import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';

import 'package:yamada/components/global/app_navigation.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/pages/home.dart';
import 'package:yamada/pages/settings.dart';

class AppRoute {
  final String path;
  final GoRouterWidgetBuilder builder;
  final String Function(BuildContext) labelOf;
  final IconData icon;
  final IconData selectedIcon;
  final IconData fluentIcon;

  const AppRoute({
    required this.path,
    required this.builder,
    required this.labelOf,
    required this.icon,
    required this.selectedIcon,
    required this.fluentIcon,
  });
}

final List<AppRoute> appRoutes = [
  AppRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.home,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    fluentIcon: fluent.WindowsIcons.home,
  ),
  AppRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.settings,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    fluentIcon: fluent.WindowsIcons.settings,
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
          ),
      ],
    ),
  ],
);
