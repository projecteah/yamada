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
  final String title;
  final String description;
  final String? coverUrl;
  final String? artist;
  final int durationSeconds;
  final int? cid;
  final List<TrackPage> pages;

  const TrackDetail({
    required this.title,
    required this.description,
    this.coverUrl,
    this.artist,
    required this.durationSeconds,
    this.cid,
    this.pages = const [],
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        if (coverUrl != null) 'coverUrl': coverUrl,
        if (artist != null) 'artist': artist,
        'durationSeconds': durationSeconds,
        if (cid != null) 'cid': cid,
        'pages': pages.map((p) => p.toJson()).toList(),
      };
}
