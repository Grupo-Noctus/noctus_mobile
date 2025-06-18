import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/core/widgets/app_header.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';
import 'package:noctus_mobile/ui/home/view_models/admin/admin_home_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/home/view_models/admin/admin_home_view_model.dart';
import 'package:noctus_mobile/ui/home/widgets/course_card_widget.dart';

class AdminCoursesPage extends StatelessWidget {
  const AdminCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminCoursesViewModel>(
      create: AdminCoursesFactoryViewModel().create,
      child: const _AdminCoursesPage(),
    );
  }
}

class _AdminCoursesPage extends StatefulWidget {
  const _AdminCoursesPage();

  @override
  State<_AdminCoursesPage> createState() => _AdminCoursesPageState();
}

class _AdminCoursesPageState extends State<_AdminCoursesPage> {
  late final AdminCoursesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<AdminCoursesViewModel>();
    _viewModel.loadCourses();
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
            child: BlocBuilder<AdminCoursesViewModel, IRequestState<List<CourseEntity>>>(
              builder: (context, state) {
                if (state is RequestProcessingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RequestErrorState) {
                  return Center(
                    child: Text(
                      'Erro ao carregar cursos: ${state.error}',
                      style: const TextStyle(color: ThemeHelper.kAccentGreen),
                    ),
                  );
                }

                if (state is RequestCompletedState<List<CourseEntity>>) {
                  final courses = state.value;

                  if (courses == null || courses.isEmpty) {
                    return const Center(
                      child: Text('Nenhum curso encontrado'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCardWidget(course: courses[index]);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
