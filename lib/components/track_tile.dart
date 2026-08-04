import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/search_model.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/providers/audio/audio_player_provider.dart';
import 'package:yamada/utils/streaming_platforms_util.dart';
import 'package:yamada/utils/format_util.dart';

class TrackTile extends ConsumerWidget {
  final Track track;
  final bool showPlatform;

  const TrackTile({
    super.key,
    required this.track,
    this.showPlatform = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final subtitleParts = <String>[
      if (track.artist != null) track.artist!,
      if (showPlatform) platformLabel(track.sourceType, l10n),
      if (track.durationMs != null) formatDuration(track.durationMs!),
    ];

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: track.thumbnailUrl == null
            ? Container(
                width: 56,
                height: 56,
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.music_note),
              )
            : Image.network(
                track.thumbnailUrl!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.music_note),
                ),
              ),
      ),
      title: Text(
        track.title,
        maxLines: 2,
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
              ref
                  .read(audioPlayerProvider.notifier)
                  .playTrack(TrackDetail.fromTrack(track));
            },
          ),
          IconButton(
            icon: const Icon(Icons.playlist_add_rounded),
            tooltip: l10n.playerAddToQueue,
            onPressed: () {
              ref
                  .read(audioPlayerProvider.notifier)
                  .addToQueue(TrackDetail.fromTrack(track));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.playerAddToQueue)),
              );
            },
          ),
        ],
      ),
    );
  }
}
