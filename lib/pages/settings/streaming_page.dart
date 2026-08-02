import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/providers/settings/streaming_platforms_provider.dart';
import 'package:yamada/models/streaming_platforms.dart';
import 'package:yamada/components/settings/setting_tile.dart';

class StreamingPage extends ConsumerWidget {
  const StreamingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final platforms = ref.watch(streamingPlatformsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsPlatform)),
      body: Column(
        children: [
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: platforms.length,
            buildDefaultDragHandles: false,
            onReorderItem: (oldIndex, newIndex) => ref
                .read(streamingPlatformsProvider.notifier)
                .reorder(oldIndex, newIndex),
            itemBuilder: (context, index) => _StreamingTile(
              key: ValueKey(platforms[index].id),
              config: platforms[index],
              index: index,
            ),
          ),
          SettingGroupFooter(l10n.settingsPlatformHint),
        ],
      ),
    );
  }
}

class _StreamingTile extends ConsumerWidget {
  final StreamingPlatformConfig config;
  final int index;

  const _StreamingTile({
    super.key,
    required this.config,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      key: ValueKey(config.id),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_indicator_rounded),
          ),
          const SizedBox(width: 4),
          Icon(_iconFor(config.id)),
        ],
      ),
      title: Text(_labelFor(config.id, l10n)),
      subtitle: Text(config.loggedIn
          ? l10n.settingsPlatformLoggedIn
          : l10n.settingsPlatformNotLoggedIn),
      trailing: Switch(
        value: config.enabled,
        onChanged: (v) => ref
            .read(streamingPlatformsProvider.notifier)
            .setEnabled(config.id, v),
      ),
      onTap: config.enabled
          ? () => ref
              .read(streamingPlatformsProvider.notifier)
              .setLoggedIn(config.id, !config.loggedIn)
          : null,
    );
  }

  String _labelFor(StreamingPlatformId id, AppLocalizations l10n) {
    switch (id) {
      case StreamingPlatformId.youtube:
        return l10n.settingsPlatformYouTube;
      case StreamingPlatformId.bilibili:
        return l10n.settingsPlatformBilibili;
      case StreamingPlatformId.netease:
        return l10n.settingsPlatformNetease;
    }
  }

  IconData _iconFor(StreamingPlatformId id) {
    switch (id) {
      case StreamingPlatformId.youtube:
        return Icons.play_circle_outline;
      case StreamingPlatformId.bilibili:
        return Icons.live_tv_rounded;
      case StreamingPlatformId.netease:
        return Icons.music_note_rounded;
    }
  }
}
