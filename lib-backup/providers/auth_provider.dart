import 'package:flutter/material.dart';
import '../models/login.dart';
import '../service/auth_service.dart';
import '../utils/token_storage.dart';

class AuthProvider extends ChangeNotifier{
  final IAuthService _authService;

  String? _token;
  String? get token => _token;
  bool get isLoggedIn => _token != null;

  AuthProvider(this._authService);

  Future<bool> login(Login dto) async {
    final token = await _authService.login(dto);
    
    if (token != null) {
      _token = token;
      await TokenStorage.saveAccessToken(token);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout(BuildContext context) async {
    _token = null;
    await TokenStorage.clearToken();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await TokenStorage.getToken();
    notifyListeners();
  }
}