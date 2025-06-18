import 'package:flutter/widgets.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/data/repositories/course/admin_course_repository.dart';
import 'package:noctus_mobile/ui/home/view_models/admin/admin_home_view_model.dart';

final class AdminCoursesFactoryViewModel implements IFactoryViewModel<AdminCoursesViewModel> {
  @override
  AdminCoursesViewModel create(BuildContext context) {
    final remoteDataSource = RemoteFactoryDataSource().create();
    final INonRelationalDataSource nonRelationalDataSource = NonRelationalFactoryDataSource().create();

    final repository = AdminCourseRepository(remoteDataSource);

    return AdminCoursesViewModel(repository, nonRelationalDataSource);
  }

  @override
  void dispose(BuildContext context, AdminCoursesViewModel viewModel) {
    viewModel.close();
  }
}
