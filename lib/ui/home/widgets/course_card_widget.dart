import 'package:flutter/material.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';

class CourseCardWidget extends StatefulWidget {
  final CourseEntity course;

  const CourseCardWidget({super.key, required this.course});

  @override
  State<CourseCardWidget> createState() => _CourseCardWidgetState();
}

class _CourseCardWidgetState extends State<CourseCardWidget> {
  bool _showModules = false;

  void _toggleModules() {
    setState(() {
      _showModules = !_showModules;
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return GestureDetector(
      onTap: _toggleModules,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                course.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeHelper.kDarkBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${course.duration} minutos',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ThemeHelper.kAccentGreen,
                    ),
                  ),
                  if (_showModules) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Módulos:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemeHelper.kDarkBlack,
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
      ),
    );
  }

  List<Widget> _buildModuleList(List<ModuleEntity> modules) {
    if (modules.isEmpty) {
      return [
        const Text(
          'Nenhum módulo disponível.',
          style: TextStyle(color: Colors.grey),
        ),
      ];
    }

    return modules.map((module) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const Icon(Icons.arrow_right, color: ThemeHelper.kAccentGreen, size: 20),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                module.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: ThemeHelper.kMediumGray,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
