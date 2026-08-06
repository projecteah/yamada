import 'package:drift/drift.dart';

import 'package:yamada/database/tables/playlists.dart';

class PlaylistTracks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playlistId =>
      integer().references(Playlists, #id, onDelete: KeyAction.cascade)();
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();
  TextColumn get title => text()();
  TextColumn get artist => text().nullable()();
  TextColumn get coverUrl => text().nullable()();
  IntColumn get durationMs => integer().nullable()();
  IntColumn get cid => integer().nullable()();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
