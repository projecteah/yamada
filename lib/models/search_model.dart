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

  Map<String, dynamic> toJson() => {
        'sourceId': sourceId,
        'sourceType': sourceType.name,
        'title': title,
        if (artist != null) 'artist': artist,
        if (durationMs != null) 'durationMs': durationMs,
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        if (viewCount != null) 'viewCount': viewCount,
      };
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

  Map<String, dynamic> toJson() => {
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'hasMore': hasMore,
        'tracks': tracks.map((t) => t.toJson()).toList(),
      };
}
