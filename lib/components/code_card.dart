import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:yamada/locales/app_localizations.dart';

class CodeCard extends StatelessWidget {
  final bool loading;
  final String? text;
  final String? error;
  final VoidCallback? onClear;

  const CodeCard({
    super.key,
    this.loading = false,
    this.text,
    this.error,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final codeStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
      color: theme.colorScheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.debugResult,
                style: theme.textTheme.labelLarge,
              ),
            ),
            if (text != null)
              IconButton(
                tooltip: l10n.copy,
                icon: const Icon(Icons.copy_rounded),
                onPressed: () => _copy(context, text!),
              ),
            if (onClear != null)
              IconButton(
                tooltip: l10n.clear,
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: onClear,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 120),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? SingleChildScrollView(
                      child: SelectableText(
                        error!,
                        style:
                            codeStyle.copyWith(color: theme.colorScheme.error),
                      ),
                    )
                  : text == null
                      ? Text(
                          l10n.debugResponseEmpty,
                          style: codeStyle.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        )
                      : SingleChildScrollView(
                          child: SelectableText(
                            text!,
                            style: codeStyle,
                          ),
                        ),
        ),
      ],
    );
  }

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.copied)),
    );
  }
}
