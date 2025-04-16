import 'package:flutter/material.dart';
import 'package:noctus_mobile/models/all_courses.dart';
import 'package:noctus_mobile/models/enrolled_course.dart';
import 'package:noctus_mobile/utils/app_colors.dart';

class ViewDescriptionCourse extends StatelessWidget {
  final AllCourses? allCourses;
  final EnrolledCourse? enrolledCourse;
  const ViewDescriptionCourse({super.key, this.allCourses, this.enrolledCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
      backgroundColor: AppColors.primaryBlue,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 12.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/M Matera.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    ),
      body: Stack(
        children: [
          // Imagem de fundo
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.network(
              allCourses?.image ?? enrolledCourse?.courseImage ?? 'assets/images/image_default.png',
              fit: BoxFit.cover,
            ),
          ),
          // Bottom card section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 45),
                      Text(
                        allCourses?.name ?? enrolledCourse?.courseName ?? 'Sem nome',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Duration
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 18, color: Colors.black),
                            const SizedBox(width: 5),
                            Text(
                              "${allCourses?.durationCourse ?? enrolledCourse?.durationCourse ?? 0} Dias",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Descrição",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        allCourses?.description ?? enrolledCourse?.courseDescription ?? 'Sem descrição',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          child: const Text(
                            "Play",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
