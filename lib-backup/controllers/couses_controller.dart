import 'package:flutter/material.dart';
import '../models/all_courses.dart';
import '../models/enrolled_course.dart';
import '../service/course_service.dart';

class CourseController extends ChangeNotifier {
  final ICourseService _courseService;

  CourseController(this._courseService) {
    loadEnrolledCourses();
    fetchAllCourses();
  }

  List<EnrolledCourse> _enrolledCourses = [];
  List<EnrolledCourse> get enrolledCourses => _enrolledCourses;

  String? _enrolledError;
  String? get enrolledError => _enrolledError;

  bool _enrolledLoading = false;
  bool get enrolledLoading => _enrolledLoading;

  Future<void> loadEnrolledCourses() async {
    _enrolledLoading = true;
    notifyListeners(); 

    try {
      _enrolledCourses = await _courseService.getEnrolledCourses();
      _enrolledError = null;
    } catch (error) {
      _enrolledError = error.toString();
      _enrolledCourses = [];
    }

    _enrolledLoading = false;
    notifyListeners();
  }

  // === All Courses ===
  List<AllCourses> _allCourses = [];
  List<AllCourses> get allCourses => _allCourses;

  bool _allLoading = false;
  bool get allLoading => _allLoading;

  String? _allError;
  String? get allError => _allError;

  Future<void> fetchAllCourses() async {
    _allLoading = true;
    notifyListeners();

    try {
      _allCourses = await _courseService.getAllCourses();
      _allError = null;
    } catch (error) {
      _allError = error.toString();
      _allCourses = [];
    } finally {
      _allLoading = false;
      notifyListeners();
    }
  }

  Widget buildCourseImage(String imagePath) {
    if (imagePath.startsWith('http') && !imagePath.endsWith('null')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/image_default.png',
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/images/image_default.png',
        fit: BoxFit.cover,
      );
    }
  }
}
