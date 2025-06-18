import 'package:flutter/material.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/routing/route_generator.dart';

class EnrolledCourseCardWidget extends StatefulWidget {
  final EnrolledCourseEntity course;

  const EnrolledCourseCardWidget({super.key, required this.course});

  @override
  State<EnrolledCourseCardWidget> createState() =>
      _EnrolledCourseCardWidgetState();
}

class _EnrolledCourseCardWidgetState extends State<EnrolledCourseCardWidget> {
  bool _showModules = false;

  void _toggleModules() {
    setState(() {
      _showModules = !_showModules;
    });
  }

  void _navigateToCourseView() {
    if (!_isEnabled) return;

    Navigator.of(
      context,
    ).pushNamed(RouteGeneratorHelper.kCourseView, arguments: widget.course);
  }

  bool get _isEnabled =>
      widget.course.completed == 0 ||
      widget.course.expiresAt.isAfter(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: _isEnabled ? Colors.white : Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _navigateToCourseView,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                course.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _navigateToCourseView,
                  child: Text(
                    course.nameCourse,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _isEnabled ? Colors.black : Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course.courseDescription,
                  style: TextStyle(
                    fontSize: 14,
                    color: _isEnabled ? Colors.black54 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: _isEnabled ? Colors.green : Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Expira em: ${_formatDate(course.expiresAt)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _isEnabled ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    if (course.modules.isNotEmpty)
                      TextButton.icon(
                        onPressed: _toggleModules,
                        icon: Icon(
                          _showModules
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: _isEnabled ? Colors.blue : Colors.grey,
                        ),
                        label: Text(
                          _showModules ? 'Ocultar módulos' : 'Ver módulos',
                          style: TextStyle(
                            color: _isEnabled ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
                if (_showModules) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Módulos:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._buildModuleList(course.modules),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildModuleList(List<ModuleEntity> modules) {
    return modules.map((module) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          '• ${module.name}',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      );
    }).toList();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
