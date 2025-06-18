import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';
import 'package:noctus_mobile/domain/entities/module/module_entity.dart';
import 'package:noctus_mobile/domain/entities/video/video_entity.dart';
import 'package:noctus_mobile/ui/course/view_models/view_course_state.dart';

/// ViewModel responsável por gerenciar o estado e a lógica da visualização de um curso
/// Utiliza o padrão Cubit para gerenciamento de estado
class ViewCourseViewModel extends Cubit<ViewCourseState> {
  final INonRelationalDataSource _localStorage;
  VideoPlayerController? _videoController;

  /// Construtor que inicializa o ViewModel com estado padrão
  ViewCourseViewModel(this._localStorage) : super(const ViewCourseState());

  /// Retorna a lista de módulos do curso atual
  List<ModuleEntity> get modules => state.course?.modules ?? [];

  /// Define o curso a ser visualizado e inicializa o primeiro módulo e vídeo
  void setCourse(EnrolledCourseEntity course) {
    emit(state.copyWith(course: course));

    if (course.modules.isNotEmpty) {
      final firstModule = course.modules.first;
      emit(state.copyWith(selectedModule: firstModule));

      if (firstModule.videos.isNotEmpty) {
        _initializeFirstVideo(firstModule.videos.first);
      }
    }
  }

  /// Inicializa o primeiro vídeo do módulo
  void _initializeFirstVideo(VideoEntity video) async {
    emit(state.copyWith(selectedVideo: video));

    final videoUrl = video.url;
    if (videoUrl.isNotEmpty) {
      await initializeVideo(videoUrl);
    } else {
      _setError('Vídeo não disponível');
    }
  }

  /// Alterna a seleção de um módulo (expande/colapsa)
  void toggleModule(ModuleEntity module) {
    final newSelectedModule = state.selectedModule == module ? null : module;
    emit(state.copyWith(selectedModule: newSelectedModule));
  }

  /// Seleciona um vídeo para reprodução
  Future<void> selectVideo(VideoEntity video) async {
    emit(state.copyWith(selectedVideo: video));

    final videoUrl = video.url;
    if (videoUrl.isNotEmpty) {
      await initializeVideo(videoUrl);
    } else {
      _setError('Vídeo não disponível');
    }
  }

  /// Inicializa o player de vídeo com a URL fornecida
  Future<void> initializeVideo(String url) async {
    _clearError();

    if (state.initialized && _videoController != null) {
      await _videoController!.dispose();
      emit(state.copyWith(initialized: false));
    }

    try {
      _videoController = VideoPlayerController.network(url);
      await _videoController!.initialize();
      _videoController!.play();

      emit(
        state.copyWith(initialized: true, videoController: _videoController),
      );
    } catch (e) {
      _setError(
        'Erro ao carregar o vídeo. Verifique sua conexão e tente novamente.',
      );
    }
  }

  /// Define um estado de erro
  void _setError(String message) {
    emit(
      state.copyWith(hasError: true, errorMessage: message, initialized: false),
    );
  }

  /// Limpa o estado de erro
  void _clearError() {
    emit(state.copyWith(hasError: false, errorMessage: null));
  }

  /// Alterna entre play/pause do vídeo atual
  void togglePlayPause() {
    if (_videoController == null) return;

    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
    } else {
      _videoController!.play();
    }
    emit(state); // Notifica mudança de estado do player
  }

  /// Realiza o logout do usuário
  Future<void> logout() async {
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserToken);
    await _localStorage.remove(DataBaseNoSqlSchemaHelper.kUserLogged);
  }

  /// Limpa os recursos ao fechar o ViewModel
  @override
  Future<void> close() async {
    if (state.initialized && _videoController != null) {
      await _videoController!.dispose();
    }
    return super.close();
  }
}
