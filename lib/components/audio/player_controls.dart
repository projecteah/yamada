import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/services/audio_player_service.dart';

class PlayerControls extends StatelessWidget {
  final AudioPlayerService service;
  final double playPauseSize;

  const PlayerControls({
    super.key,
    required this.service,
    this.playPauseSize = 36,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            service.shuffleModeEnabled
                ? Icons.shuffle_rounded
                : Icons.shuffle_outlined,
          ),
          color: service.shuffleModeEnabled ? theme.colorScheme.primary : null,
          tooltip: service.shuffleModeEnabled
              ? l10n.playerShuffleOff
              : l10n.playerShuffleOn,
          onPressed: () =>
              service.setShuffleModeEnabled(!service.shuffleModeEnabled),
        ),
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          tooltip: l10n.playerPrevious,
          onPressed: service.hasPrevious ? service.seekToPrevious : null,
        ),
        _PlayPauseButton(
          service: service,
          size: playPauseSize,
        ),
        IconButton(
          icon: const Icon(Icons.skip_next_rounded),
          tooltip: l10n.playerNext,
          onPressed: service.hasNext ? service.seekToNext : null,
        ),
        _LoopButton(
          loopMode: service.loopMode,
          onTap: () => service.setLoopMode(_nextLoopMode(service.loopMode)),
        ),
      ],
    );
  }

  LoopMode _nextLoopMode(LoopMode mode) => switch (mode) {
        LoopMode.off => LoopMode.all,
        LoopMode.all => LoopMode.one,
        LoopMode.one => LoopMode.off,
      };
}

class CompactPlayerControls extends StatelessWidget {
  final AudioPlayerService service;

  const CompactPlayerControls({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return _PlayPauseButton(service: service, size: 28);
  }
}

class _PlayPauseButton extends StatelessWidget {
  final AudioPlayerService service;
  final double size;

  const _PlayPauseButton({required this.service, required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      iconSize: size,
      icon: service.isBuffering
          ? SizedBox(
              width: size * 0.7,
              height: size * 0.7,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            )
          : Icon(service.isPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded),
      onPressed: service.isBuffering
          ? null
          : () => service.isPlaying ? service.pause() : service.play(),
    );
  }
}

class _LoopButton extends StatelessWidget {
  final LoopMode loopMode;
  final VoidCallback onTap;

  const _LoopButton({required this.loopMode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isActive = loopMode != LoopMode.off;

    return IconButton(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            loopMode == LoopMode.one
                ? Icons.repeat_one_rounded
                : Icons.repeat_rounded,
            color: isActive ? theme.colorScheme.primary : null,
          ),
          if (isActive)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      tooltip: switch (loopMode) {
        LoopMode.off => l10n.playerRepeatAll,
        LoopMode.all => l10n.playerRepeatOne,
        LoopMode.one => l10n.playerRepeatOff,
      },
      onPressed: onTap,
    );
  }
}
