enum StreamingPlatformId { youtube, bilibili, netease }

class StreamingPlatformConfig {
  final StreamingPlatformId id;
  final bool enabled;
  final bool loggedIn;

  const StreamingPlatformConfig({
    required this.id,
    this.enabled = false,
    this.loggedIn = false,
  });

  StreamingPlatformConfig copyWith({bool? enabled, bool? loggedIn}) =>
      StreamingPlatformConfig(
        id: id,
        enabled: enabled ?? this.enabled,
        loggedIn: loggedIn ?? this.loggedIn,
      );

  Map<String, dynamic> toJson() => {
        'id': id.name,
        'enabled': enabled,
        'loggedIn': loggedIn,
      };

  factory StreamingPlatformConfig.fromJson(Map<String, dynamic> json) =>
      StreamingPlatformConfig(
        id: StreamingPlatformId.values.byName(json['id'] as String),
        enabled: json['enabled'] as bool,
        loggedIn: json['loggedIn'] as bool,
      );
}
