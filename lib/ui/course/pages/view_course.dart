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
      backgroundColor: const Color(0xFF461CDC), // Roxo escuro
      body: Column(
        children: [
          HeaderWidget(
            onLogout: () {
              viewModel.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          // Back Button Section
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
          // Video Player Section
          Container(
            color: Colors.black,
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
                              color: Colors.white,
                            ),
                            onPressed: viewModel.togglePlayPause,
                          ),
                        ],
                      )
                      : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
            ),
          ),

          // Course Content Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Current Video Info
                if (viewModel.selectedVideo != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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
                            color: Color(0xFF333333), // Cinza escuro
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          viewModel.selectedVideo!.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666), // Cinza médio
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Modules List
                ...viewModel.modules.map((module) {
                  final isSelected = module == viewModel.selectedModule;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Module Header
                      InkWell(
                        onTap: () => viewModel.toggleModule(module),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_right,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  module.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Videos List (only show if module is selected)
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
                                        ? Colors.green
                                        : Colors.white70,
                              ),
                              title: Text(
                                video.name,
                                style: TextStyle(
                                  color:
                                      isCurrentVideo
                                          ? Colors.green
                                          : Colors.white,
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
                                style: const TextStyle(color: Colors.white70),
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
