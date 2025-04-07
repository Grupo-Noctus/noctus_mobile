import 'dart:io';
import 'package:noctus_mobile/models/login.dart';
import 'package:noctus_mobile/models/register.dart';
import 'package:noctus_mobile/service/auth_service.dart';

class RegisterController {
  final AuthService _authService = AuthService();

  Future<bool> register({
    required String username,
    required String name,
    required String email,
    required String password,
    required String phone,
    File? image
  }) async {
    final dto = Register(
      username: username,
      name: name,
      email: email,
      password: password,
      phoneNumber: phone,
      image: image?.path
    );

    final dtoLogin = Login(
      usernameOrEmail: email,
      password: password,
    ); 

    final successRegister = await _authService.register(dto, image);

    if (successRegister) {
      final token = await _authService.login(dtoLogin);
      return token != null;
    };

    return false;
  }
}