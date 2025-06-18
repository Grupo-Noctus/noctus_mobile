import 'dart:convert';


import 'package:noctus_mobile/domain/entities/course/course_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_preview_entity.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/logged/logged_entity.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';

import 'fixture_reader.dart';

final class FixtureHelper {
  static const String url = 'https://test.com.br';

  static LoginEntity fetchLogin() {
    return LoginEntity.fromRemoteMap(jsonDecode(fixture('login.json')));
  }

  static LoggedEntity fetchUserLogged() {
    return LoggedEntity.fromRemoteMap(jsonDecode(fixture('user_logged.json')));
  }

  static Map<String, dynamic> fetchUserLoggedRemoteMap() {
    return jsonDecode(fixture('user_logged.json'));
  }

  static CourseEntity fetchCourseAdmin() {
    return CourseEntity.fromRemoteMap(jsonDecode(fixture('course.json')));
  }

  static Map<String, dynamic> fetchCourseAdminRemoteMap() {
    return jsonDecode(fixture('course.json'));
  }

  static CoursePreviewEntity fetchCoursePreview() {
    final list = fetchCoursePreviewRemoteMap();
    final map = list.first as Map<String, dynamic>;
    return CoursePreviewEntity.fromRemoteMap(map);
  }

  static List<dynamic> fetchCoursePreviewRemoteMap() {
    return jsonDecode(fixture('course_preview.json')) as List<dynamic>;
  }

  static EnrolledCourseEntity fetchEnrolledCourse() {
    final list = fetchCoursePreviewRemoteMap();
    final map = list.first as Map<String, dynamic>;
    return EnrolledCourseEntity.fromRemoteMap(map);
  }

  static List<dynamic> fetchEnrolledCourseRemoteMap() {
    return jsonDecode(fixture('enrolled_course.json')) as List<dynamic>;
  }
}