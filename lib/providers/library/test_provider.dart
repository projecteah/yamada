import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yamada/models/playlist_model.dart';
import 'package:yamada/providers/database_provider.dart';

part 'test_provider.g.dart';

@riverpod
Stream<List<PlaylistModel>> testPlaylists(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchPlaylists().map(
        (rows) => rows.map(PlaylistModel.fromDrift).toList(),
      );
}
