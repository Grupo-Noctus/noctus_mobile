import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';
import 'package:video_player/video_player.dart';
import 'package:noctus_mobile/core/widgets/app_header.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class ViewCourseView extends StatelessWidget {
  const ViewCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewCourseViewModel>(context);

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          Container(
            color: ThemeHelper.kDarkBlack,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child:
                  viewModel.initialized
                      ? Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(viewModel.videoController),
                          IconButton(
                            iconSize: 64,
                            icon: Icon(
                              viewModel.videoController.value.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: ThemeHelper.kWhite,
                            ),
                            onPressed: viewModel.togglePlayPause,
                          ),
                        ],
                      )
                      : const Center(
                        child: CircularProgressIndicator(
                          color: ThemeHelper.kWhite,
                        ),
                      ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (viewModel.selectedVideo != null) ...[
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
                          viewModel.selectedVideo!.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ThemeHelper.kDarkBlack,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          viewModel.selectedVideo!.description,
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
                ...viewModel.modules.map((module) {
                  final isSelected = module == viewModel.selectedModule;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => viewModel.toggleModule(module),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? ThemeHelper.kAccentGreen.withOpacity(0.2)
                                    : ThemeHelper.kDarkBlack.withOpacity(0.3),
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
                        ...module.videos.map((video) {
                          final isCurrentVideo =
                              video == viewModel.selectedVideo;
                          return Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: ListTile(
                              leading: Icon(
                                Icons.play_circle_outline,
                                color:
                                    isCurrentVideo
                                        ? ThemeHelper.kAccentGreen
                                        : ThemeHelper.kWhite,
                              ),
                              title: Text(
                                video.name,
                                style: TextStyle(
                                  color:
                                      isCurrentVideo
                                          ? ThemeHelper.kAccentGreen
                                          : ThemeHelper.kWhite,
                                  fontWeight:
                                      isCurrentVideo
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                              subtitle: Text(
                                video.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: ThemeHelper.kMediumGray,
                                ),
                              ),
                              onTap: () => viewModel.selectVideo(video),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
