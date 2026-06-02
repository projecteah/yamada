import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/providers/appearance_provider.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'setting_tile.dart';

class AppearanceSetting extends ConsumerWidget {
  const AppearanceSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final design = ref.watch(designProvider);
    final isFluent = DesignScope.of(context) == AppDesign.fluent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingGroupHeader(l10n.appearance),
        SettingTile(
          icon: Icons.language_rounded,
          fluentIcon: fluent.WindowsIcons.locale_language,
          title: l10n.language,
          trailing: _languagePicker(ref, locale, isFluent, l10n),
        ),
        SettingTile(
          icon: Icons.brightness_6_rounded,
          fluentIcon: fluent.WindowsIcons.contrast,
          title: l10n.themeMode,
          trailing: _themePicker(ref, themeMode, isFluent, l10n),
        ),
        SettingTile(
          icon: Icons.palette_rounded,
          fluentIcon: fluent.WindowsIcons.pen_palette,
          title: l10n.design,
          trailing: _designPicker(ref, design, isFluent, l10n, context),
        ),
      ],
    );
  }

  Widget _languagePicker(
    WidgetRef ref,
    Locale? locale,
    bool isFluent,
    AppLocalizations l10n,
  ) {
    final entries = const [
      _LanguageEntry(Locale('en'), 'English'),
      _LanguageEntry(Locale('ja'), '日本語'),
      _LanguageEntry(Locale('zh'), '简体中文'),
      _LanguageEntry(
        Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
        '繁體中文（台灣）',
      ),
    ];

    if (isFluent) {
      return fluent.ComboBox<Locale?>(
        value: locale,
        items: [
          fluent.ComboBoxItem(value: null, child: Text(l10n.themeSystem)),
          ...entries.map((e) => fluent.ComboBoxItem(
                value: e.locale,
                child: Text(e.label),
              )),
        ],
        onChanged: (value) => ref.read(localeProvider.notifier).set(value),
      );
    }

    return DropdownButton<Locale?>(
      value: locale,
      underline: const SizedBox.shrink(),
      items: [
        DropdownMenuItem(value: null, child: Text(l10n.themeSystem)),
        ...entries.map(
          (e) => DropdownMenuItem(value: e.locale, child: Text(e.label)),
        ),
      ],
      onChanged: (value) => ref.read(localeProvider.notifier).set(value),
    );
  }

  Widget _themePicker(
    WidgetRef ref,
    ThemeMode themeMode,
    bool isFluent,
    AppLocalizations l10n,
  ) {
    if (isFluent) {
      return fluent.ComboBox<ThemeMode>(
        value: themeMode,
        items: [
          fluent.ComboBoxItem(
              value: ThemeMode.system, child: Text(l10n.themeSystem)),
          fluent.ComboBoxItem(
              value: ThemeMode.light, child: Text(l10n.themeLight)),
          fluent.ComboBoxItem(
              value: ThemeMode.dark, child: Text(l10n.themeDark)),
        ],
        onChanged: (value) =>
            ref.read(themeModeProvider.notifier).set(value ?? ThemeMode.system),
      );
    }
    return DropdownButton<ThemeMode>(
      value: themeMode,
      underline: const SizedBox.shrink(),
      items: [
        DropdownMenuItem(
            value: ThemeMode.system, child: Text(l10n.themeSystem)),
        DropdownMenuItem(
            value: ThemeMode.light, child: Text(l10n.themeLight)),
        DropdownMenuItem(
            value: ThemeMode.dark, child: Text(l10n.themeDark)),
      ],
      onChanged: (value) => ref.read(themeModeProvider.notifier).set(value!),
    );
  }

  Widget _designPicker(
    WidgetRef ref,
    AppDesign design,
    bool isFluent,
    AppLocalizations l10n,
    BuildContext context,
  ) {
    final onChanged = (AppDesign? value) {
      ref.read(designProvider.notifier).set(value!);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Restart to apply')),
      );
    };

    if (isFluent) {
      return fluent.ComboBox<AppDesign>(
        value: design,
        items: [
          fluent.ComboBoxItem(
              value: AppDesign.material, child: Text(l10n.designMaterial)),
          fluent.ComboBoxItem(
              value: AppDesign.fluent, child: Text(l10n.designFluent)),
        ],
        onChanged: onChanged,
      );
    }
    return DropdownButton<AppDesign>(
      value: design,
      underline: const SizedBox.shrink(),
      items: [
        DropdownMenuItem(
            value: AppDesign.material, child: Text(l10n.designMaterial)),
        DropdownMenuItem(
            value: AppDesign.fluent, child: Text(l10n.designFluent)),
      ],
      onChanged: onChanged,
    );
  }
}

class _LanguageEntry {
  final Locale locale;
  final String label;
  const _LanguageEntry(this.locale, this.label);
}
