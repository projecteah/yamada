import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:window_manager/window_manager.dart';
import 'package:go_router/go_router.dart';
import "window_actions.dart";

class AppNavigation extends StatelessWidget {
  final Widget child;

  const AppNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) return buildFluent(context);
    return buildMaterial(context);
  }

  Widget buildMaterial(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getSelectedIndex(GoRouterState.of(context).uri.path),
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
    );
  }

  Widget buildFluent(BuildContext context) {
    return fluent.NavigationView(
      titleBar: fluent.TitleBar(
        isBackButtonEnabled: true,
        height: 40,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text("Yamada", style: TextStyle(fontSize: 14)),
        ),
        content: Container(
          margin: const EdgeInsetsDirectional.symmetric(vertical: 6),
          constraints: const BoxConstraints(maxWidth: 380),
          child: Builder(builder: (context) {
            return fluent.AutoSuggestBox(placeholder: 'Search...', items: []);
          }),
        ),
        captionControls: const WindowActions(),
        onDragStarted: () => windowManager.startDragging(),
        onDoubleTap: () {
          windowManager.isMaximized().then((isMaximized) {
            if (isMaximized) {
              windowManager.unmaximize();
            } else {
              windowManager.maximize();
            }
          });
        },
      ),
      pane: fluent.NavigationPane(
        selected: _getSelectedIndex(GoRouterState.of(context).uri.path),
        onChanged: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/settings');
              break;
          }
        },
        displayMode: fluent.PaneDisplayMode.top,
        items: [
          fluent.PaneItem(
            icon: const Icon(fluent.WindowsIcons.home),
            title: const Text('Home'),
            body: child,
          ),
        ],
        footerItems: [
          fluent.PaneItem(
            icon: const Icon(fluent.WindowsIcons.settings),
            title: const Text('Settings'),
            body: child,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String path) {
    switch (path) {
      case '/':
        return 0;
      case '/settings':
        return 1;
      default:
        return 0;
    }
  }
}
