import 'package:noctus_mobile/utils/api_config.dart';

class EnrolledCourse {
  final int enrollmentId;
  final bool active;
  final bool completed;
  final DateTime enrollmentStartDate;
  final DateTime enrollmentEndDate;
  final int courseId;
  final String courseName;
  final String courseDescription;
  final String courseImage;
  final DateTime courseStartDate;
  final DateTime courseEndDate;

  EnrolledCourse({
    required this.enrollmentId,
    required this.active,
    required this.completed,
    required this.enrollmentStartDate,
    required this.enrollmentEndDate,
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.courseImage,
    required this.courseStartDate,
    required this.courseEndDate,
  });

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
      enrollmentId: json['enrollmentId'],
      active: json['active'] == 1,
      completed: json['completed'] == 1,
      enrollmentStartDate: DateTime.parse(json['enrollmentStartDate']),
      enrollmentEndDate: DateTime.parse(json['enrollmentEndDate']),
      courseId: json['courseId'],
      courseName: json['courseName'],
      courseDescription: json['courseDescription'],
      courseImage: '${ApiConfig.baseUrl}${json['courseImage']}',
      courseStartDate: DateTime.parse(json['courseStartDate']),
      courseEndDate: DateTime.parse(json['courseEndDate']),
    );
  }
}

