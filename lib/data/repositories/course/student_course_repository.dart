import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/library/extensions.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';

abstract interface class IStudentCourseRepository {
  Future<List<EnrolledCourseEntity>> findCoursesAsync();
}

final class StudentCourseRepository implements IStudentCourseRepository {
  final IRemoteDataSource _remoteDataSource;

  const StudentCourseRepository(this._remoteDataSource);

  @override
  Future<List<EnrolledCourseEntity>> findCoursesAsync() async {
    final response = await _remoteDataSource.get(_urlEnrolledCourse);
    if (!response.toBool()) return [];

    final data = response.data;
    if (data is! List) return [];

    return data.map((e) => EnrolledCourseEntity.fromMap(e)).toList();
  }

  String get _urlEnrolledCourse => _remoteDataSource.environment?.urlCoursesEnrolled ?? '';
}
