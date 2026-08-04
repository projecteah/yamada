import 'package:yamada/models/streaming_platforms_model.dart';

enum SearchOrder { relevance, playCount, publishDate }

class Track {
  final String sourceId;
  final StreamingPlatformId sourceType;
  final String title;
  final String? artist;
  final int? durationMs;
  final String? thumbnailUrl;
  final int? viewCount;

  const Track({
    required this.sourceId,
    required this.sourceType,
    required this.title,
    this.artist,
    this.durationMs,
    this.thumbnailUrl,
    this.viewCount,
  });
}

class SearchResult {
  final List<Track> tracks;
  final int totalCount;
  final int page;
  final int pageSize;
  final bool hasMore;

  const SearchResult({
    required this.tracks,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });
}
