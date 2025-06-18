import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_state.dart';
import 'package:video_player/video_player.dart';
import 'package:noctus_mobile/core/widgets/app_header.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class ViewCourseView extends StatelessWidget {
  const ViewCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewCourseViewModel, ViewCourseState>(
      builder: (context, state) {
        final viewModel = context.read<ViewCourseViewModel>();

        return Scaffold(
          backgroundColor: ThemeHelper.kPrimaryBlue,
          body: Column(
            children: [
              HeaderWidget(
                onLogout: () {
                  viewModel.logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: ThemeHelper.kWhite),
                  label: const Text(
                    'Voltar para Home',
                    style: TextStyle(color: ThemeHelper.kWhite),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              if (state.hasError) ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    state.errorMessage ?? 'Erro ao carregar o vídeo',
                    style: const TextStyle(
                      color: ThemeHelper.kAccentGreen,
                      fontSize: 16,
                    ),
                  ),
                ),
              ] else if (state.isPlayerInitialized &&
                  state.videoController != null) ...[
                AspectRatio(
                  aspectRatio: state.videoController!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(state.videoController!),
                      IconButton(
                        icon: Icon(
                          state.videoController!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 48,
                          color: ThemeHelper.kWhite.withOpacity(0.8),
                        ),
                        onPressed: () => viewModel.togglePlayPause(),
                      ),
                    ],
                  ),
                ),
              ],
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      if (state.selectedVideo != null) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ThemeHelper.kWhite,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: ThemeHelper.kDarkBlack.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.selectedVideo!.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeHelper.kDarkBlack,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.selectedVideo!.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ThemeHelper.kMediumGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      ...(viewModel.modules ?? []).map((module) {
                        final isSelected = module == state.selectedModule;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => viewModel.toggleModule(module),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? ThemeHelper.kAccentGreen
                                              .withOpacity(0.2)
                                          : ThemeHelper.kDarkBlack.withOpacity(
                                            0.3,
                                          ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_right,
                                      color: ThemeHelper.kAccentGreen,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        module.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ThemeHelper.kWhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 8),
                              ...module.videos.map((video) {
                                final isSelectedVideo =
                                    video == state.selectedVideo;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: InkWell(
                                    onTap: () => viewModel.selectVideo(video),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            isSelectedVideo
                                                ? ThemeHelper.kAccentGreen
                                                    .withOpacity(0.2)
                                                : ThemeHelper.kDarkBlack
                                                    .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.play_circle_outline,
                                            color:
                                                isSelectedVideo
                                                    ? ThemeHelper.kAccentGreen
                                                    : ThemeHelper.kWhite,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              video.name,
                                              style: TextStyle(
                                                color:
                                                    isSelectedVideo
                                                        ? ThemeHelper
                                                            .kAccentGreen
                                                        : ThemeHelper.kWhite,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                            const SizedBox(height: 8),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
