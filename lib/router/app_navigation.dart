import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:window_manager/window_manager.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/providers/appearance_provider.dart';
import 'package:yamada/router/router.dart';

class AppNavigation extends ConsumerWidget {
  final Widget child;
  final String currentPath;

  const AppNavigation({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = DesignScope.of(context) == AppDesign.fluent;
    return isFluent ? _buildFluent(context) : _buildMaterial(context);
  }

  // ==================== Material ====================
  static const double _wideBreakpoint = 600;

  Widget _buildMaterial(BuildContext context) {
    final selected = _indexOf(currentPath);
    final isWindows = Platform.isWindows;
    final isWideScreen = MediaQuery.of(context).size.width >= _wideBreakpoint;
    if (isWindows || isWideScreen) {
      return _buildMaterialWide(context, selected, showTitleBar: isWindows);
    }
    return _buildMaterialMobile(context, selected);
  }

  Widget _buildMaterialWide(
    BuildContext context,
    int selected, {
    bool showTitleBar = false,
  }) {
    return Scaffold(
      body: Column(
        children: [
          if (showTitleBar) _buildWindowTitleBar(context),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: selected,
                  onDestinationSelected: (i) => context.go(appRoutes[i].path),
                  labelType: NavigationRailLabelType.selected,
                  destinations: [
                    for (final route in appRoutes)
                      NavigationRailDestination(
                        icon: Icon(route.icon),
                        selectedIcon: Icon(route.selectedIcon),
                        label: Text(route.labelOf(context)),
                      ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialMobile(BuildContext context, int selected) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (i) => context.go(appRoutes[i].path),
        destinations: [
          for (final route in appRoutes)
            NavigationDestination(
              icon: Icon(route.icon),
              selectedIcon: Icon(route.selectedIcon),
              label: route.labelOf(context),
            ),
        ],
      ),
    );
  }

  Widget _buildWindowTitleBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (_) => windowManager.startDragging(),
            onDoubleTap: () {
              windowManager.isMaximized().then((isMaximized) {
                if (isMaximized) {
                  windowManager.unmaximize();
                } else {
                  windowManager.maximize();
                }
              });
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: const Text('Yamada', style: TextStyle(fontSize: 14)),
            ),
          ),
        ),
        SizedBox(
          width: 138,
          height: 40,
          child: WindowCaption(
            brightness: Theme.of(context).brightness,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  // ==================== Fluent ====================
  Widget _buildFluent(BuildContext context) {
    final selected = _indexOf(currentPath);
    final state = GoRouterState.of(context);
    final body = IndexedStack(
      index: selected,
      children: [
        for (final route in appRoutes) route.builder(context, state),
      ],
    );

    return fluent.NavigationView(
      titleBar: fluent.TitleBar(
        isBackButtonEnabled: true,
        height: 40,
        title: const Align(
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
        captionControls: const _WindowActions(),
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
        selected: selected,
        onChanged: (index) => context.go(appRoutes[index].path),
        displayMode: fluent.PaneDisplayMode.top,
        items: [
          for (final route in appRoutes.take(1))
            fluent.PaneItem(
              icon: Icon(route.fluentIcon),
              title: Text(route.labelOf(context)),
              body: body,
            ),
        ],
        footerItems: [
          for (final route in appRoutes.skip(1))
            fluent.PaneItem(
              icon: Icon(route.fluentIcon),
              title: Text(route.labelOf(context)),
              body: body,
            ),
        ],
      ),
    );
  }

  // ==================== Helpers ====================
  int _indexOf(String path) {
    final i = appRoutes.indexWhere((r) => r.path == path);
    return i < 0 ? 0 : i;
  }
}

class _WindowActions extends StatelessWidget {
  const _WindowActions();

  @override
  Widget build(BuildContext context) {
    final theme = fluent.FluentTheme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: 138,
        height: 40,
        child: WindowCaption(
          brightness: theme.brightness,
          backgroundColor: Colors.transparent,
        ),
      ),
    ]);
  }
}
