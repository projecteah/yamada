import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/providers/search/search_history_provider.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/providers/sources_provider.dart';
import 'package:yamada/data/sources/base_source.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  Timer? _debounce;
  bool _disposed = false;

  @override
  SearchState build() {
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _debounce?.cancel();
    });
    return const SearchState();
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
    _scheduleSearch();
  }

  void setTab(SearchTab tab) {
    if (tab is SearchTabAll) {
      _debounce?.cancel();
      state = state.copyWith(
        activeTab: tab,
        results: const AsyncValue.data([]),
      );
      return;
    }
    state = state.copyWith(activeTab: tab, results: const AsyncValue.loading());
    _scheduleSearch(immediate: true);
  }

  void _scheduleSearch({bool immediate = false}) {
    final query = state.query.trim();
    if (query.isEmpty) {
      _debounce?.cancel();
      state = state.copyWith(results: const AsyncValue.data([]));
      return;
    }

    _debounce?.cancel();
    final delay =
        immediate ? Duration.zero : const Duration(milliseconds: 1500);
    _debounce = Timer(delay, _runSearch);
  }

  Future<void> _runSearch() async {
    if (_disposed) return;
    final query = state.query.trim();
    if (query.isEmpty) return;

    state = state.copyWith(results: const AsyncValue.loading());

    try {
      final tracks = await _fetchForTab(state.activeTab, query);
      if (_disposed) return;
      state = state.copyWith(results: AsyncValue.data(tracks));
      ref.read(searchHistoryProvider.notifier).add(query);
    } catch (e, st) {
      if (_disposed) return;
      state = state.copyWith(results: AsyncValue.error(e, st));
    }
  }

  Future<List<Track>> _fetchForTab(SearchTab tab, String query) async {
    final sources = ref.read(searchSourcesProvider);
    final platforms = ref.read(streamingPlatformsProvider);
    final enabled = platforms.where((p) => p.enabled).map((p) => p.id).toSet();

    switch (tab) {
      case SearchTabAll():
        return [];
      case SearchTabLocal():
        return [];
      case SearchTabPlatform(:final platformId):
        if (!enabled.contains(platformId)) return [];
        final source = sources[platformId];
        if (source == null) return [];
        final result = await source.search(query);
        return result.tracks;
    }
  }
}

sealed class SearchTab {
  const SearchTab();
}

class SearchTabAll extends SearchTab {
  const SearchTabAll();

  @override
  bool operator ==(Object other) => other is SearchTabAll;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SearchTabLocal extends SearchTab {
  const SearchTabLocal();

  @override
  bool operator ==(Object other) => other is SearchTabLocal;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SearchTabPlatform extends SearchTab {
  final StreamingPlatformId platformId;
  const SearchTabPlatform(this.platformId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchTabPlatform &&
          runtimeType == other.runtimeType &&
          platformId == other.platformId;

  @override
  int get hashCode => platformId.hashCode;
}

class SearchState {
  final String query;
  final SearchTab activeTab;
  final AsyncValue<List<Track>> results;

  const SearchState({
    this.query = '',
    this.activeTab = const SearchTabAll(),
    this.results = const AsyncValue.data([]),
  });

  SearchState copyWith({
    String? query,
    SearchTab? activeTab,
    AsyncValue<List<Track>>? results,
  }) =>
      SearchState(
        query: query ?? this.query,
        activeTab: activeTab ?? this.activeTab,
        results: results ?? this.results,
      );
}
