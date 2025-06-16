import 'package:flutter/material.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/ui/home/pages/home_page.dart';
import 'package:noctus_mobile/ui/login/pages/login_page.dart';
import 'package:noctus_mobile/ui/redirect/pages/splash_page.dart';
import 'package:noctus_mobile/ui/register/pages/register_page.dart';
import 'package:noctus_mobile/configs/injection_container.dart';
import 'package:noctus_mobile/ui/register/pages/student_register_page.dart';

final class RouteGeneratorHelper {
  static const String kSplash = '/';
  static const String kLogin = '/login';
  static const String kRegister = '/register';
  static const String kStudentRegister = '/student';
  static const String kHome = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    return switch (settings.name) {
      kSplash => createRoutePage(const SplashPage()),
      kLogin => createRoutePage(const LoginPage()),
      kRegister => createRoutePage(const RegisterPage()),
      kStudentRegister => args is RegisterEntity 
      ? MaterialPageRoute(
          builder: (context) => StudentRegisterPage(
            registerEntity: args,
          ),
        )
      : createRouteError(),
      kHome => createRoutePage(const HomePage()),
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
