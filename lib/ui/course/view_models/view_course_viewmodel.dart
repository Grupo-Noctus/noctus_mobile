import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewCourseViewModel extends ChangeNotifier {
  late VideoPlayerController _videoController;
  bool _initialized = false;

  bool get initialized => _initialized;
  VideoPlayerController get videoController => _videoController;

  Future<void> initializeVideo(String url) async {
    _videoController = VideoPlayerController.network(url);
    await _videoController.initialize();
    _videoController.play();
    _initialized = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    notifyListeners();
  }

  void disposeVideo() {
    _videoController.dispose();
  }
}
