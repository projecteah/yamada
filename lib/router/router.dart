import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:go_router/go_router.dart';

import 'package:yamada/router/app_navigation.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/pages/home_page.dart';
import 'package:yamada/pages/search_page.dart';
import 'package:yamada/pages/settings_page.dart';
import 'package:yamada/pages/settings/general_page.dart';
import 'package:yamada/pages/settings/appearance_page.dart';
import 'package:yamada/pages/settings/about_page.dart';
import 'package:yamada/pages/settings/advanced_page.dart';
import 'package:yamada/pages/settings/debug_bilibili_page.dart';
import 'package:yamada/pages/settings/streaming_platforms_page.dart';

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
  final List<AppSubRoute> children;

  const AppSubRoute({
    required this.path,
    required this.builder,
    required this.labelOf,
    this.children = const [],
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
    path: '/search',
    builder: (context, state) => const SearchPage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.search,
    icon: Icons.search_outlined,
    selectedIcon: Icons.search_rounded,
    fluentIcon: fluent.WindowsIcons.search,
  ),
  AppRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
    labelOf: (ctx) => AppLocalizations.of(ctx)!.setting,
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
        path: 'streaming',
        builder: (context, state) => const StreamingPage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsPlatform,
      ),
      AppSubRoute(
        path: 'about',
        builder: (context, state) => const AboutPage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsAbout,
      ),
      AppSubRoute(
        path: 'advanced',
        builder: (context, state) => const AdvancedPage(),
        labelOf: (ctx) => AppLocalizations.of(ctx)!.settingsAdvanced,
        children: [
          AppSubRoute(
            path: 'debug-bilibili',
            builder: (context, state) => const DebugBilibiliPage(),
            labelOf: (ctx) => AppLocalizations.of(ctx)!.debugBilibili,
          ),
        ],
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
                  routes: [
                    for (final sub2 in sub.children)
                      GoRoute(
                        path: sub2.path,
                        builder: sub2.builder,
                      ),
                  ],
                ),
            ],
          ),
      ],
    ),
  ],
);
