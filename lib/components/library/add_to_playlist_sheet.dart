import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/playlist_model.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/providers/library/playlist_provider.dart';
import 'package:yamada/components/library/create_playlist_dialog.dart';

class AddToPlaylistSheet extends ConsumerWidget {
  final TrackDetail track;

  const AddToPlaylistSheet({super.key, required this.track});

  static Future<void> show(BuildContext context, TrackDetail track) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddToPlaylistSheet(track: track),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final playlistsAsync = ref.watch(playlistsProvider);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.libraryAddToPlaylist,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.add_rounded),
              ),
              title: Text(l10n.libraryCreateNewPlaylist),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final nav = Navigator.of(context);
                final result = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (_) =>
                      CreatePlaylistDialog(confirmLabel: l10n.libraryCreatePlaylist),
                );
                if (result == null) return;
                final id = await ref
                    .read(playlistEditorProvider)
                    .createPlaylist(
                      name: result['name']!,
                      description: result['description']?.isEmpty == true
                          ? null
                          : result['description'],
                    );
                if (id > 0) {
                  await ref.read(playlistEditorProvider).addTrack(
                        playlistId: id,
                        track: track,
                      );
                }
                if (!context.mounted) return;
                nav.pop();
                messenger.showSnackBar(
                  SnackBar(content: Text(l10n.libraryAddedToPlaylist)),
                );
              },
            ),
            const Divider(height: 1),
            Flexible(
              child: playlistsAsync.when(
                data: (playlists) {
                  if (playlists.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.libraryPlaylistEmpty,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      return _PlaylistPickTile(
                        playlist: playlist,
                        track: track,
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, _) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(e.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistPickTile extends ConsumerStatefulWidget {
  final PlaylistModel playlist;
  final TrackDetail track;

  const _PlaylistPickTile({required this.playlist, required this.track});

  @override
  ConsumerState<_PlaylistPickTile> createState() => _PlaylistPickTileState();
}

class _PlaylistPickTileState extends ConsumerState<_PlaylistPickTile> {
  bool? _alreadyIn;
  bool _busy = false;

  Future<void> _check() async {
    final result = await ref
        .read(playlistEditorProvider)
        .isTrackInPlaylist(
          playlistId: widget.playlist.id,
          track: widget.track,
        );
    if (mounted) setState(() => _alreadyIn = result);
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: 48,
          height: 48,
          child: widget.playlist.coverUrl == null
              ? Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.queue_music_rounded),
                )
              : Image.network(
                  widget.playlist.coverUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.queue_music_rounded),
                  ),
                ),
        ),
      ),
      title: Text(
        widget.playlist.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _alreadyIn == null
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : _alreadyIn == true
              ? Text(
                  l10n.libraryTrackAlreadyInPlaylist,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : _busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.add_rounded, color: theme.colorScheme.primary),
      onTap: _alreadyIn == false && !_busy
          ? () async {
              final messenger = ScaffoldMessenger.of(context);
              final nav = Navigator.of(context);
              setState(() => _busy = true);
              await ref
                  .read(playlistEditorProvider)
                  .addTrack(
                    playlistId: widget.playlist.id,
                    track: widget.track,
                  );
              if (!mounted) return;
              nav.pop();
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.libraryAddedToPlaylist)),
              );
            }
          : null,
    );
  }
}
