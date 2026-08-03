import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/components/setting_tile.dart';

class AdvancedPage extends StatelessWidget {
  const AdvancedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAdvanced)),
      body: ListView(
        children: [
          SettingTile(
            icon: Icons.bug_report_rounded,
            title: l10n.debugBilibili,
            onTap: () => context.go('/settings/advanced/debug-bilibili'),
          ),
        ],
      ),
    );
  }
}
