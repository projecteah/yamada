import 'package:yamada/models/audio_stream_model.dart';
import 'package:yamada/models/search_model.dart';
import 'package:yamada/models/track_detail_model.dart';

abstract class Source {
  String get name;
}

abstract class SearchSource implements Source {
  @override
  String get name;

  Future<SearchResult> search(
    String query, {
    int page = 1,
    int pageSize = 20,
    SearchOrder order = SearchOrder.relevance,
  });
}

abstract class TrackDetailSource implements Source {
  Future<TrackDetail> getTrackDetail(String id, {int? cid});
}

abstract class AudioStreamSource implements Source {
  Future<AudioStream> getAudioStream(
    String id, {
    int? cid,
    AudioStreamFormat format = AudioStreamFormat.dash,
  });
}

class SourceException implements Exception {
  final int code;
  final String message;

  const SourceException({required this.code, required this.message});

  @override
  String toString() => 'SourceException($code): $message';
}
