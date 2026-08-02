// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming_platforms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StreamingPlatformsNotifier)
final streamingPlatformsProvider = StreamingPlatformsNotifierProvider._();

final class StreamingPlatformsNotifierProvider extends $NotifierProvider<
    StreamingPlatformsNotifier, List<StreamingPlatformConfig>> {
  StreamingPlatformsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'streamingPlatformsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$streamingPlatformsNotifierHash();

  @$internal
  @override
  StreamingPlatformsNotifier create() => StreamingPlatformsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StreamingPlatformConfig> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<List<StreamingPlatformConfig>>(value),
    );
  }
}

String _$streamingPlatformsNotifierHash() =>
    r'2802c45c496214ff0c658e13f4e91721f8d05832';

abstract class _$StreamingPlatformsNotifier
    extends $Notifier<List<StreamingPlatformConfig>> {
  List<StreamingPlatformConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref
        as $Ref<List<StreamingPlatformConfig>, List<StreamingPlatformConfig>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<StreamingPlatformConfig>,
            List<StreamingPlatformConfig>>,
        List<StreamingPlatformConfig>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
