import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_viewmodel.dart';
import 'package:video_player/video_player.dart';

class ViewCourseView extends StatelessWidget {
  const ViewCourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewCourseViewModel>(context);

    if (!viewModel.initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    VideoPlayerController controller = viewModel.videoController;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          Center(
            child: IconButton(
              iconSize: 64,
              icon: Icon(
                controller.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: Colors.white,
              ),
              onPressed: viewModel.togglePlayPause,
            ),
          ),
        ],
      ),
    );
  }
}
