import 'package:just_audio/just_audio.dart';

import 'package:yamada/sources/base_source.dart';
import 'package:yamada/models/audio_stream_model.dart';
import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/models/track_detail_model.dart';

const Map<StreamingPlatformId, Map<String, String>> _platformHeaders = {
  StreamingPlatformId.bilibili: {
    'Referer': 'https://www.bilibili.com',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
        'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
  },
};

Future<AudioSource> resolveAudioSource(
  TrackDetail track,
  Map<StreamingPlatformId, AudioStreamSource> sources,
) async {
  final source = sources[track.sourceType];
  if (source == null) {
    throw SourceException(
      code: -1,
      message: 'No audio source for ${track.sourceType.name}',
    );
  }

  final AudioStream audioStream;
  try {
    audioStream = await source.getAudioStream(
      track.sourceId,
      cid: track.cid,
    );
  } on SourceException {
    rethrow;
  } catch (e) {
    throw SourceException(code: -2, message: e.toString());
  }

  return AudioSource.uri(
    Uri.parse(audioStream.url),
    headers: _platformHeaders[track.sourceType] ?? const {},
    tag: track,
  );
}
