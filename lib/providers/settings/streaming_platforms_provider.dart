import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/providers/shared_preferences_provider.dart';
import 'package:yamada/models/streaming_platforms.dart';

part 'streaming_platforms_provider.g.dart';

@riverpod
class StreamingPlatformsNotifier extends _$StreamingPlatformsNotifier {
  @override
  List<StreamingPlatformConfig> build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString('streaming_platforms');
    if (value == null) {
      return const [
        StreamingPlatformConfig(id: StreamingPlatformId.youtube),
        StreamingPlatformConfig(id: StreamingPlatformId.bilibili),
        StreamingPlatformConfig(id: StreamingPlatformId.netease),
      ];
    }
    final list = jsonDecode(value) as List<dynamic>;
    return list
        .map((e) => StreamingPlatformConfig.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persist(List<StreamingPlatformConfig> value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(
      'streaming_platforms',
      jsonEncode(value.map((e) => e.toJson()).toList()),
    );
    state = value;
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = [...state];
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    await _persist(current);
  }

  Future<void> setEnabled(StreamingPlatformId id, bool value) async {
    await _persist([
      for (final p in state)
        if (p.id == id) p.copyWith(enabled: value) else p,
    ]);
  }

  Future<void> setLoggedIn(StreamingPlatformId id, bool value) async {
    await _persist([
      for (final p in state)
        if (p.id == id) p.copyWith(loggedIn: value) else p,
    ]);
  }
}
