String formatDuration(int ms) {
  final total = ms ~/ 1000;
  final m = total ~/ 60;
  final s = total % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

int parseDurationToMs(String duration) {
  final parts = duration.split(':');
  if (parts.length != 2) return 0;
  final minutes = int.tryParse(parts[0]) ?? 0;
  final seconds = int.tryParse(parts[1]) ?? 0;
  return (minutes * 60 + seconds) * 1000;
}
