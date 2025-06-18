import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/widgets/show_dialog_widget.dart';
import 'package:noctus_mobile/data/repositories/login/login_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';
import 'package:noctus_mobile/domain/error/register/register_errors.dart';
import 'package:noctus_mobile/routing/route_generator.dart';
import 'package:noctus_mobile/utils/util_text.dart';
import 'package:noctus_mobile/utils/util_validator.dart';

final class LoginViewModel extends Cubit<IRequestState<String>> {
  final ILoginRepository _loginRepository;
  final INonRelationalDataSource _nonRelationalDataSource;
  final IAppService _appService;

  LoginViewModel(
    this._loginRepository,
    this._nonRelationalDataSource,
    this._appService,
  ) : super(const RequestInitiationState());

  void onAuthentication(LoginEntity loginEntity) async {
    try {
      _emitter(RequestProcessingState());

      if (!UtilValidator.isValidEmail(loginEntity.usernameOrEmail)) {
        throw EmailInvalidException();
      }
      if (!UtilValidator.isValidPassword(loginEntity.password)) {
        throw PasswordInvalidException();
      }

      final result = await _loginRepository.authenticationAsync(loginEntity);

      if (result == null) {
        showSnackBar('Erro ao realizar o login.');
        _emitter(const RequestCompletedState(value: ''));
        return;
      }

      await _nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserToken,
        result.accessToken,
      );

      await _nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserLogged,
        jsonEncode(result.user.toMap()),
      );

      _onNavigateGoHome(result.user.role);

      _emitter(RequestCompletedState(value: result.accessToken));
    } catch (error) {
      final String errorDescription = _createErrorDescription(error);
      showSnackBar(errorDescription);
      _emitter(RequestErrorState(error: error));
    }
  }

  void onNavigateGoRegister() {
    _appService.navigateNamedTo(RouteGeneratorHelper.kRegister);
  }

  void _onNavigateGoHome(String role) {
    if (role == 'ADMIN') {
      _appService.navigateNamedReplacementTo(RouteGeneratorHelper.kAdminHome);
    } else {
      _appService.navigateNamedReplacementTo(RouteGeneratorHelper.kStudentHome);
    }
  }

  String _createErrorDescription(Object? error) {
    if (error is EmailInvalidException) return UtilText.labelInvalidEmail;
    if (error is PasswordInvalidException) return UtilText.labelInvalidPassword;
    return UtilText.labelLoginFailure;
  }

  void _emitter(IRequestState<String> state) {
    if (isClosed) return;
    emit(state);
  }
}

