import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/ui/home/pages/admin_home_page.dart';
import 'package:noctus_mobile/ui/home/pages/student_home_page.dart';
import 'package:noctus_mobile/ui/home/view_models/admin/admin_home_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/home/view_models/admin/admin_home_view_model.dart';
import 'package:noctus_mobile/ui/home/view_models/student_home_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/home/view_models/student_home_view_model.dart';
import 'package:noctus_mobile/ui/login/pages/login_page.dart';
import 'package:noctus_mobile/ui/redirect/pages/splash_page.dart';
import 'package:noctus_mobile/ui/register/pages/register_page.dart';
import 'package:noctus_mobile/configs/injection_container.dart';
import 'package:noctus_mobile/ui/register/pages/student_register_page.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_binding.dart';
import 'package:noctus_mobile/ui/course/pages/view_course.dart';

final class RouteGeneratorHelper {
  static const String kSplash = '/';
  static const String kLogin = '/login';
  static const String kRegister = '/register';
  static const String kStudentRegister = '/student';
  static const String kAdminHome = '/admin-home';
  static const String kStudentHome = '/student-home';
  static const String kCourseView = '/course-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    return switch (settings.name) {
      kSplash => createRoutePage(const SplashPage()),
      kLogin => createRoutePage(const LoginPage()),
      kRegister => createRoutePage(const RegisterPage()),
      kStudentRegister =>
        args is RegisterEntity
            ? MaterialPageRoute(
              builder: (context) => StudentRegisterPage(registerEntity: args),
            )
            : createRouteError(),
      kAdminHome => createRoutePage(
        BlocProvider<AdminCoursesViewModel>(
          create: (context) {
            final factory = AdminCoursesFactoryViewModel();
            final vm = factory.create(context);
            vm.loadCourses();
            return vm;
          },
          child: const AdminCoursesPage(),
        ),
      ),
      kStudentHome => createRoutePage(
        BlocProvider<StudentCoursesViewModel>(
          create: (context) {
            final factory = StudentCoursesFactoryViewModel();
            final vm = factory.create(context);
            vm.loadCourses();
            return vm;
          },
          child: const StudentHomePage(),
        ),
      ),
      kCourseView =>
        args is EnrolledCourseEntity
            ? MaterialPageRoute(
              builder:
                  (context) => ViewCourseBinding.provider(
                    course: args,
                    child: const ViewCourseView(),
                  ),
            )
            : createRouteError(),
      _ => createRouteError(),
    };
  }

  static PageRoute createRoutePage(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static Route<dynamic> createRouteError() {
    const String msg = 'Error Route';
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(body: Center(child: Text(msg)));
      },
    );
  }

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) {
      getIt<IAppService>().navigateNamedReplacementTo(route);
    }
  }
}
