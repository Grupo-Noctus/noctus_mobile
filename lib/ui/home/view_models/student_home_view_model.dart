import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/repositories/course/course_preview_repository.dart';
import 'package:noctus_mobile/data/repositories/course/student_course_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_preview_entity.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';

final class StudentCoursesViewModel extends Cubit<IRequestState<List<EnrolledCourseEntity>>> {
  final IStudentCourseRepository _studentCourseRepository;
  final ICoursePreviewRepository _coursePreviewRepository;
  final INonRelationalDataSource _localStorage;

  StudentCoursesViewModel(
    this._studentCourseRepository,
    this._coursePreviewRepository,
    this._localStorage,
  ) : super(RequestInitiationState());

  Future<void> loadCourses() async {
    emit(RequestProcessingState());

    try {
      final enrolledCourses = await _studentCourseRepository.findCoursesAsync();
      emit(RequestCompletedState(value: enrolledCourses));
    } catch (e) {
      emit(RequestErrorState(error: e));
    }
  }

  Future<List<CoursePreviewEntity>> loadPublicCourses() async {
    try {
      return await _coursePreviewRepository.findPublicCoursesAsync();
    } catch (_) {
      return [];
    }
  }

  Future<void> logout() async {
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserToken);
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserLogged);
  }
}
