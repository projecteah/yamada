import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/providers/search_provider.dart';
import 'package:yamada/utils/streaming_platforms_util.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = ref.watch(designProvider).isFluent;
    final l10n = AppLocalizations.of(context)!;
    return isFluent
        ? fluent.ScaffoldPage(
            header: fluent.PageHeader(title: Text(l10n.search)),
            content: const _SearchContent(),
          )
        : Scaffold(
            appBar: AppBar(title: Text(l10n.search)),
            body: const _SearchContent(),
          );
  }
}

class _SearchContent extends ConsumerStatefulWidget {
  const _SearchContent();

  @override
  ConsumerState<_SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends ConsumerState<_SearchContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final search = ref.watch(searchProvider);
    final platforms = ref.watch(streamingPlatformsProvider);
    final enabledPlatforms = platforms.where((p) => p.enabled).toList();

    final tabs = <_SearchTabData>[
      _SearchTabData(const SearchTabAll(), l10n.searchTabAll),
      _SearchTabData(const SearchTabLocal(), l10n.searchTabLocal),
      for (final p in enabledPlatforms)
        _SearchTabData(SearchTabPlatform(p.id), platformLabel(p.id, l10n)),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.searchPlaceholder,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: (v) => ref.read(searchProvider.notifier).setQuery(v),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final tab in tabs)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(tab.label),
                      selected: tab.tab == search.activeTab,
                      onSelected: (_) =>
                          ref.read(searchProvider.notifier).setTab(tab.tab),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                search.activeTab is SearchTabAll
                    ? 'All'
                    : search.activeTab is SearchTabLocal
                        ? 'Local'
                        : platformLabel(
                            (search.activeTab as SearchTabPlatform).platformId,
                            l10n),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchTabData {
  final SearchTab tab;
  final String label;

  const _SearchTabData(this.tab, this.label);
}
