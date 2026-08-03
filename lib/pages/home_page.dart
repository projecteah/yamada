import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = ref.watch(designProvider).isFluent;
    final l10n = AppLocalizations.of(context)!;
    return isFluent
        ? fluent.ScaffoldPage(
            header: fluent.PageHeader(title: Text(l10n.home)),
            content: const _HomeContent(),
          )
        : Scaffold(
            appBar: AppBar(title: Text(l10n.home)),
            body: const _HomeContent(),
          );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Test', style: TextStyle(fontSize: 16)),
    );
  }
}
