import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:noctus_mobile/models/login.dart';
import 'package:noctus_mobile/models/register.dart';
import 'package:noctus_mobile/utils/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String?> login(Login dto) async{
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

  Future<bool> register(Register dto, [File? imageFile]) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/register');

    var request = http.MultipartRequest('POST', url);
    request.fields['user'] = jsonEncode(dto.toJson());

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        final respStr = await response.stream.bytesToString();
        print('Err in register: $respStr');
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}