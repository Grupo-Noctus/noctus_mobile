import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/domain/entities/video/video_entity.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_state.dart';

class ViewCourseViewModel extends Cubit<ViewCourseState> {
  final INonRelationalDataSource _localStorage;
  VideoPlayerController? _videoController;

  ViewCourseViewModel(this._localStorage) : super(const ViewCourseState());

  List<ModuleEntity>? get modules => state.course?.modules;
  void setCourse(EnrolledCourseEntity course) {
    emit(state.copyWith(course: course));
    if (course.modules.isNotEmpty) {
      final firstModule = course.modules.first;
      toggleModule(firstModule);
      if (firstModule.videos.isNotEmpty) {
        initializeFirstVideo(firstModule);
      }
    }
  }

  void initializeFirstVideo(ModuleEntity module) {
    if (module.videos.isNotEmpty) {
      final firstVideo = module.videos.first;
      selectVideo(firstVideo);
    }
  }

  void toggleModule(ModuleEntity module) {
    if (state.selectedModule?.id == module.id) {
      emit(state.copyWith(selectedModule: null));
    } else {
      emit(state.copyWith(selectedModule: module));
    }
  }

  void selectVideo(VideoEntity video) async {
    if (state.videoController != null) {
      await state.videoController!.dispose();
    }

    emit(
      state.copyWith(
        selectedVideo: video,
        isPlayerInitialized: false,
        videoController: null,
      ),
    );

    initializePlayer(video.url);
  }

  void initializePlayer(String videoUrl) async {
    try {
      final controller = VideoPlayerController.network(videoUrl);
      await controller.initialize();

      emit(
        state.copyWith(
          videoController: controller,
          isPlayerInitialized: true,
          hasError: false,
          errorMessage: null,
        ),
      );

      controller.play();
    } catch (e) {
      setError('Erro ao inicializar o player de vídeo');
    }
  }

  void setError(String message) {
    emit(state.copyWith(hasError: true, errorMessage: message));
  }

  void clearError() {
    emit(state.copyWith(hasError: false, errorMessage: null));
  }

  void togglePlayPause() {
    if (state.videoController != null) {
      if (state.videoController!.value.isPlaying) {
        state.videoController!.pause();
      } else {
        state.videoController!.play();
      }
      emit(state);
    }
  }

  Future<void> logout() async {
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserToken);
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserLogged);
    if (state.videoController != null) {
      await state.videoController!.dispose();
    }
  }

  @override
  Future<void> close() async {
    if (state.videoController != null) {
      await state.videoController!.dispose();
    }
    return super.close();
  }
}
