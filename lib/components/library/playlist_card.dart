import 'package:flutter/material.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlist;
  final String? coverUrl;
  final int trackCount;
  final VoidCallback onTap;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;
  final bool compact;

  const PlaylistCard({
    super.key,
    required this.playlist,
    required this.coverUrl,
    required this.trackCount,
    required this.onTap,
    this.onRename,
    this.onDelete,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) return _buildListTile(context);
    return _buildGridCard(context);
  }

  Widget _buildGridCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: _Cover(
                coverUrl: coverUrl,
                fallbackIcon: Icons.queue_music_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    playlist.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$trackCount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(
          width: 56,
          height: 56,
          child: _Cover(
            coverUrl: coverUrl,
            fallbackIcon: Icons.queue_music_rounded,
          ),
        ),
      ),
      title: Text(
        playlist.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '$trackCount',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: (onRename != null || onDelete != null)
          ? PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (v) {
                if (v == 'rename') onRename?.call();
                if (v == 'delete') onDelete?.call();
              },
              itemBuilder: (context) => [
                if (onRename != null)
                  PopupMenuItem(
                    value: 'rename',
                    child: Row(children: [
                      const Icon(Icons.edit_outlined),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.libraryPlaylistRename),
                    ]),
                  ),
                if (onDelete != null)
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(children: [
                      const Icon(Icons.delete_outline_rounded),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.libraryPlaylistDelete),
                    ]),
                  ),
              ],
            )
          : null,
      onTap: onTap,
    );
  }
}

class _Cover extends StatelessWidget {
  final String? coverUrl;
  final IconData fallbackIcon;

  const _Cover({required this.coverUrl, required this.fallbackIcon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (coverUrl == null || coverUrl!.isEmpty) {
      return Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          fallbackIcon,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }
    return Image.network(
      coverUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          fallbackIcon,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
