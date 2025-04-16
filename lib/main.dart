import 'package:flutter/material.dart';
import 'package:noctus_mobile/controllers/couses_controller.dart';
import 'package:noctus_mobile/service/course_service.dart';
import 'package:provider/provider.dart';
import 'package:noctus_mobile/providers/auth_provider.dart';
import 'package:noctus_mobile/service/auth_service.dart';
import 'package:noctus_mobile/utils/app_colors.dart';
import 'package:noctus_mobile/views/home_view.dart';
import 'package:noctus_mobile/views/login_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider(AuthService());
  await authProvider.loadToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<CourseController>(create: (_) => CourseController(CourseService())),
      ],
      child: const Noctus(),
    ),
  );
}
class Noctus extends StatelessWidget {const Noctus({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isLoggedIn;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noctus',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryBlue,
      ),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      initialRoute: isLoggedIn ? '/login' : '/home',
      routes: {
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeView(), // trocar pra view cursos
        // adicione as novas rotas (views) 
      },
    );
  }
}
