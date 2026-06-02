import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/appearance_provider.dart';
import 'package:yamada/components/settings/appearance_setting.dart';
import 'package:yamada/components/settings/about_setting.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final design = ref.read(designProvider);
    final isFluent = design == AppDesign.fluent;
    final l10n = AppLocalizations.of(context)!;
    final body = ListView(
      children: [
        AppearanceSetting(),
        SizedBox(height: 16),
        AboutSetting(),
      ],
    );

    return DesignScope(
      design: design,
      child: isFluent
          ? fluent.ScaffoldPage(
              header: fluent.PageHeader(title: Text(l10n.settings)),
              content: body,
            )
          : Scaffold(
              appBar: AppBar(title: Text(l10n.settings)),
              body: body,
            ),
    );
  }
}
