import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/library/extensions.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';

abstract interface class IAdminCourseRepository {
  Future<List<CourseEntity>> findCoursesAsync();
}

final class AdminCourseRepository implements IAdminCourseRepository {
  final IRemoteDataSource _remoteDataSource;

  const AdminCourseRepository(this._remoteDataSource);

  @override
  Future<List<CourseEntity>> findCoursesAsync() async {
    final response = await _remoteDataSource.get(_urlCourseAdmin);

    if (!response.toBool()) return [];

    final raw = response.data;
    if (raw is! Map<String, dynamic>) return [];

    final paginated = HttpResponsePaginatedEntity.fromMap(raw);
    final list = paginated.data;

    return list.map((e) => CourseEntity.fromMap(e)).toList();
  }

  String get _urlCourseAdmin => _remoteDataSource.environment?.urlCoursesAdmin ?? '';
}
