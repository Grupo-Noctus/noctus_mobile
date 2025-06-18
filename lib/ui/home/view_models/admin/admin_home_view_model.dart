import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/repositories/course/admin_course_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';

final class AdminCoursesViewModel extends Cubit<IRequestState<List<CourseEntity>>> {
  final IAdminCourseRepository _repository;
  final INonRelationalDataSource _localStorage;

  AdminCoursesViewModel(this._repository, this._localStorage) : super(RequestInitiationState());

  Future<void> loadCourses() async {
    emit(RequestProcessingState());
    try {
      final courses = await _repository.findCoursesAsync();
      emit(RequestCompletedState(value: courses));
    } catch (e) {
      emit(RequestErrorState(error: e));
    }
  }

  Future<void> logout() async {
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserToken);
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserLogged);
  }
}
