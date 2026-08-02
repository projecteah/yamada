import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/components/settings/setting_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          SettingTile(
            icon: Icons.settings_rounded,
            title: l10n.settingsGeneral,
            onTap: () => context.go('/settings/general'),
          ),
          SettingTile(
            icon: Icons.palette_rounded,
            title: l10n.settingsAppearance,
            onTap: () => context.go('/settings/appearance'),
          ),
          SettingTile(
            icon: Icons.info_rounded,
            title: l10n.settingsAbout,
            onTap: () => context.go('/settings/about'),
          ),
        ],
      ),
    );
  }
}
