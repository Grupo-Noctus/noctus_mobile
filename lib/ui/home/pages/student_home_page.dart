import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/core/widgets/app_header.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_preview_entity.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/ui/home/view_models/student_home_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/home/view_models/student_home_view_model.dart';
import 'package:noctus_mobile/ui/home/widgets/course_preview_card_widget.dart';
import 'package:noctus_mobile/ui/home/widgets/enrolled_course_card_widget.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentCoursesViewModel>(
      create: StudentCoursesFactoryViewModel().create,
      child: const _StudentHomePage(),
    );
  }
}

class _StudentHomePage extends StatefulWidget {
  const _StudentHomePage();

  @override
  State<_StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<_StudentHomePage> {
  late final StudentCoursesViewModel _viewModel;
  late Future<List<CoursePreviewEntity>> _publicCoursesFuture;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<StudentCoursesViewModel>();
    _viewModel.loadCourses();
    _publicCoursesFuture = _viewModel.loadPublicCourses();
  }

  void _logout() {
    _viewModel.logout();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(onLogout: _logout),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Cursos Matriculados'),
                  BlocBuilder<StudentCoursesViewModel, IRequestState<List<EnrolledCourseEntity>>>(
                    builder: (context, state) {
                      if (state is RequestProcessingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is RequestErrorState) {
                        return Center(
                          child: Text(
                            'Erro ao carregar cursos matriculados: ${state.error}',
                            style: const TextStyle(color: ThemeHelper.kAccentGreen),
                          ),
                        );
                      }

                      if (state is RequestCompletedState<List<EnrolledCourseEntity>>) {
                        final courses = state.value;

                        if (courses == null || courses.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text('Você ainda não está matriculado em nenhum curso.'),
                          );
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            return EnrolledCourseCardWidget(course: courses[index]);
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Cursos Disponíveis'),
                  FutureBuilder<List<CoursePreviewEntity>>(
                    future: _publicCoursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erro ao carregar cursos disponíveis.',
                            style: const TextStyle(color: ThemeHelper.kAccentGreen),
                          ),
                        );
                      }

                      final courses = snapshot.data ?? [];

                      if (courses.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text('Nenhum curso disponível no momento.'),
                        );
                      }

                     return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: courses.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75, 
                        ),
                        itemBuilder: (context, index) {
                          return CoursePreviewCardWidget(course: courses[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ThemeHelper.kDarkBlack,
        ),
      ),
    );
  }
}
