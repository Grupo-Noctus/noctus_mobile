import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/data/repositories/course/course_preview_repository.dart';
import 'package:noctus_mobile/data/repositories/course/student_course_repository.dart';
import 'package:noctus_mobile/ui/home/view_models/student_home_view_model.dart';

final class StudentCoursesFactoryViewModel implements IFactoryViewModel<StudentCoursesViewModel> {
  @override
  StudentCoursesViewModel create(BuildContext context) {
    final remoteDataSource = RemoteFactoryDataSource().create();
    final INonRelationalDataSource nonRelationalDataSource = NonRelationalFactoryDataSource().create();

    final IStudentCourseRepository studentRepo = StudentCourseRepository(remoteDataSource);
    final ICoursePreviewRepository previewRepo = CoursePreviewRepository(remoteDataSource);

    return StudentCoursesViewModel(studentRepo, previewRepo, nonRelationalDataSource);
  }

  @override
  void dispose(BuildContext context, StudentCoursesViewModel viewModel) {
    viewModel.close();
  }
}

