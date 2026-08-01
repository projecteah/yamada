import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/providers/preferences_provider.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'setting_tile.dart';

class LanguageSetting extends ConsumerWidget {
  const LanguageSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final isFluent = ref.watch(designProvider).isFluent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingGroupHeader(l10n.language),
        SettingTile(
          icon: Icons.language_rounded,
          fluentIcon: fluent.WindowsIcons.locale_language,
          title: l10n.language,
          trailing: _languagePicker(ref, locale, isFluent, l10n),
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
        '正體中文',
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
}

class _LanguageEntry {
  final Locale locale;
  final String label;
  const _LanguageEntry(this.locale, this.label);
}
