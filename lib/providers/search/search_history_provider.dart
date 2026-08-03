import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/providers/shared_preferences_provider.dart';

part 'search_history_provider.g.dart';

@riverpod
class RecordSearchHistory extends _$RecordSearchHistory {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool('record_search_history') ?? true;
  }

  Future<void> set(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool('record_search_history', value);
    state = value;
    if (!value) {
      ref.read(searchHistoryProvider.notifier).clear();
    }
  }
}

@riverpod
class SearchHistory extends _$SearchHistory {
  static const int maxCount = 20;

  @override
  List<String> build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString('search_history');
    if (value == null) return const [];
    final list = jsonDecode(value) as List<dynamic>;
    return list.cast<String>();
  }

  Future<void> add(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final record = ref.read(recordSearchHistoryProvider);
    if (!record) return;

    final current = [trimmed, ...state.where((e) => e != trimmed)];
    final truncated =
        current.length > maxCount ? current.sublist(0, maxCount) : current;
    await _persist(truncated);
  }

  Future<void> remove(String query) async {
    await _persist(state.where((e) => e != query).toList());
  }

  Future<void> clear() async {
    await _persist(const []);
  }

  Future<void> _persist(List<String> value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('search_history', jsonEncode(value));
    if (!ref.mounted) return;
    state = value;
  }
}
