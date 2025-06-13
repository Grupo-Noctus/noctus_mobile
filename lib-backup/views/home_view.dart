import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'styles.dart';
import 'package:provider/provider.dart';
import '../controllers/couses_controller.dart';
import '../utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CourseController _controller;
  @override
  void initState() {
    super.initState();
    _controller = Provider.of<CourseController>(context, listen: false);
    _controller.loadEnrolledCourses();
    _controller.fetchAllCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/instituto-matera.png',
              width: 170,
              height: 170,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.lightGray,),
            tooltip: 'Sair',
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout(context);
            },
          ),
        ],
        ),
      body: Consumer<CourseController>(
        builder: (context, controller, child) {
          if (controller.enrolledLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.enrolledError != null) {
            return Center(child: Text('Erro: ${controller.enrolledError}'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.school, color: AppColors.primaryBlue),
                    const SizedBox(width: 8),
                    const Text(
                      'Meus Cursos',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (controller.enrolledCourses.isEmpty)
                  Center(
                    child: Text(
                      'Sem matriculas',
                      style: textStyleNoCourse,
                    ),
                  )
                else
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.enrolledCourses.map((course) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Card(
                            shadowColor: AppColors.darkBlack.withOpacity(0.4),
                            margin: const EdgeInsets.only(left: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                height: 250,
                                width: MediaQuery.of(context).size.width - 36,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    controller.buildCourseImage(course.courseImage),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        width: double.infinity,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBlack.withOpacity(0.4),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              course.courseName,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.darkBlack,
                                                    blurRadius: 6,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Acessar curso',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.darkBlack,
                                                    blurRadius: 4,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                const SizedBox(height: 32),
                Row(
                  children: [
                    Icon(Icons.menu_book, color: AppColors.primaryBlue),
                    const SizedBox(width: 8),
                    const Text(
                      'Outros Cursos',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 3,
                  ),
                  itemCount: controller.allCourses.length,
                  itemBuilder: (context, index) {
                    final course = controller.allCourses[index];
                    return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: AppColors.darkBlack.withOpacity(0.4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 250,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            controller.buildCourseImage(course.image),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlack.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      course.name,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.darkBlack,
                                            blurRadius: 6,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Ver mais',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.darkBlack,
                                            blurRadius: 4,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
