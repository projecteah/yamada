// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playlists)
final playlistsProvider = PlaylistsProvider._();

final class PlaylistsProvider extends $FunctionalProvider<
        AsyncValue<List<PlaylistModel>>,
        List<PlaylistModel>,
        Stream<List<PlaylistModel>>>
    with
        $FutureModifier<List<PlaylistModel>>,
        $StreamProvider<List<PlaylistModel>> {
  PlaylistsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'playlistsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$playlistsHash();

  @$internal
  @override
  $StreamProviderElement<List<PlaylistModel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<PlaylistModel>> create(Ref ref) {
    return playlists(ref);
  }
}

String _$playlistsHash() => r'e20fbb15d94236ffcc7ef0ed23728f14c94b6263';

@ProviderFor(playlistTracks)
final playlistTracksProvider = PlaylistTracksFamily._();

final class PlaylistTracksProvider extends $FunctionalProvider<
        AsyncValue<List<PlaylistTrackModel>>,
        List<PlaylistTrackModel>,
        Stream<List<PlaylistTrackModel>>>
    with
        $FutureModifier<List<PlaylistTrackModel>>,
        $StreamProvider<List<PlaylistTrackModel>> {
  PlaylistTracksProvider._(
      {required PlaylistTracksFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'playlistTracksProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$playlistTracksHash();

  @override
  String toString() {
    return r'playlistTracksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<PlaylistTrackModel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<PlaylistTrackModel>> create(Ref ref) {
    final argument = this.argument as int;
    return playlistTracks(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistTracksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playlistTracksHash() => r'005dd263c199c4cec55ed6bc57e4fe6b807bd591';

final class PlaylistTracksFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<PlaylistTrackModel>>, int> {
  PlaylistTracksFamily._()
      : super(
          retry: null,
          name: r'playlistTracksProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PlaylistTracksProvider call(
    int playlistId,
  ) =>
      PlaylistTracksProvider._(argument: playlistId, from: this);

  @override
  String toString() => r'playlistTracksProvider';
}

@ProviderFor(playlistEditor)
final playlistEditorProvider = PlaylistEditorProvider._();

final class PlaylistEditorProvider
    extends $FunctionalProvider<PlaylistEditor, PlaylistEditor, PlaylistEditor>
    with $Provider<PlaylistEditor> {
  PlaylistEditorProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'playlistEditorProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$playlistEditorHash();

  @$internal
  @override
  $ProviderElement<PlaylistEditor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlaylistEditor create(Ref ref) {
    return playlistEditor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaylistEditor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaylistEditor>(value),
    );
  }
}

String _$playlistEditorHash() => r'f1eb0583cfcdaeeed38f80d6419f6cb8f8ecdddf';
