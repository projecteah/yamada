import 'package:yamada/database/app_database.dart' as drift;
import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/models/track_detail_model.dart';

class PlaylistModel {
  final int id;
  final String name;
  final String? description;
  final String? coverUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PlaylistModel({
    required this.id,
    required this.name,
    this.description,
    this.coverUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlaylistModel.fromDrift(drift.Playlist p) => PlaylistModel(
        id: p.id,
        name: p.name,
        description: p.description,
        coverUrl: p.coverUrl,
        createdAt: p.createdAt,
        updatedAt: p.updatedAt,
      );
}

class PlaylistTrackModel {
  final int id;
  final int playlistId;
  final StreamingPlatformId sourceType;
  final String sourceId;
  final String title;
  final String? artist;
  final String? coverUrl;
  final int? durationMs;
  final int? cid;
  final DateTime addedAt;

  const PlaylistTrackModel({
    required this.id,
    required this.playlistId,
    required this.sourceType,
    required this.sourceId,
    required this.title,
    this.artist,
    this.coverUrl,
    this.durationMs,
    this.cid,
    required this.addedAt,
  });

  factory PlaylistTrackModel.fromDrift(drift.PlaylistTrack t) =>
      PlaylistTrackModel(
        id: t.id,
        playlistId: t.playlistId,
        sourceType: StreamingPlatformId.values.byName(t.sourceType),
        sourceId: t.sourceId,
        title: t.title,
        artist: t.artist,
        coverUrl: t.coverUrl,
        durationMs: t.durationMs,
        cid: t.cid,
        addedAt: t.addedAt,
      );

  TrackDetail toTrackDetail() => TrackDetail(
        sourceType: sourceType,
        sourceId: sourceId,
        title: title,
        artist: artist,
        coverUrl: coverUrl,
        durationMs: durationMs,
        cid: cid,
      );
}
