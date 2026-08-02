import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/preferences_provider.dart';
import 'package:yamada/components/settings/setting_tile.dart';

class AppearancePage extends ConsumerWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final design = ref.watch(designProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAppearance)),
      body: ListView(
        children: [
          SettingTile(
            icon: Icons.brightness_6_rounded,
            title: l10n.settingsThemeMode,
            subtitle: _themeModeLabel(themeMode, l10n),
            onTap: () =>
                _showThemeModeDialog(context, ref, themeMode, l10n),
          ),
          SettingTile(
            icon: Icons.design_services_rounded,
            title: l10n.settingsDesign,
            subtitle: _designLabel(design, l10n),
            onTap: () => _showDesignDialog(context, ref, design, l10n),
          ),
        ],
      ),
    );
  }

  Future<void> _showThemeModeDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeMode current,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsThemeMode),
        content: SizedBox(
          width: double.maxFinite,
          child: RadioGroup<ThemeMode>(
            groupValue: current,
            onChanged: (v) {
              ref.read(themeModeProvider.notifier).set(v!);
              Navigator.of(ctx).pop();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  title: Text(l10n.settingsThemeSystem),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  title: Text(l10n.settingsThemeLight),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  title: Text(l10n.settingsThemeDark),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDesignDialog(
    BuildContext context,
    WidgetRef ref,
    AppDesign current,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsDesign),
        content: SizedBox(
          width: double.maxFinite,
          child: RadioGroup<AppDesign>(
            groupValue: current,
            onChanged: (v) {
              _onDesignChanged(context, ref, v!);
              Navigator.of(ctx).pop();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<AppDesign>(
                  value: AppDesign.material,
                  title: Text(l10n.settingsDesignMaterial),
                ),
                RadioListTile<AppDesign>(
                  value: AppDesign.fluent,
                  title: Text(l10n.settingsDesignFluent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDesignChanged(BuildContext context, WidgetRef ref, AppDesign value) {
    ref.read(designProvider.notifier).set(value);
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      const SnackBar(content: Text('Restart to apply')),
    );
  }

  String _themeModeLabel(ThemeMode mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeMode.system:
        return l10n.settingsThemeSystem;
      case ThemeMode.light:
        return l10n.settingsThemeLight;
      case ThemeMode.dark:
        return l10n.settingsThemeDark;
    }
  }

  String _designLabel(AppDesign design, AppLocalizations l10n) {
    return design == AppDesign.fluent ? l10n.settingsDesignFluent : l10n.settingsDesignMaterial;
  }
}
