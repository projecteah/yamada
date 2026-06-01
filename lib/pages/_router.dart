import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yamada/components/global/app_navigation.dart';
import 'package:yamada/pages/home.dart';
import 'package:yamada/pages/settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppNavigation(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
