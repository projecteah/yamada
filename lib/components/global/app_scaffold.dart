import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:window_manager/window_manager.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/components/audio/now_playing_bar.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final String currentPath;

  const AppScaffold({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = ref.watch(designProvider).isFluent;
    return isFluent ? _buildFluent(context) : _buildMaterial(context);
  }

  static const double _wideBreakpoint = 600;

  static final List<_Nav> _navs = [
    _Nav(
      path: '/',
      icon: Icons.my_library_music_outlined,
      selectedIcon: Icons.my_library_music_rounded,
      fluentIcon: fluent.WindowsIcons.home,
      labelOf: (ctx) => AppLocalizations.of(ctx)!.home,
    ),
    _Nav(
      path: '/search',
      icon: Icons.search_outlined,
      selectedIcon: Icons.search_rounded,
      fluentIcon: fluent.WindowsIcons.search,
      labelOf: (ctx) => AppLocalizations.of(ctx)!.search,
    ),
    _Nav(
      path: '/settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      fluentIcon: fluent.WindowsIcons.settings,
      labelOf: (ctx) => AppLocalizations.of(ctx)!.setting,
    ),
  ];

  Widget _buildMaterial(BuildContext context) {
    final selected = _indexOf(currentPath);
    final isWideScreen = MediaQuery.of(context).size.width >= _wideBreakpoint;
    final showTitleBar =
        Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    if (isWideScreen) {
      return _buildMaterialWide(context, selected, showTitleBar);
    }
    return _buildMaterialMobile(context, selected, showTitleBar);
  }

  Widget _buildMaterialWide(
    BuildContext context,
    int selected,
    bool showTitleBar,
  ) {
    return Scaffold(
      body: Column(
        children: [
          if (showTitleBar) _buildMaterialWindowTitleBar(context),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: selected,
                    onDestinationSelected: (i) => context.go(_navs[i].path),
                    labelType: NavigationRailLabelType.selected,
                    destinations: [
                      for (final nav in _navs)
                        NavigationRailDestination(
                          icon: Icon(nav.icon),
                          selectedIcon: Icon(nav.selectedIcon),
                          label: Text(nav.labelOf(context)),
                        ),
                    ],
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  Expanded(
                    child: Material(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: child,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NowPlayingBar(),
    );
  }

  Widget _buildMaterialMobile(
    BuildContext context,
    int selected,
    bool showTitleBar,
  ) {
    return Scaffold(
      body: Column(
        children: [
          if (showTitleBar) _buildMaterialWindowTitleBar(context),
          Expanded(child: child),
          const NowPlayingBar(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (i) => context.go(_navs[i].path),
        destinations: [
          for (final nav in _navs)
            NavigationDestination(
              icon: Icon(nav.icon),
              selectedIcon: Icon(nav.selectedIcon),
              label: nav.labelOf(context),
            ),
        ],
      ),
    );
  }

  Widget _buildMaterialWindowTitleBar(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        elevation: 8,
        color: theme.colorScheme.surfaceContainer,
        child: Row(
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
        ));
  }

  Widget _buildFluent(BuildContext context) {
    final selected = _indexOf(currentPath);

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
        captionControls: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 138,
              height: 40,
              child: WindowCaption(
                brightness: fluent.FluentTheme.of(context).brightness,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
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
        onChanged: (index) => context.go(_navs[index].path),
        displayMode: fluent.PaneDisplayMode.top,
        items: [
          for (final nav in _navs)
            fluent.PaneItem(
              icon: Icon(nav.fluentIcon),
              title: Text(nav.labelOf(context)),
              body: child,
            ),
        ],
      ),
    );
  }

  int _indexOf(String path) {
    for (int i = _navs.length - 1; i >= 0; i--) {
      if (path == _navs[i].path || path.startsWith('${_navs[i].path}/')) {
        return i;
      }
    }
    return 0;
  }
}

class _Nav {
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final IconData fluentIcon;
  final String Function(BuildContext) labelOf;

  const _Nav({
    required this.path,
    required this.icon,
    required this.selectedIcon,
    required this.fluentIcon,
    required this.labelOf,
  });
}
