import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/playlist_model.dart';
import 'package:yamada/providers/audio/audio_player_provider.dart';
import 'package:yamada/providers/library/playlist_provider.dart';
import 'package:yamada/components/empty_state.dart';
import 'package:yamada/components/library/create_playlist_dialog.dart';
import 'package:yamada/utils/format_util.dart';

class PlaylistDetailPage extends ConsumerWidget {
  final int playlistId;

  const PlaylistDetailPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final playlistsAsync = ref.watch(playlistsProvider);
    final playlist = playlistsAsync.maybeWhen(
      data: (list) => list.where((p) => p.id == playlistId).firstOrNull,
      orElse: () => null,
    );
    final tracksAsync = ref.watch(playlistTracksProvider(playlistId));

    final appBarTitle = playlist?.name ?? l10n.home;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          if (playlist != null)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (v) {
                if (v == 'rename') _rename(context, ref, playlist);
                if (v == 'delete') _delete(context, ref, playlist);
                if (v == 'play_all') _playAll(ref, tracksAsync);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'play_all',
                  child: Row(children: [
                    const Icon(Icons.play_arrow_rounded),
                    const SizedBox(width: 8),
                    Text(l10n.playerPlayNow),
                  ]),
                ),
                PopupMenuItem(
                  value: 'rename',
                  child: Row(children: [
                    const Icon(Icons.edit_outlined),
                    const SizedBox(width: 8),
                    Text(l10n.libraryPlaylistRename),
                  ]),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(children: [
                    const Icon(Icons.delete_outline_rounded),
                    const SizedBox(width: 8),
                    Text(l10n.libraryPlaylistDelete),
                  ]),
                ),
              ],
            ),
        ],
      ),
      body: tracksAsync.when(
        data: (tracks) {
          if (tracks.isEmpty) {
            return EmptyState(
              icon: Icons.playlist_play_rounded,
              title: l10n.libraryPlaylistDetailEmpty,
              subtitle: l10n.libraryPlaylistDetailEmptyHint,
            );
          }
          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) =>
                _PlaylistTrackTile(track: tracks[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          icon: Icons.error_outline_rounded,
          title: e.toString(),
        ),
      ),
    );
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    PlaylistModel playlist,
  ) async {
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

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    PlaylistModel playlist,
  ) async {
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
      if (context.mounted) context.pop();
    }
  }

  void _playAll(
    WidgetRef ref,
    AsyncValue<List<PlaylistTrackModel>> tracksAsync,
  ) {
    final tracks = tracksAsync.maybeWhen(
      data: (t) => t,
      orElse: () => <PlaylistTrackModel>[],
    );
    if (tracks.isEmpty) return;
    final service = ref.read(audioPlayerProvider);
    service.playTrack(tracks.first.toTrackDetail());
    for (var i = 1; i < tracks.length; i++) {
      service.addToQueue(tracks[i].toTrackDetail());
    }
  }
}

class _PlaylistTrackTile extends ConsumerWidget {
  final PlaylistTrackModel track;

  const _PlaylistTrackTile({required this.track});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final subtitleParts = <String>[
      if (track.artist != null) track.artist!,
      if (track.durationMs != null) formatDuration(track.durationMs!),
    ];

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: 48,
          height: 48,
          child: track.coverUrl == null
              ? Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.music_note),
                )
              : Image.network(
                  track.coverUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.music_note),
                  ),
                ),
        ),
      ),
      title: Text(
        track.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitleParts.isEmpty
          ? null
          : Text(
              subtitleParts.join(' · '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded),
            tooltip: l10n.playerPlayNow,
            onPressed: () {
              ref.read(audioPlayerProvider).playTrack(track.toTrackDetail());
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline_rounded),
            tooltip: l10n.libraryRemoveFromPlaylist,
            onPressed: () {
              ref.read(playlistEditorProvider).removeTrack(track.id);
            },
          ),
        ],
      ),
    );
  }
}
