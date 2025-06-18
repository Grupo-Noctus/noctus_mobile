import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';
import 'package:provider/provider.dart';

class ViewCourseBinding {
  static Widget provider({
    required Widget child,
    required EnrolledCourseEntity course,
  }) {
    return ChangeNotifierProvider(
      create: (_) {
        final localStorage = NonRelationalFactoryDataSource().create();
        final viewModel = ViewCourseViewModel(localStorage);
        viewModel.setCourse(course);
        return viewModel;
      },
      child: child,
    );
  }
}
