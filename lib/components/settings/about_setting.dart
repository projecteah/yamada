import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/preferences_provider.dart';
import 'setting_tile.dart';

class AboutSetting extends ConsumerWidget {
  const AboutSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isFluent = ref.watch(designProvider).isFluent;
    final asyncInfo = ref.watch(packageInfoProvider);

    final versionText = asyncInfo.when(
      data: (info) => Text(info.version),
      loading: () => const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Text('-'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingGroupHeader(l10n.about),
        SettingTile(
          icon: Icons.info_outline,
          fluentIcon: fluent.WindowsIcons.info,
          title: l10n.version,
          trailing: versionText,
        ),
        if (!isFluent)
          SettingTile(
            icon: Icons.description_outlined,
            title: l10n.licenses,
            onTap: () => showLicensePage(context: context),
          ),
      ],
    );
  }
}
