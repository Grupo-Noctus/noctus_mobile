final class VideoEntity {
  final int id;
  final String name;
  final String description;
  final int duration;
  final int? idProgressVideo;
  final int? viewed;

  const VideoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    this.idProgressVideo,
    this.viewed,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyDuration = 'duration';
  static const String kKeyIdProgressVideo = 'idProgressVideo';
  static const String kKeyViewed = 'viewed';

  factory VideoEntity.fromMap(Map<String, dynamic> map) {
    return VideoEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      duration: map[kKeyDuration] as int,
      idProgressVideo: map[kKeyIdProgressVideo] as int?,
      viewed: map[kKeyViewed] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyDescription: description,
      kKeyDuration: duration,
      kKeyIdProgressVideo: idProgressVideo,
      kKeyViewed: viewed,
    };
  }
}
