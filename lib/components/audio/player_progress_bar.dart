import 'package:flutter/material.dart';

class PlayerProgressBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final bool buffering;
  final ValueChanged<Duration>? onSeek;

  const PlayerProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.buffering,
    this.onSeek,
  });

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalMs = widget.duration.inMilliseconds;
    final value = _dragValue ??
        (totalMs > 0
            ? (widget.position.inMilliseconds / totalMs).clamp(0.0, 1.0)
            : 0.0);

    if (widget.buffering) {
      return LinearProgressIndicator(
        minHeight: 2,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
      );
    }

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
        activeTrackColor: theme.colorScheme.primary,
        inactiveTrackColor: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Slider(
        value: value,
        onChanged: totalMs > 0 && widget.onSeek != null
            ? (v) => setState(() => _dragValue = v)
            : null,
        onChangeStart: (_) => _dragValue = value,
        onChangeEnd: widget.onSeek == null
            ? null
            : (v) {
                widget.onSeek!(
                  Duration(milliseconds: (v * totalMs).round()),
                );
                setState(() => _dragValue = null);
              },
      ),
    );
  }
}
