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
  bool _hasError = false;
  String? _errorMessage;
  late EnrolledCourseEntity _course;
  ModuleEntity? _selectedModule;
  VideoEntity? _selectedVideo;
  final INonRelationalDataSource _localStorage;

  ViewCourseViewModel(this._localStorage);

  bool get initialized => _initialized;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
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
    final videoUrl = video.url;
    if (videoUrl.isNotEmpty) {
      await initializeVideo(videoUrl);
    } else {
      _setError('Vídeo não disponível');
    }
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
    final videoUrl = video.url;
    if (videoUrl.isNotEmpty) {
      await initializeVideo(videoUrl);
    } else {
      _setError('Vídeo não disponível');
    }
  }

  Future<void> initializeVideo(String url) async {
    _clearError();
    if (_initialized) {
      await _videoController.dispose();
      _initialized = false;
    }

    try {
      _videoController = VideoPlayerController.network(url);
      await _videoController.initialize();
      _videoController.play();
      _initialized = true;
      notifyListeners();
    } catch (e) {
      _setError(
        'Erro ao carregar o vídeo. Verifique sua conexão e tente novamente.',
      );
    }
  }

  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    _initialized = false;
    notifyListeners();
  }

  void _clearError() {
    _hasError = false;
    _errorMessage = null;
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
