import 'package:noctus_mobile/service/auth_service.dart';
import 'package:noctus_mobile/models/login.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<String?> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final requestLogin = Login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    final token = await _authService.login(requestLogin);
    return token;
  }
}