import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../models/login.dart';
import '../utils/token_storage.dart';
import '../views/home_view.dart';

class LoginController {
  final IAuthService _authService;
  const LoginController(this._authService);

  Future<void> loginContext({
    required BuildContext context,
    required String usernameOrEmail,
    required String password,
  }) async {
    final requestLogin = Login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );


    final token = await _authService.login(requestLogin);
    
    if (token != null) {
      await TokenStorage.saveAccessToken(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login bem-sucedido!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha inválidos.')),
      );
    }
  }
}