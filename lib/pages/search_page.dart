import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/search_model.dart';
import 'package:yamada/providers/settings/appearance_provider.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/providers/search/search_history_provider.dart';
import 'package:yamada/providers/search/search_provider.dart';
import 'package:yamada/utils/streaming_platforms_util.dart';
import 'package:yamada/components/empty_state.dart';
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

  void _pickKeyword(String keyword) {
    _controller.text = keyword;
    _controller.selection = TextSelection.collapsed(offset: keyword.length);
    ref.read(searchProvider.notifier).setQuery(keyword);
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
            child: _SearchBody(
              results: search.results,
              query: search.query,
              activeTab: search.activeTab,
              onPickKeyword: _pickKeyword,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBody extends ConsumerWidget {
  final AsyncValue<List<Track>> results;
  final String query;
  final SearchTab activeTab;
  final ValueChanged<String> onPickKeyword;

  const _SearchBody({
    required this.results,
    required this.query,
    required this.activeTab,
    required this.onPickKeyword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return results.when(
      data: (tracks) {
        if (tracks.isEmpty && query.trim().isEmpty) {
          return _SearchHistoryView(onPick: onPickKeyword);
        }
        if (tracks.isEmpty) {
          return EmptyState(
            icon: Icons.search_off_rounded,
            title: l10n.searchNoResults,
          );
        }
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
      error: (e, _) => EmptyState(
        icon: Icons.error_outline_rounded,
        title: l10n.searchError,
        subtitle: e.toString(),
      ),
    );
  }
}

class _SearchHistoryView extends ConsumerWidget {
  final ValueChanged<String> onPick;

  const _SearchHistoryView({required this.onPick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final history = ref.watch(searchHistoryProvider);

    if (history.isEmpty) {
      return EmptyState(
        icon: Icons.history_rounded,
        title: l10n.searchHistoryEmpty,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.searchHistory,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => _confirmClear(context, ref, l10n),
              child: Text(l10n.searchClearHistory),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final keyword in history)
                  InputChip(
                    label: Text(keyword),
                    onPressed: () => onPick(keyword),
                    onDeleted: () => ref
                        .read(searchHistoryProvider.notifier)
                        .remove(keyword),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmClear(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.searchClearHistoryConfirmTitle),
        content: Text(l10n.searchClearHistoryConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.searchClearHistory),
          ),
        ],
      ),
    );
    if (ok == true) ref.read(searchHistoryProvider.notifier).clear();
  }
}

class _SearchTabData {
  final SearchTab tab;
  final String label;

  const _SearchTabData(this.tab, this.label);
}
