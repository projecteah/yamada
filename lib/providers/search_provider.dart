import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/models/streaming_platforms_model.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  SearchState build() => const SearchState();

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setTab(SearchTab tab) {
    state = state.copyWith(activeTab: tab);
  }

  void clear() {
    state = const SearchState();
  }
}

sealed class SearchTab {
  const SearchTab();
}

class SearchTabAll extends SearchTab {
  const SearchTabAll();
}

class SearchTabLocal extends SearchTab {
  const SearchTabLocal();
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

  const SearchState({
    this.query = '',
    this.activeTab = const SearchTabAll(),
  });

  SearchState copyWith({
    String? query,
    SearchTab? activeTab,
  }) =>
      SearchState(
        query: query ?? this.query,
        activeTab: activeTab ?? this.activeTab,
      );
}
