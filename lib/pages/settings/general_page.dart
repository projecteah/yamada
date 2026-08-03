import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/constants.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/locale_provider.dart';
import 'package:yamada/components/setting_tile.dart';

class GeneralPage extends ConsumerWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsGeneral)),
      body: ListView(
        children: [
          SettingTile(
            icon: Icons.language_rounded,
            title: l10n.settingsLanguage,
            subtitle: _labelFor(locale, l10n),
            onTap: () => _showLanguageDialog(context, ref, locale, l10n),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    Locale? current,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsLanguage),
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
                  title: Text(l10n.settingsThemeSystem),
                ),
                ...kLanguages.map(
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

  String _labelFor(Locale? locale, AppLocalizations l10n) {
    if (locale == null) return l10n.settingsThemeSystem;
    return kLanguages
        .firstWhere(
          (e) => e.locale == locale,
          orElse: () => Language(locale, locale.toLanguageTag()),
        )
        .label;
  }
}
