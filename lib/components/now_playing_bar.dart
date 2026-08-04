import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/audio/audio_player_provider.dart';
import 'package:yamada/utils/format_util.dart';

class NowPlayingBar extends ConsumerWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasTrack = ref.watch(audioPlayerProvider.select((s) => s.hasTrack));
    if (!hasTrack) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      color: theme.colorScheme.surfaceContainer,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ProgressBar(),
          _NowPlayingContent(),
        ],
      ),
    );
  }
}

class _ProgressBar extends ConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(audioPlayerProvider.select((s) => s.position));
    final duration = ref.watch(audioPlayerProvider.select((s) => s.duration));
    final isBuffering =
        ref.watch(audioPlayerProvider.select((s) => s.isBuffering));

    final value = duration.inMilliseconds > 0
        ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
        : null;

    return LinearProgressIndicator(
      value: isBuffering ? null : value,
      minHeight: 2,
    );
  }
}

class _NowPlayingContent extends ConsumerWidget {
  const _NowPlayingContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final track = ref.watch(audioPlayerProvider.select((s) => s.currentTrack));
    final isPlaying = ref.watch(audioPlayerProvider.select((s) => s.isPlaying));
    final isBuffering =
        ref.watch(audioPlayerProvider.select((s) => s.isBuffering));
    final error = ref.watch(audioPlayerProvider.select((s) => s.error));

    if (track == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: track.coverUrl != null
                ? Image.network(
                    track.coverUrl!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _defaultThumbnail(theme),
                  )
                : _defaultThumbnail(theme),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  track.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (error != null)
                  Text(
                    error,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  )
                else if (track.artist != null)
                  Text(
                    track.artist!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (track.durationMs != null)
            Text(
              formatDuration(track.durationMs!),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          IconButton(
            icon: isBuffering
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.primary,
                    ),
                  )
                : Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                  ),
            tooltip: isPlaying ? l10n.playerPause : l10n.playerPlay,
            onPressed: isBuffering
                ? null
                : () {
                    final notifier = ref.read(audioPlayerProvider.notifier);
                    isPlaying ? notifier.pause() : notifier.play();
                  },
          ),
        ],
      ),
    );
  }

  Widget _defaultThumbnail(ThemeData theme) => Container(
        width: 44,
        height: 44,
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.music_note,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
}
