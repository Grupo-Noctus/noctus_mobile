import 'package:noctus_mobile/models/auth_model.dart';
import 'package:noctus_mobile/controllers/dto/login_request_dto.dart';

class LoginController {
  final AuthModel _authModel = AuthModel();

  Future<String?> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final requestLogin = LoginRequestDto(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    final token = await _authModel.login(requestLogin);
    return token;
  }
}