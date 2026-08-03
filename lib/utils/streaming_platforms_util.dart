import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/streaming_platforms_model.dart';

String platformLabel(StreamingPlatformId id, AppLocalizations l10n) {
  switch (id) {
    case StreamingPlatformId.youtube:
      return l10n.platformYouTube;
    case StreamingPlatformId.bilibili:
      return l10n.platformBilibili;
    case StreamingPlatformId.netease:
      return l10n.platformNetease;
  }
}
