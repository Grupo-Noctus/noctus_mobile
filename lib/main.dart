import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noctus_mobile/configs/injection_container.dart' as injector;
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/routing/route_generator.dart';
import 'package:noctus_mobile/utils/util.dart';

void main() async {
  _ConfigureModeUi.apply();
  await injector.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeHelper.theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale(Util.kLanguageCode, Util.kCountryCode)],
      onGenerateRoute: RouteGeneratorHelper.generateRoute,
      navigatorKey: injector.getIt<IAppService>().navigatorKey,
    );
  }
}

final class _ConfigureModeUi {
  static void apply() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ThemeHelper.kTransparenteColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}