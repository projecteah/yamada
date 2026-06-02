import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_provider.dart';

enum AppDesign { material, fluent }

class DesignScope extends InheritedWidget {
  final AppDesign design;

  const DesignScope({
    super.key,
    required this.design,
    required super.child,
  });

  static AppDesign of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DesignScope>();
    return scope?.design ?? AppDesign.fluent;
  }

  @override
  bool updateShouldNotify(DesignScope oldWidget) =>
      oldWidget.design != design;
}

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final value = prefs.getString(_key);
    return ThemeMode.values.byName(value ?? 'system');
  }

  Future<void> set(ThemeMode mode) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setString(_key, mode.name);
    state = mode;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class LocaleNotifier extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final value = prefs.getString(_key);
    if (value == null) return null;
    final parts = value.split('_');
    return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
  }

  Future<void> set(Locale? locale) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.toLanguageTag());
    }
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

class DesignNotifier extends Notifier<AppDesign> {
  static const _key = 'design';

  @override
  AppDesign build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final value = prefs.getString(_key);
    return AppDesign.values.byName(value ?? AppDesign.fluent.name);
  }

  Future<void> set(AppDesign design) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setString(_key, design.name);
    state = design;
  }
}

final designProvider = NotifierProvider<DesignNotifier, AppDesign>(
  DesignNotifier.new,
);
