import 'package:flutter/material.dart';
import 'package:noctus_mobile/utils/app_colors.dart';
import 'package:noctus_mobile/utils/token_storage.dart';
import 'package:noctus_mobile/views/home_view.dart';
import 'package:noctus_mobile/views/login_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Necessário para o suporte a localizações

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await TokenStorage.getToken();
  runApp(Noctus(isLoggedIn: token != null));
}

class Noctus extends StatelessWidget {
  final bool isLoggedIn;

  const Noctus({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
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
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeView(), // trocar pra view cursos
        // adicione as novas rotas (views)
      },
    );
  }
}
