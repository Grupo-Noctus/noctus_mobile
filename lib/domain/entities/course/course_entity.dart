import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';

final class CourseEntity {
  final int id;
  final String name;
  final String description;
  final String image;
  final int duration;
  final List<ModuleEntity> modules;

  const CourseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.duration,
    required this.modules,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyImage = 'image';
  static const String kKeyDuration = 'duration';
  static const String kKeyModules = 'modules';

  factory CourseEntity.fromMap(Map<String, dynamic> map) {
    return CourseEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      image: map[kKeyImage] as String,
      duration: map[kKeyDuration] as int,
      modules: (map[kKeyModules] as List<dynamic>)
          .map((e) => ModuleEntity.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String get imageUrl {
    const env = EnvironmentHelper();
    return '${env.urlUploadBase}$image';
  }

  factory CourseEntity.fromRemoteMap(Map<String, dynamic> map) {
    return CourseEntity.fromMap(map);
  }
}
