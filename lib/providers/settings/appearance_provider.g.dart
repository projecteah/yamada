// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeModeNotifier)
final themeModeProvider = ThemeModeNotifierProvider._();

final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  ThemeModeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeModeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'8d12af7505cfafefec0a96278500c872da408238';

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ThemeMode, ThemeMode>, ThemeMode, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(DesignNotifier)
final designProvider = DesignNotifierProvider._();

final class DesignNotifierProvider
    extends $NotifierProvider<DesignNotifier, AppDesign> {
  DesignNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'designProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$designNotifierHash();

  @$internal
  @override
  DesignNotifier create() => DesignNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDesign value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDesign>(value),
    );
  }
}

String _$designNotifierHash() => r'24377dc54e430bfe3475190af6b9de288ff13690';

abstract class _$DesignNotifier extends $Notifier<AppDesign> {
  AppDesign build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppDesign, AppDesign>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AppDesign, AppDesign>, AppDesign, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
