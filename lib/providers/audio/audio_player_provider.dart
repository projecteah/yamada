import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/providers/sources_provider.dart';
import 'package:yamada/utils/audio_source_util.dart';

part 'audio_player_provider.g.dart';

class AudioPlayerState {
  final List<TrackDetail> queue;
  final int currentIndex;
  final bool isPlaying;
  final bool isBuffering;
  final Duration position;
  final Duration duration;
  final String? error;

  const AudioPlayerState({
    this.queue = const [],
    this.currentIndex = -1,
    this.isPlaying = false,
    this.isBuffering = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.error,
  });

  TrackDetail? get currentTrack =>
      currentIndex >= 0 && currentIndex < queue.length
          ? queue[currentIndex]
          : null;

  bool get hasTrack => queue.isNotEmpty;

  AudioPlayerState copyWith({
    List<TrackDetail>? queue,
    int? currentIndex,
    bool? isPlaying,
    bool? isBuffering,
    Duration? position,
    Duration? duration,
    String? error,
    bool clearError = false,
  }) =>
      AudioPlayerState(
        queue: queue ?? this.queue,
        currentIndex: currentIndex ?? this.currentIndex,
        isPlaying: isPlaying ?? this.isPlaying,
        isBuffering: isBuffering ?? this.isBuffering,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        error: clearError ? null : (error ?? this.error),
      );
}

@riverpod
class AudioPlayerNotifier extends _$AudioPlayerNotifier {
  late final AudioPlayer _audioPlayer;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _audioSourceSet = false;

  @override
  AudioPlayerState build() {
    _audioPlayer = AudioPlayer();
    _initAudioSession(_audioPlayer);
    _subscribeToStreams(_audioPlayer);
    ref.onDispose(() {
      for (final sub in _subscriptions) {
        sub.cancel();
      }
      _subscriptions.clear();
      _audioPlayer.dispose();
    });
    return const AudioPlayerState();
  }

  Future<void> _initAudioSession(AudioPlayer player) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void _subscribeToStreams(AudioPlayer player) {
    _subscriptions.add(player.playerStateStream.listen(_onPlayerState));
    _subscriptions.add(player.sequenceStateStream.listen(_onSequenceState));
    _subscriptions.add(player.positionStream.listen(_onPosition));
    _subscriptions.add(player.durationStream.listen(_onDuration));
  }

  void _onPlayerState(PlayerState playerState) {
    final isBuffering =
        playerState.processingState == ProcessingState.buffering ||
            playerState.processingState == ProcessingState.loading;
    state = state.copyWith(
      isPlaying: playerState.playing,
      isBuffering: isBuffering,
    );
  }

  void _onSequenceState(SequenceState? sequenceState) {
    final index = sequenceState?.currentIndex ?? -1;
    if (index != state.currentIndex) {
      state = state.copyWith(currentIndex: index);
    }
  }

  void _onPosition(Duration position) {
    state = state.copyWith(position: position);
  }

  void _onDuration(Duration? duration) {
    state = state.copyWith(duration: duration ?? Duration.zero);
  }

  Future<void> playTrack(TrackDetail track) async {
    state = state.copyWith(isBuffering: true, clearError: true);
    try {
      final sources = ref.read(audioStreamSourcesProvider);
      final source = await resolveAudioSource(track, sources);
      final player = _audioPlayer;
      await player.setAudioSources([source]);
      _audioSourceSet = true;
      state = state.copyWith(
        queue: [track],
        currentIndex: 0,
        isBuffering: false,
      );
      await player.play();
    } catch (e) {
      state = state.copyWith(isBuffering: false, error: e.toString());
    }
  }

  Future<void> addToQueue(TrackDetail track) async {
    state = state.copyWith(clearError: true);
    try {
      final sources = ref.read(audioStreamSourcesProvider);
      final source = await resolveAudioSource(track, sources);
      final player = _audioPlayer;
      if (!_audioSourceSet) {
        await player.setAudioSources([source]);
        _audioSourceSet = true;
      } else {
        await player.addAudioSource(source);
      }
      state = state.copyWith(queue: [...state.queue, track]);
      if (!player.playing) {
        await player.play();
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> play() => _audioPlayer.play();

  Future<void> pause() => _audioPlayer.pause();

  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  Future<void> skipToNext() => _audioPlayer.seekToNext();

  Future<void> skipToPrevious() => _audioPlayer.seekToPrevious();
}
