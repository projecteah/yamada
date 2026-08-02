import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/providers/shared_preferences_provider.dart';

part 'appearance_provider.g.dart';

enum AppDesign { material, fluent }

extension AppDesignX on AppDesign {
  bool get isFluent => this == AppDesign.fluent;
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString('theme_mode');
    return value == null ? ThemeMode.system : ThemeMode.values.byName(value);
  }

  Future<void> set(ThemeMode value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('theme_mode', value.name);
    state = value;
  }
}

@riverpod
class DesignNotifier extends _$DesignNotifier {
  @override
  AppDesign build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final value = prefs.getString('design');
    return value == null ? AppDesign.fluent : AppDesign.values.byName(value);
  }

  Future<void> set(AppDesign value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('design', value.name);
  }
}
