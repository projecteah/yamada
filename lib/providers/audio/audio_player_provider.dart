import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/providers/sources_provider.dart';
import 'package:yamada/services/audio_player_service.dart';

part 'audio_player_provider.g.dart';

@riverpod
AudioPlayerService audioPlayer(Ref ref) {
  final sources = ref.watch(audioStreamSourcesProvider);
  final service = AudioPlayerService(sources);
  ref.onDispose(service.dispose);
  return service;
}
