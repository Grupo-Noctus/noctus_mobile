import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noctus_mobile/controllers/dto/login_request_dto.dart';
import 'package:noctus_mobile/utils/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel {
  Future<String?> login(LoginRequestDto dto) async{
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(dto.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['access_token']);
        return data['access_token'];
      } else {
        return null;
      }
    } catch (error) {
      print('Error in requisition login: $error');
      return null;
    }
  }
}