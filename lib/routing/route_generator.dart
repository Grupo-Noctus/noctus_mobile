import 'package:flutter/material.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/ui/register/pages/register_page.dart';
import 'package:noctus_mobile/configs/injection_container.dart';
import 'package:noctus_mobile/ui/register/pages/student_register_page.dart';

final class RouteGeneratorHelper {
  static const String kRegister = '/';
  static const String kStudentRegister = '/student';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    return switch (settings.name) {
      kRegister => createRoutePage(const RegisterPage()),
      kStudentRegister => args is RegisterEntity 
      ? MaterialPageRoute(
          builder: (context) => StudentRegisterPage(
            registerEntity: args,
          ),
        )
      : createRouteError(),
      _ => createRouteError(),
    };
  }

  static PageRoute createRoutePage(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  static Route<dynamic> createRouteError() {
    const String msg = 'Error Route';
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text(msg),
          ),
        );
      },
    );
  }

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) {
      getIt<IAppService>().navigateNamedReplacementTo(route);
    }
  }
}
