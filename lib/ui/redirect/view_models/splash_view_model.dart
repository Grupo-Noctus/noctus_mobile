import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/routing/route_generator.dart';

final class SplashViewmodel extends Cubit<IRequestState<String>> {
  final INonRelationalDataSource _nonRelationalDataSource;

  SplashViewmodel(this._nonRelationalDataSource)
      : super(const RequestInitiationState());

  Future<void> init() async {
    _emitter(RequestProcessingState());

    try {
      final token = await _nonRelationalDataSource.loadString(
        DataBaseNoSqlSchemaHelper.kUserToken,
      );

      if (token != null && token.isNotEmpty) {
        _onNavigateGoHome();
        _emitter(RequestCompletedState(value: token));
      } else {
        _onNavigateGoLogin();
        _emitter(const RequestCompletedState(value: ''));
      }
    } catch (error) {
      _emitter(RequestErrorState(error: error));
      _onNavigateGoLogin();
    }
  }

  void _onNavigateGoHome() {
    getIt<IAppService>().navigateNamedReplacementTo(RouteGeneratorHelper.kHome);
  }

  void _onNavigateGoLogin() {
    getIt<IAppService>().navigateNamedReplacementTo(RouteGeneratorHelper.kLogin);
  }

  void _emitter(IRequestState<String> state) {
    if (isClosed) return;
    emit(state);
  }
}
