import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/data/sources/base_source.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/providers/search_provider.dart';
import 'package:yamada/utils/streaming_platforms_util.dart';
import 'package:yamada/components/track_tile.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFluent = ref.watch(designProvider).isFluent;
    return isFluent
        ? fluent.ScaffoldPage(
            content: const _SearchContent(),
          )
        : Scaffold(
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.5),
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
            child: _SearchResultsView(
              results: search.results,
              activeTab: search.activeTab,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultsView extends StatelessWidget {
  final AsyncValue<List<Track>> results;
  final SearchTab activeTab;

  const _SearchResultsView({
    required this.results,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return results.when(
      data: (tracks) {
        if (tracks.isEmpty) return const Center(child: Text('No results'));

        final showPlatform = activeTab is SearchTabAll;
        return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) => TrackTile(
            track: tracks[index],
            showPlatform: showPlatform,
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

class _SearchTabData {
  final SearchTab tab;
  final String label;

  const _SearchTabData(this.tab, this.label);
}
