import 'package:noctus_mobile/utils/api_config.dart';

class AllCourses {
  final String name;
  final String description;
  final String image;
  final DateTime startDate;
  final DateTime endDate;

  AllCourses({
    required this.name,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  factory AllCourses.fromJson(Map<String, dynamic> json) {return AllCourses(
      name: json['name'],
      description: json['description'],
      image: '${ApiConfig.baseUrl}${json['image']}',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}