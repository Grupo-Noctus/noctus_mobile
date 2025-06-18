import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';

final class EnrolledCourseEntity {
  final int idEnrrolment;
  final int completed;
  final DateTime expiresAt;
  final int idCourse;
  final String nameCourse;
  final String courseDescription;
  final String courseImage;
  final List<ModuleEntity> modules;

  const EnrolledCourseEntity({
    required this.idEnrrolment,
    required this.completed,
    required this.expiresAt,
    required this.idCourse,
    required this.nameCourse,
    required this.courseDescription,
    required this.courseImage,
    required this.modules,
  });

  factory EnrolledCourseEntity.fromMap(Map<String, dynamic> map) {
    return EnrolledCourseEntity(
      idEnrrolment: map['idEnrrolment'],
      completed: map['completed'],
      expiresAt: DateTime.parse(map['expiresAt']),
      idCourse: map['idCourse'],
      nameCourse: map['nameCourse'],
      courseDescription: map['courseDescription'],
      courseImage: map['courseImage'],
      modules: (map['modules'] as List)
          .map((e) => ModuleEntity.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String get imageUrl {
    const env = EnvironmentHelper();
    return '${env.urlUploadBase}$courseImage';
  }

  factory EnrolledCourseEntity.fromRemoteMap(Map<String, dynamic> map) {
    return EnrolledCourseEntity.fromMap(map);
  }
}
