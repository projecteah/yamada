import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/preferences_provider.dart';
import 'package:yamada/components/settings/setting_tile.dart';

class GeneralPage extends ConsumerWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final entries = _entries;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsGeneral)),
      body: ListView(
        children: [
          SettingGroupHeader(l10n.language),
          SettingTile(
            icon: Icons.language_rounded,
            title: l10n.language,
            subtitle: _labelFor(locale, entries, l10n),
            onTap: () => _showLanguageDialog(
                context, ref, locale, entries, l10n),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    Locale? current,
    List<_LanguageEntry> entries,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.language),
        content: SizedBox(
          width: double.maxFinite,
          child: RadioGroup<Locale?>(
            groupValue: current,
            onChanged: (v) {
              ref.read(localeProvider.notifier).set(v);
              Navigator.of(ctx).pop();
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                RadioListTile<Locale?>(
                  value: null,
                  title: Text(l10n.themeSystem),
                ),
                ...entries.map(
                  (e) => RadioListTile<Locale?>(
                    value: e.locale,
                    title: Text(e.label),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelFor(
    Locale? locale,
    List<_LanguageEntry> entries,
    AppLocalizations l10n,
  ) {
    if (locale == null) return l10n.themeSystem;
    return entries.firstWhere(
      (e) => e.locale == locale,
      orElse: () => _LanguageEntry(locale, locale.toLanguageTag()),
    ).label;
  }

  static const List<_LanguageEntry> _entries = [
    _LanguageEntry(Locale('en'), 'English'),
    _LanguageEntry(Locale('ja'), '日本語'),
    _LanguageEntry(Locale('zh'), '简体中文'),
    _LanguageEntry(
      Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
      '正體中文',
    ),
  ];
}

class _LanguageEntry {
  final Locale locale;
  final String label;
  const _LanguageEntry(this.locale, this.label);
}
