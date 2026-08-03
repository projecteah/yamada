// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecordSearchHistory)
final recordSearchHistoryProvider = RecordSearchHistoryProvider._();

final class RecordSearchHistoryProvider
    extends $NotifierProvider<RecordSearchHistory, bool> {
  RecordSearchHistoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recordSearchHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recordSearchHistoryHash();

  @$internal
  @override
  RecordSearchHistory create() => RecordSearchHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$recordSearchHistoryHash() =>
    r'03a7ea45757a5e345fb03d734f090009419ffed0';

abstract class _$RecordSearchHistory extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchHistory)
final searchHistoryProvider = SearchHistoryProvider._();

final class SearchHistoryProvider
    extends $NotifierProvider<SearchHistory, List<String>> {
  SearchHistoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  @$internal
  @override
  SearchHistory create() => SearchHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$searchHistoryHash() => r'9fc430bc3d6c64db61d131a31c4061c27dcc7e88';

abstract class _$SearchHistory extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<String>, List<String>>,
        List<String>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
