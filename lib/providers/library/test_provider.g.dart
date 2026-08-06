// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(testPlaylists)
final testPlaylistsProvider = TestPlaylistsProvider._();

final class TestPlaylistsProvider extends $FunctionalProvider<
        AsyncValue<List<PlaylistModel>>,
        List<PlaylistModel>,
        Stream<List<PlaylistModel>>>
    with
        $FutureModifier<List<PlaylistModel>>,
        $StreamProvider<List<PlaylistModel>> {
  TestPlaylistsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'testPlaylistsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$testPlaylistsHash();

  @$internal
  @override
  $StreamProviderElement<List<PlaylistModel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<PlaylistModel>> create(Ref ref) {
    return testPlaylists(ref);
  }
}

String _$testPlaylistsHash() => r'8e6c6983e979f7dd67d42f59b84156d7c2825358';
