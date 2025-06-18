import 'package:noctus_mobile/data/datasources/data_source.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';

abstract interface class ICourseRepository {
  Future<CourseEntity?> getCourseById(String id);
}

final class CourseRepository implements ICourseRepository {
  final IRemoteDataSource _remoteDataSource;

  CourseRepository(this._remoteDataSource);

  @override
  Future<CourseEntity?> getCourseById(String id) async {
    final url = "${_remoteDataSource.environment?.urlBase}/courses/$id";

    final HttpResponseEntity? response = await _remoteDataSource.get(url);
    if (response != null && response.data != null) {
      return CourseEntity.fromMap(response.data);
    }
    return null;
  }
}
