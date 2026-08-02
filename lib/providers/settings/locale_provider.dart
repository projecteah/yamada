import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/providers/shared_preferences_provider.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale? build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString('locale');
    if (value == null) return null;
    final parts = value.split('_');
    return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
  }

  Future<void> set(Locale? value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (value == null) {
      await prefs.remove('locale');
    } else {
      await prefs.setString('locale', value.toLanguageTag());
    }
    state = value;
  }
}
