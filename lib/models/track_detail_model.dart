import 'package:yamada/models/search_model.dart';
import 'package:yamada/models/streaming_platforms_model.dart';

class TrackPage {
  final int cid;
  final int page;
  final String part;
  final int duration;

  const TrackPage({
    required this.cid,
    required this.page,
    required this.part,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'page': page,
        'part': part,
        'duration': duration,
      };
}

class TrackDetail {
  final StreamingPlatformId sourceType;
  final String sourceId;
  final String title;
  final String? description;
  final String? coverUrl;
  final String? artist;
  final int? durationMs;
  final int? cid;
  final List<TrackPage> pages;

  const TrackDetail({
    required this.sourceType,
    required this.sourceId,
    required this.title,
    this.description,
    this.coverUrl,
    this.artist,
    this.durationMs,
    this.cid,
    this.pages = const [],
  });

  factory TrackDetail.fromTrack(Track track) => TrackDetail(
        sourceType: track.sourceType,
        sourceId: track.sourceId,
        title: track.title,
        artist: track.artist,
        coverUrl: track.thumbnailUrl,
        durationMs: track.durationMs,
      );

  Map<String, dynamic> toJson() => {
        'sourceType': sourceType.name,
        'sourceId': sourceId,
        'title': title,
        if (description != null) 'description': description,
        if (coverUrl != null) 'coverUrl': coverUrl,
        if (artist != null) 'artist': artist,
        if (durationMs != null) 'durationMs': durationMs,
        if (cid != null) 'cid': cid,
        'pages': pages.map((p) => p.toJson()).toList(),
      };
}
