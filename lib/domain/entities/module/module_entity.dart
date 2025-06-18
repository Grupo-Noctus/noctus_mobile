import 'package:noctus_mobile/domain/entities/video/video_entity.dart';

final class ModuleEntity {
  final int id;
  final String name;
  final String description;
  final int order;
  final List<VideoEntity> videos;

  const ModuleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
    required this.videos,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyOrder = 'order';
  static const String kKeyVideos = 'videos';

  factory ModuleEntity.fromMap(Map<String, dynamic> map) {
    return ModuleEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      order: map[kKeyOrder] as int,
      videos: (map[kKeyVideos] as List<dynamic>)
          .map((e) => VideoEntity.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyDescription: description,
      kKeyOrder: order,
      kKeyVideos: videos.map((e) => e.toMap()).toList(),
    };
  }
}
