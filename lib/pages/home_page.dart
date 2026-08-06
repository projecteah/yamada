import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';
import 'package:yamada/providers/library/playlist_provider.dart';
import 'package:yamada/components/library/library_content.dart';
import 'package:yamada/components/library/create_playlist_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = ref.watch(designProvider).isFluent;
    final l10n = AppLocalizations.of(context)!;
    final createAction = IconButton(
      icon: const Icon(Icons.add_rounded),
      tooltip: l10n.libraryCreatePlaylist,
      onPressed: () => _showCreateDialog(context, ref),
    );
    return isFluent
        ? fluent.ScaffoldPage(
            header: fluent.PageHeader(
              title: Text(l10n.home),
              commandBar: fluent.CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  fluent.CommandBarButton(
                    icon: const Icon(Icons.add_rounded),
                    label: Text(l10n.libraryCreatePlaylist),
                    onPressed: () => _showCreateDialog(context, ref),
                  ),
                ],
              ),
            ),
            content: const LibraryContent(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(l10n.home),
              actions: [createAction],
            ),
            body: const LibraryContent(),
          );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) =>
          CreatePlaylistDialog(confirmLabel: l10n.libraryCreatePlaylist),
    );
    if (result == null) return;
    await ref.read(playlistEditorProvider).createPlaylist(
          name: result['name']!,
          description: result['description']?.isEmpty == true
              ? null
              : result['description'],
        );
  }
}
