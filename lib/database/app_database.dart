import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:yamada/database/tables/playlists.dart';
import 'package:yamada/database/tables/playlist_tracks.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Playlists, PlaylistTracks])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'yamada'));

  @override
  int get schemaVersion => 1;

  Stream<List<Playlist>> watchPlaylists() {
    return (select(playlists)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch();
  }

  Stream<List<PlaylistTrack>> watchTracks(int playlistId) {
    return (select(playlistTracks)
          ..where((t) => t.playlistId.equals(playlistId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.addedAt),
          ]))
        .watch();
  }

  Future<int> createPlaylist(String name, {String? description}) {
    return into(playlists).insert(PlaylistsCompanion.insert(
      name: name,
      description: Value(description),
    ));
  }

  Future<void> renamePlaylist(int id, String name) {
    return (update(playlists)..where((t) => t.id.equals(id))).write(
      PlaylistsCompanion(
        name: Value(name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deletePlaylist(int id) {
    return (delete(playlists)..where((t) => t.id.equals(id))).go();
  }

  Future<void> setPlaylistCover(int id, String? coverUrl) {
    return (update(playlists)..where((t) => t.id.equals(id))).write(
      PlaylistsCompanion(
        coverUrl: Value(coverUrl),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> refreshUpdatedAt(int id) {
    return (update(playlists)..where((t) => t.id.equals(id))).write(
      PlaylistsCompanion(updatedAt: Value(DateTime.now())),
    );
  }

  Future<String?> playlistCoverUrl(int playlistId) async {
    final playlist = await (select(playlists)
          ..where((t) => t.id.equals(playlistId)))
        .getSingleOrNull();
    if (playlist?.coverUrl != null) return playlist!.coverUrl;
    final latest = await (select(playlistTracks)
          ..where(
              (t) => t.playlistId.equals(playlistId) & t.coverUrl.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.addedAt)])
          ..limit(1))
        .getSingleOrNull();
    return latest?.coverUrl;
  }

  Future<int> addTrack({
    required int playlistId,
    required String sourceType,
    required String sourceId,
    required String title,
    String? artist,
    String? coverUrl,
    int? durationMs,
    int? cid,
  }) {
    return into(playlistTracks).insert(PlaylistTracksCompanion.insert(
      playlistId: playlistId,
      sourceType: sourceType,
      sourceId: sourceId,
      title: title,
      artist: Value(artist),
      coverUrl: Value(coverUrl),
      durationMs: Value(durationMs),
      cid: Value(cid),
    ));
  }

  Future<void> removeTrack(int trackRowId) {
    return (delete(playlistTracks)..where((t) => t.id.equals(trackRowId))).go();
  }

  Future<bool> isTrackInPlaylist(
      int playlistId, String sourceType, String sourceId) async {
    final query = select(playlistTracks)
      ..where((t) =>
          t.playlistId.equals(playlistId) &
          t.sourceType.equals(sourceType) &
          t.sourceId.equals(sourceId));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<int> trackCount(int playlistId) async {
    final count = countAll();
    final query = selectOnly(playlistTracks)
      ..addColumns([count])
      ..where(playlistTracks.playlistId.equals(playlistId));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
