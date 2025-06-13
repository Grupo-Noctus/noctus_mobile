import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/injection_container.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/ui/register/pages/register_page.dart';

final class RouteGeneratorHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;
    return switch (settings.name) {
      kRegister => createRoutePage(const RegisterPage()),
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

  static const String kInitial = '/';
  static const String kRegister = '/register';

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) getIt<IAppService>().navigateNamedReplacementTo(route);
  }
}