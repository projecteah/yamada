import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must override in ProviderScope');
});

abstract class PreferenceNotifier<T> extends Notifier<T> {
  PreferenceNotifier();

  String get key;

  T get defaultValue;

  T decode(String value);

  String encode(T value);

  @override
  T build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final value = prefs.getString(key);
    return value == null ? defaultValue : decode(value);
  }

  Future<void> set(T value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(key, encode(value));
    state = value;
  }
}

class ThemeModeNotifier extends PreferenceNotifier<ThemeMode> {
  @override
  String get key => 'theme_mode';

  @override
  ThemeMode get defaultValue => ThemeMode.system;

  @override
  ThemeMode decode(String value) => ThemeMode.values.byName(value);

  @override
  String encode(ThemeMode value) => value.name;
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class LocaleNotifier extends PreferenceNotifier<Locale?> {
  @override
  String get key => 'locale';

  @override
  Locale? get defaultValue => null;

  @override
  Locale? decode(String value) {
    final parts = value.split('_');
    return parts.length == 1 ? Locale(parts[0]) : Locale(parts[0], parts[1]);
  }

  @override
  String encode(Locale? value) => value!.toLanguageTag();

  @override
  Future<void> set(Locale? value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (value == null) {
      await prefs.remove(key);
    } else {
      await prefs.setString(key, encode(value));
    }
    state = value;
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

enum AppDesign { material, fluent }

class DesignNotifier extends PreferenceNotifier<AppDesign> {
  @override
  String get key => 'design';

  @override
  AppDesign get defaultValue => AppDesign.fluent;

  @override
  AppDesign decode(String value) => AppDesign.values.byName(value);

  @override
  String encode(AppDesign value) => value.name;

  @override
  Future<void> set(AppDesign value) async {
    // only persist, apply on next launch to avoid tearing down the root
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(key, encode(value));
  }
}

final designProvider =
    NotifierProvider<DesignNotifier, AppDesign>(DesignNotifier.new);

extension AppDesignX on AppDesign {
  bool get isFluent => this == AppDesign.fluent;
}

final packageInfoProvider = FutureProvider<PackageInfo>(
  (ref) => PackageInfo.fromPlatform(),
);

enum StreamingPlatformId { youtube, bilibili, netease }

class StreamingPlatformConfig {
  final StreamingPlatformId id;
  final bool enabled;
  final bool loggedIn;

  const StreamingPlatformConfig({
    required this.id,
    this.enabled = false,
    this.loggedIn = false,
  });

  StreamingPlatformConfig copyWith({bool? enabled, bool? loggedIn}) =>
      StreamingPlatformConfig(
        id: id,
        enabled: enabled ?? this.enabled,
        loggedIn: loggedIn ?? this.loggedIn,
      );

  Map<String, dynamic> toJson() => {
        'id': id.name,
        'enabled': enabled,
        'loggedIn': loggedIn,
      };

  factory StreamingPlatformConfig.fromJson(Map<String, dynamic> json) =>
      StreamingPlatformConfig(
        id: StreamingPlatformId.values.byName(json['id'] as String),
        enabled: json['enabled'] as bool,
        loggedIn: json['loggedIn'] as bool,
      );
}

class StreamingPlatformsNotifier
    extends PreferenceNotifier<List<StreamingPlatformConfig>> {
  @override
  String get key => 'streaming_platforms';

  @override
  List<StreamingPlatformConfig> get defaultValue => const [
        StreamingPlatformConfig(id: StreamingPlatformId.youtube),
        StreamingPlatformConfig(id: StreamingPlatformId.bilibili),
        StreamingPlatformConfig(id: StreamingPlatformId.netease),
      ];

  @override
  List<StreamingPlatformConfig> decode(String value) {
    final list = jsonDecode(value) as List<dynamic>;
    return list
        .map((e) => StreamingPlatformConfig.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String encode(List<StreamingPlatformConfig> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = [...state];
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    await set(current);
  }

  Future<void> setEnabled(StreamingPlatformId id, bool value) async {
    await set([
      for (final p in state)
        if (p.id == id) p.copyWith(enabled: value) else p,
    ]);
  }

  Future<void> setLoggedIn(StreamingPlatformId id, bool value) async {
    await set([
      for (final p in state)
        if (p.id == id) p.copyWith(loggedIn: value) else p,
    ]);
  }
}

final streamingPlatformsProvider =
    NotifierProvider<StreamingPlatformsNotifier, List<StreamingPlatformConfig>>(
        StreamingPlatformsNotifier.new);
