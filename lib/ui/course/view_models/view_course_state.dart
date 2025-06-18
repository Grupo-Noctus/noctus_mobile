import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/domain/entities/video/video_entity.dart';
import 'package:video_player/video_player.dart';

class ViewCourseState {
  final bool isPlayerInitialized;
  final bool hasError;
  final String? errorMessage;
  final VideoPlayerController? videoController;
  final EnrolledCourseEntity? course;
  final ModuleEntity? selectedModule;
  final VideoEntity? selectedVideo;

  const ViewCourseState({
    this.isPlayerInitialized = false,
    this.hasError = false,
    this.errorMessage,
    this.videoController,
    this.course,
    this.selectedModule,
    this.selectedVideo,
  });

  ViewCourseState copyWith({
    bool? isPlayerInitialized,
    bool? hasError,
    String? errorMessage,
    VideoPlayerController? videoController,
    EnrolledCourseEntity? course,
    ModuleEntity? selectedModule,
    VideoEntity? selectedVideo,
  }) {
    return ViewCourseState(
      isPlayerInitialized: isPlayerInitialized ?? this.isPlayerInitialized,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      videoController: videoController ?? this.videoController,
      course: course ?? this.course,
      selectedModule: selectedModule ?? this.selectedModule,
      selectedVideo: selectedVideo ?? this.selectedVideo,
    );
  }
}
