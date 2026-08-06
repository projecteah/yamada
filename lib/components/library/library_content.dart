import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/playlist_model.dart';
import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/providers/library/playlist_provider.dart';
import 'package:yamada/components/empty_state.dart';
import 'package:yamada/components/library/playlist_card.dart';
import 'package:yamada/components/library/create_playlist_dialog.dart';
import 'package:yamada/utils/streaming_platforms_util.dart';

enum LibraryViewMode { grid, list }

class LibraryContent extends ConsumerStatefulWidget {
  const LibraryContent({super.key});

  @override
  ConsumerState<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends ConsumerState<LibraryContent> {
  LibraryViewMode _viewMode = LibraryViewMode.grid;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final platforms = ref.watch(streamingPlatformsProvider);
    final enabledPlatforms = platforms.where((p) => p.enabled).toList();

    final tabs = <_LibraryTab>[
      _LibraryTab.local(label: l10n.libraryTabLocal),
      for (final p in enabledPlatforms)
        _LibraryTab.platform(
          id: p.id,
          label: platformLabel(p.id, l10n),
        ),
    ];

    if (_selectedTab >= tabs.length) _selectedTab = 0;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < tabs.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(tabs[i].label),
                              selected: _selectedTab == i,
                              onSelected: (_) =>
                                  setState(() => _selectedTab = i),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                _ViewModeToggle(
                  mode: _viewMode,
                  onChanged: (m) => setState(() => _viewMode = m),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: tabs[_selectedTab].when(
              local: () => _LocalPlaylistsView(viewMode: _viewMode),
              platform: (id) => _StreamingComingSoonView(id: id),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewModeToggle extends StatelessWidget {
  final LibraryViewMode mode;
  final ValueChanged<LibraryViewMode> onChanged;

  const _ViewModeToggle({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SegmentedButton<LibraryViewMode>(
      segments: [
        ButtonSegment(
          value: LibraryViewMode.grid,
          icon: const Icon(Icons.grid_view_rounded),
          tooltip: l10n.libraryViewGrid,
        ),
        ButtonSegment(
          value: LibraryViewMode.list,
          icon: const Icon(Icons.view_list_rounded),
          tooltip: l10n.libraryViewList,
        ),
      ],
      selected: {mode},
      onSelectionChanged: (s) => onChanged(s.first),
      showSelectedIcon: false,
      style: const ButtonStyle(
        visualDensity: VisualDensity(horizontal: -3, vertical: -2),
      ),
    );
  }
}

abstract class _LibraryTab {
  const _LibraryTab();
  factory _LibraryTab.local({required String label}) = _LocalTab;
  factory _LibraryTab.platform({
    required StreamingPlatformId id,
    required String label,
  }) = _PlatformTab;

  String get label;

  R when<R>({
    required R Function() local,
    required R Function(StreamingPlatformId id) platform,
  });
}

class _LocalTab extends _LibraryTab {
  @override
  final String label;
  const _LocalTab({required this.label});

  @override
  R when<R>({
    required R Function() local,
    required R Function(StreamingPlatformId id) platform,
  }) =>
      local();
}

class _PlatformTab extends _LibraryTab {
  final StreamingPlatformId id;
  @override
  final String label;
  const _PlatformTab({required this.id, required this.label});

  @override
  R when<R>({
    required R Function() local,
    required R Function(StreamingPlatformId id) platform,
  }) =>
      platform(id);
}

class _LocalPlaylistsView extends ConsumerWidget {
  final LibraryViewMode viewMode;

  const _LocalPlaylistsView({required this.viewMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final playlistsAsync = ref.watch(playlistsProvider);

    return playlistsAsync.when(
      data: (playlists) {
        if (playlists.isEmpty) {
          return EmptyState(
            icon: Icons.playlist_play_rounded,
            title: l10n.libraryPlaylistEmpty,
            subtitle: l10n.libraryPlaylistEmptyHint,
          );
        }
        if (viewMode == LibraryViewMode.grid) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 4.0;
                const maxCardWidth = 180.0;
                final available = constraints.maxWidth;
                final fitByMax = (available / maxCardWidth).floor();
                final columns = fitByMax < 3 ? 3 : fitByMax;
                final cardWidth =
                    (available - spacing * (columns - 1)) / columns;
                return Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      for (final playlist in playlists)
                        SizedBox(
                          width: cardWidth,
                          child: _PlaylistCardItem(
                            playlist: playlist,
                            compact: false,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return _PlaylistCardItem(
              playlist: playlist,
              compact: true,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => EmptyState(
        icon: Icons.error_outline_rounded,
        title: e.toString(),
      ),
    );
  }
}

class _PlaylistCardItem extends ConsumerWidget {
  final PlaylistModel playlist;
  final bool compact;

  const _PlaylistCardItem({required this.playlist, required this.compact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksAsync = ref.watch(playlistTracksProvider(playlist.id));
    final tracks = tracksAsync.maybeWhen(
      data: (t) => t,
      orElse: () => const <PlaylistTrackModel>[],
    );
    final coverUrl = playlist.coverUrl ??
        tracks.where((t) => t.coverUrl != null).firstOrNull?.coverUrl;
    return PlaylistCard(
      playlist: playlist,
      coverUrl: coverUrl,
      trackCount: tracks.length,
      compact: compact,
      onTap: () => context.push('/playlist/${playlist.id}'),
      onRename: () => _showRenameDialog(context, ref),
      onDelete: () => _confirmDelete(context, ref),
    );
  }

  Future<void> _showRenameDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => CreatePlaylistDialog(
        initialName: playlist.name,
        initialDescription: playlist.description,
        confirmLabel: l10n.libraryPlaylistRename,
      ),
    );
    if (result == null) return;
    await ref.read(playlistEditorProvider).renamePlaylist(
          id: playlist.id,
          name: result['name']!,
        );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.libraryPlaylistDeleteConfirmTitle),
        content: Text(l10n.libraryPlaylistDeleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.libraryPlaylistDelete),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(playlistEditorProvider).deletePlaylist(playlist.id);
    }
  }
}

class _StreamingComingSoonView extends StatelessWidget {
  final StreamingPlatformId id;

  const _StreamingComingSoonView({required this.id});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return EmptyState(
      icon: Icons.cloud_off_rounded,
      title: l10n.libraryStreamingComingSoon,
      subtitle: l10n.libraryStreamingComingSoonHint,
    );
  }
}
