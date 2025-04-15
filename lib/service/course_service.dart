import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:noctus_mobile/models/all_courses.dart';
import 'package:noctus_mobile/models/enrolled_course.dart';
import 'package:noctus_mobile/utils/api_config.dart';
import 'package:noctus_mobile/utils/token_storage.dart';

abstract interface class ICourseService {
  Future<List<EnrolledCourse>> getEnrolledCourses();
  Future<List<AllCourses>> getAllCourses();
} 

class CourseService implements ICourseService {
  @override
  Future<List<EnrolledCourse>> getEnrolledCourses() async {
    final token = await TokenStorage.getToken();

    if(token == null) {throw Exception('Unauthorized: no token found');}

    final url = Uri.parse('${ApiConfig.baseUrl}/enrollment/course');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if(response.statusCode == 200) {
        if(response.body.isEmpty){
          return [];
        }
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => EnrolledCourse.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load courses, status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching enrolled courses: $error');
    }
  }

  @override
  Future<List<AllCourses>> getAllCourses() async {
    final token = await TokenStorage.getToken();

    if (token == null) throw Exception('Unauthorized: no token found');

    final url = Uri.parse('${ApiConfig.baseUrl}/course/find-many');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => AllCourses.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch courses, status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching all courses: $error');
    }
  }
}