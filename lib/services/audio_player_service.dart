import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/sources/base_source.dart';
import 'package:yamada/utils/audio_source_util.dart';

class AudioPlayerService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  final Map<StreamingPlatformId, AudioStreamSource> _sources;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _audioSourceSet = false;

  TrackDetail? _currentTrack;
  bool _isPlaying = false;
  bool _isBuffering = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _shuffleModeEnabled = false;
  LoopMode _loopMode = LoopMode.off;
  String? _error;

  TrackDetail? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  bool get isBuffering => _isBuffering;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get shuffleModeEnabled => _shuffleModeEnabled;
  LoopMode get loopMode => _loopMode;
  String? get error => _error;
  bool get hasPrevious => _player.hasPrevious;
  bool get hasNext => _player.hasNext;

  AudioPlayerService(this._sources) {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _subscriptions.add(_player.sequenceStateStream.listen((state) {
      _currentTrack = _trackFromSequence(state);
      notifyListeners();
    }));
    _subscriptions.add(_player.playingStream.listen((playing) {
      _isPlaying = playing;
      notifyListeners();
    }));
    _subscriptions.add(_player.processingStateStream.listen((state) {
      _isBuffering = state == ProcessingState.buffering ||
          state == ProcessingState.loading;
      notifyListeners();
    }));
    _subscriptions.add(_player.positionStream.listen((position) {
      _position = position;
      notifyListeners();
    }));
    _subscriptions.add(_player.durationStream.listen((duration) {
      _duration = duration ?? Duration.zero;
      notifyListeners();
    }));
    _subscriptions.add(_player.shuffleModeEnabledStream.listen((enabled) {
      _shuffleModeEnabled = enabled;
      notifyListeners();
    }));
    _subscriptions.add(_player.loopModeStream.listen((mode) {
      _loopMode = mode;
      notifyListeners();
    }));
  }

  TrackDetail? _trackFromSequence(SequenceState? state) {
    if (state == null) return null;
    final index = state.currentIndex;
    if (index == null || index < 0) return null;
    final sequence = state.sequence;
    if (index >= sequence.length) return null;
    return sequence[index].tag as TrackDetail?;
  }

  Future<void> playTrack(TrackDetail track) async {
    _error = null;
    try {
      final source = await resolveAudioSource(track, _sources);
      await _player.setAudioSources([source]);
      _audioSourceSet = true;
      await _player.play();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addToQueue(TrackDetail track) async {
    _error = null;
    try {
      final source = await resolveAudioSource(track, _sources);
      if (!_audioSourceSet) {
        await _player.setAudioSources([source]);
        _audioSourceSet = true;
        await _player.play();
      } else {
        await _player.addAudioSource(source);
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> play() => _player.play();

  Future<void> pause() => _player.pause();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> seekToNext() => _player.seekToNext();

  Future<void> seekToPrevious() => _player.seekToPrevious();

  Future<void> setLoopMode(LoopMode mode) => _player.setLoopMode(mode);

  Future<void> setShuffleModeEnabled(bool enabled) =>
      _player.setShuffleModeEnabled(enabled);

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _player.dispose();
    super.dispose();
  }
}
