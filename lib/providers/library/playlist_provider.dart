import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/database/app_database.dart';
import 'package:yamada/models/playlist_model.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/providers/database_provider.dart';

part 'playlist_provider.g.dart';

@riverpod
Stream<List<PlaylistModel>> playlists(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchPlaylists().map(
        (rows) => rows.map(PlaylistModel.fromDrift).toList(),
      );
}

@riverpod
Stream<List<PlaylistTrackModel>> playlistTracks(Ref ref, int playlistId) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchTracks(playlistId).map(
        (rows) => rows.map(PlaylistTrackModel.fromDrift).toList(),
      );
}

@riverpod
PlaylistEditor playlistEditor(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PlaylistEditor(db);
}

class PlaylistEditor {
  final AppDatabase _db;

  PlaylistEditor(this._db);

  Future<int> createPlaylist({
    required String name,
    String? description,
  }) =>
      _db.createPlaylist(name, description: description);

  Future<void> renamePlaylist({required int id, required String name}) =>
      _db.renamePlaylist(id, name);

  Future<void> deletePlaylist(int id) => _db.deletePlaylist(id);

  Future<void> setPlaylistCover({required int id, String? coverUrl}) =>
      _db.setPlaylistCover(id, coverUrl);

  Future<int> addTrack({
    required int playlistId,
    required TrackDetail track,
  }) async {
    final existing = await _db.isTrackInPlaylist(
      playlistId,
      track.sourceType.name,
      track.sourceId,
    );
    if (existing) return -1;
    final rowId = await _db.addTrack(
      playlistId: playlistId,
      sourceType: track.sourceType.name,
      sourceId: track.sourceId,
      title: track.title,
      artist: track.artist,
      coverUrl: track.coverUrl,
      durationMs: track.durationMs,
      cid: track.cid,
    );
    await _db.refreshUpdatedAt(playlistId);
    return rowId;
  }

  Future<void> removeTrack(int trackRowId) => _db.removeTrack(trackRowId);

  Future<bool> isTrackInPlaylist({
    required int playlistId,
    required TrackDetail track,
  }) =>
      _db.isTrackInPlaylist(
        playlistId,
        track.sourceType.name,
        track.sourceId,
      );
}
