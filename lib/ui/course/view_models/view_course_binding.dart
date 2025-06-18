import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';

/// Classe responsável por prover o ViewCourseViewModel para a árvore de widgets
class ViewCourseBinding {
  /// Cria um BlocProvider com o ViewCourseViewModel configurado
  ///
  /// [child] Widget filho que terá acesso ao ViewModel
  /// [course] Curso que será visualizado
  static Widget provider({
    required Widget child,
    required EnrolledCourseEntity course,
  }) {
    return BlocProvider(
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
