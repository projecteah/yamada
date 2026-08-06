import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/components/global/app_scaffold.dart';
import 'package:yamada/pages/home_page.dart';
import 'package:yamada/pages/playlist_detail_page.dart';
import 'package:yamada/pages/search_page.dart';
import 'package:yamada/pages/settings_page.dart';
import 'package:yamada/pages/settings/general_page.dart';
import 'package:yamada/pages/settings/appearance_page.dart';
import 'package:yamada/pages/settings/about_page.dart';
import 'package:yamada/pages/settings/advanced_page.dart';
import 'package:yamada/pages/settings/debug_bilibili_page.dart';
import 'package:yamada/pages/settings/streaming_platforms_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/playlist/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return PlaylistDetailPage(playlistId: id);
          },
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(path: 'general', builder: (ctx, st) => const GeneralPage()),
            GoRoute(
                path: 'appearance',
                builder: (ctx, st) => const AppearancePage()),
            GoRoute(
                path: 'streaming', builder: (ctx, st) => const StreamingPage()),
            GoRoute(path: 'about', builder: (ctx, st) => const AboutPage()),
            GoRoute(
                path: 'advanced', builder: (ctx, st) => const AdvancedPage()),
            GoRoute(
                path: 'advanced/debug-bilibili',
                builder: (ctx, st) => const DebugBilibiliPage()),
          ],
        ),
      ],
    ),
  ],
);
