import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/library/extensions.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_preview_entity.dart';

abstract interface class ICoursePreviewRepository {
  Future<List<CoursePreviewEntity>> findPublicCoursesAsync();
}

final class CoursePreviewRepository implements ICoursePreviewRepository {
  final IRemoteDataSource _remoteDataSource;

  const CoursePreviewRepository(this._remoteDataSource);

  @override
  Future<List<CoursePreviewEntity>> findPublicCoursesAsync() async {
    final HttpResponseEntity? response = await _remoteDataSource.get(_urlCoursePreview);
    if (!response.toBool()) return [];

    final data = response!.data;
    if (data is! List) return [];

    return data.map((e) => CoursePreviewEntity.fromMap(e)).toList();
  }

  String get _urlCoursePreview => _remoteDataSource.environment?.urlCoursesPreview ?? '';
}
