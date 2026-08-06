import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/components/audio/player_controls.dart';
import 'package:yamada/components/audio/player_progress_bar.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/providers/audio/audio_player_provider.dart';
import 'package:yamada/services/audio_player_service.dart';
import 'package:yamada/utils/format_util.dart';

class NowPlayingBar extends ConsumerWidget {
  static const _compactThreshold = 720.0;

  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(audioPlayerProvider);
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: service,
      builder: (context, _) {
        if (service.currentTrack == null) return const SizedBox.shrink();

        return Material(
          color: theme.colorScheme.surfaceContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PlayerProgressBar(
                position: service.position,
                duration: service.duration,
                buffering: service.isBuffering,
                onSeek: service.seek,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < _compactThreshold;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: isCompact
                        ? _CompactControls(service: service)
                        : _ExpandedControls(service: service),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpandedControls extends StatelessWidget {
  final AudioPlayerService service;

  const _ExpandedControls({required this.service});

  @override
  Widget build(BuildContext context) {
    final track = service.currentTrack!;
    return Row(
      children: [
        TrackThumbnail(track: track, size: 48),
        const SizedBox(width: 12),
        Expanded(
          child: _TrackInfo(track: track, error: service.error),
        ),
        PlayerControls(service: service),
        const SizedBox(width: 12),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: PositionDurationText(
              position: service.position,
              duration: service.duration,
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactControls extends StatelessWidget {
  final AudioPlayerService service;

  const _CompactControls({required this.service});

  @override
  Widget build(BuildContext context) {
    final track = service.currentTrack!;
    return Row(
      children: [
        TrackThumbnail(track: track, size: 44),
        const SizedBox(width: 12),
        Expanded(
          child: _TrackInfo(track: track, error: service.error),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 48,
          child: PositionDurationText(
            position: service.position,
            duration: service.duration,
            compact: true,
          ),
        ),
        const SizedBox(width: 4),
        CompactPlayerControls(service: service),
      ],
    );
  }
}

class TrackThumbnail extends StatelessWidget {
  final TrackDetail? track;
  final double size;

  const TrackThumbnail({
    super.key,
    required this.track,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: track?.coverUrl != null
          ? Image.network(
              track!.coverUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(theme),
            )
          : _placeholder(theme),
    );
  }

  Widget _placeholder(ThemeData theme) => Container(
        width: size,
        height: size,
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.music_note,
          size: size * 0.45,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
}

class _TrackInfo extends StatelessWidget {
  final TrackDetail track;
  final String? error;

  const _TrackInfo({required this.track, required this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
            error!,
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
    );
  }
}

class PositionDurationText extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final bool compact;

  const PositionDurationText({
    super.key,
    required this.position,
    required this.duration,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    if (compact) {
      return Text(
        formatDuration(position.inMilliseconds),
        style: style,
        textAlign: TextAlign.right,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(formatDuration(position.inMilliseconds), style: style),
        Text(' / ', style: style),
        Text(formatDuration(duration.inMilliseconds), style: style),
      ],
    );
  }
}
