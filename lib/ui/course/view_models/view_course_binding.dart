import 'package:flutter/material.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';
import 'package:provider/provider.dart';

class ViewCourseBinding {
  static Widget provider({
    required Widget child,
    required String videoUrl,
  }) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = ViewCourseViewModel();
        viewModel.initializeVideo(videoUrl);
        return viewModel;
      },
      child: child,
    );
  }
}
