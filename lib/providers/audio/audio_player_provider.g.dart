// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioPlayer)
final audioPlayerProvider = AudioPlayerProvider._();

final class AudioPlayerProvider extends $FunctionalProvider<AudioPlayerService,
    AudioPlayerService, AudioPlayerService> with $Provider<AudioPlayerService> {
  AudioPlayerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'audioPlayerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$audioPlayerHash();

  @$internal
  @override
  $ProviderElement<AudioPlayerService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioPlayerService create(Ref ref) {
    return audioPlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioPlayerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioPlayerService>(value),
    );
  }
}

String _$audioPlayerHash() => r'e2529fdcc9ef9707e0ce2a6ddfcc94d5d4df996b';
