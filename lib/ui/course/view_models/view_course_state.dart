import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/domain/entities/video/video_entity.dart';
import 'package:video_player/video_player.dart';

/// Estado que representa a visualização de um curso
/// Contém todas as informações necessárias para renderizar a tela de curso
class ViewCourseState {
  /// Indica se o player de vídeo foi inicializado
  final bool initialized;

  /// Indica se há algum erro no estado atual
  final bool hasError;

  /// Mensagem de erro, se houver
  final String? errorMessage;

  /// Controlador do player de vídeo atual
  final VideoPlayerController? videoController;

  /// Curso que está sendo visualizado
  final EnrolledCourseEntity? course;

  /// Módulo selecionado atualmente
  final ModuleEntity? selectedModule;

  /// Vídeo selecionado atualmente
  final VideoEntity? selectedVideo;

  /// Construtor que inicializa o estado com valores padrão
  const ViewCourseState({
    this.initialized = false,
    this.hasError = false,
    this.errorMessage,
    this.videoController,
    this.course,
    this.selectedModule,
    this.selectedVideo,
  });

  /// Cria uma nova instância do estado com os valores atualizados
  /// Mantém os valores existentes para campos não especificados
  ViewCourseState copyWith({
    bool? initialized,
    bool? hasError,
    String? errorMessage,
    VideoPlayerController? videoController,
    EnrolledCourseEntity? course,
    ModuleEntity? selectedModule,
    VideoEntity? selectedVideo,
  }) {
    return ViewCourseState(
      initialized: initialized ?? this.initialized,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      videoController: videoController ?? this.videoController,
      course: course ?? this.course,
      selectedModule: selectedModule ?? this.selectedModule,
      selectedVideo: selectedVideo ?? this.selectedVideo,
    );
  }
}
