import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/domain/entities/video/video_entity.dart';

class ViewCourseViewModel extends ChangeNotifier {
  late VideoPlayerController _videoController;
  bool _initialized = false;
  late EnrolledCourseEntity _course;
  ModuleEntity? _selectedModule;
  VideoEntity? _selectedVideo;
  final INonRelationalDataSource _localStorage;

  ViewCourseViewModel(this._localStorage);

  bool get initialized => _initialized;
  VideoPlayerController get videoController => _videoController;
  EnrolledCourseEntity get course => _course;
  List<ModuleEntity> get modules => _course.modules;
  ModuleEntity? get selectedModule => _selectedModule;
  VideoEntity? get selectedVideo => _selectedVideo;

  void setCourse(EnrolledCourseEntity course) {
    _course = course;
    if (course.modules.isNotEmpty) {
      _selectedModule = course.modules.first;
      if (_selectedModule!.videos.isNotEmpty) {
        _initializeFirstVideo(_selectedModule!.videos.first);
      }
    }
  }

  void _initializeFirstVideo(VideoEntity video) async {
    _selectedVideo = video;
    await initializeVideo(video.url);
  }

  void toggleModule(ModuleEntity module) {
    if (_selectedModule == module) {
      _selectedModule = null;
    } else {
      _selectedModule = module;
    }
    notifyListeners();
  }

  Future<void> selectVideo(VideoEntity video) async {
    _selectedVideo = video;
    await initializeVideo(video.url);
  }

  Future<void> initializeVideo(String url) async {
    if (_initialized) {
      await _videoController.dispose();
    }
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

  Future<void> logout() async {
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserToken);
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserLogged);
  }

  @override
  void dispose() {
    if (_initialized) {
      _videoController.dispose();
    }
    super.dispose();
  }
}
