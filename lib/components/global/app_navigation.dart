import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:window_manager/window_manager.dart';
import 'package:go_router/go_router.dart';

// import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/appearance_provider.dart';
import 'package:yamada/pages/_router.dart';
import 'window_actions.dart';

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
    return isFluent ? buildFluent(context) : buildMaterial(context);
  }

  Widget buildMaterial(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexOf(currentPath),
        onDestinationSelected: (index) => context.go(appRoutes[index].path),
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

  Widget buildFluent(BuildContext context) {
    final selected = _indexOf(currentPath);
    final state = GoRouterState.of(context);
    final body = IndexedStack(
      index: selected,
      children: [for (final route in appRoutes) route.builder(context, state)],
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

  int _indexOf(String path) {
    final i = appRoutes.indexWhere((r) => r.path == path);
    return i < 0 ? 0 : i;
  }
}
