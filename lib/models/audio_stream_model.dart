enum AudioStreamFormat { dash, durl }

class AudioStream {
  final int cid;
  final AudioStreamFormat format;
  final String url;
  final int bandwidth;
  final String? codec;
  final List<String> backupUrls;
  final Map<String, dynamic> rawJson;

  const AudioStream({
    required this.cid,
    required this.format,
    required this.url,
    required this.bandwidth,
    this.codec,
    this.backupUrls = const [],
    required this.rawJson,
  });
}
