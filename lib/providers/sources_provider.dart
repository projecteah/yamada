import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/data/sources/base_source.dart';
import 'package:yamada/data/sources/bilibili_source.dart';

final bilibiliSourceProvider = Provider<BilibiliSource>(
  (ref) => BilibiliSource(),
);

final searchSourcesProvider =
    Provider<Map<StreamingPlatformId, SearchSource>>((ref) {
  return {
    StreamingPlatformId.bilibili: ref.watch(bilibiliSourceProvider),
  };
});

final trackDetailSourcesProvider =
    Provider<Map<StreamingPlatformId, TrackDetailSource>>((ref) {
  return {
    StreamingPlatformId.bilibili: ref.watch(bilibiliSourceProvider),
  };
});

final audioStreamSourcesProvider =
    Provider<Map<StreamingPlatformId, AudioStreamSource>>((ref) {
  return {
    StreamingPlatformId.bilibili: ref.watch(bilibiliSourceProvider),
  };
});
