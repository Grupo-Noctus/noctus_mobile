import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/module/module_preview_entity.dart';

final class CoursePreviewEntity {
  final int id;
  final String name;
  final String description;
  final String image;
  final int duration;
  final List<ModulePreviewEntity> modules;
  final int countModules;
  final int countVideos;
  final int durationVideos;

  const CoursePreviewEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.duration,
    required this.modules,
    required this.countModules,
    required this.countVideos,
    required this.durationVideos,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyImage = 'image';
  static const String kKeyDuration = 'duration';
  static const String kKeyModules = 'modules';
  static const String kKeyCountModules = 'countModules';
  static const String kKeyCountVideos = 'countVideos';
  static const String kKeyDurationVideos = 'durationVideos';

  factory CoursePreviewEntity.fromMap(Map<String, dynamic> map) {
    return CoursePreviewEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      image: map[kKeyImage] as String,
      duration: map[kKeyDuration] as int,
      modules:
          (map[kKeyModules] as List<dynamic>)
              .map(
                (e) => ModulePreviewEntity.fromMap(e as Map<String, dynamic>),
              )
              .toList(),
      countModules: map[kKeyCountModules] as int,
      countVideos: map[kKeyCountVideos] as int,
      durationVideos: map[kKeyDurationVideos] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyDescription: description,
      kKeyImage: image,
      kKeyDuration: duration,
      kKeyModules: modules.map((e) => e.toMap()).toList(),
      kKeyCountModules: countModules,
      kKeyCountVideos: countVideos,
      kKeyDurationVideos: durationVideos,
    };
  }

  String get imageUrl {
    const env = EnvironmentHelper();
    return '${env.urlUploadBase}$image';
  }

  factory CoursePreviewEntity.fromRemoteMap(Map<String, dynamic> map) {
    return CoursePreviewEntity.fromMap(map);
  }
}
