import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/widgets/show_dialog_widget.dart';
import 'package:noctus_mobile/data/repositories/register/login_repository.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/error/register/register_errors.dart';
import 'package:noctus_mobile/routing/route_generator.dart';
import 'package:noctus_mobile/utils/util_text.dart';
import 'package:noctus_mobile/utils/util_validator.dart';

final class RegisterViewModel extends Cubit<IRequestState<String>> {
  final IRegisterRepository _repository;
  final ILoginRepository _loginRepository;

  late RegisterEntity _registerEntity;
  File? _image;
  DateTime? _dateBirth;

  RegisterViewModel(this._repository, this._loginRepository)
      : super(const RequestInitiationState());

  RegisterEntity get registerEntity => _registerEntity;
  File? get image => _image;
  DateTime? get dateBirth => _dateBirth;

  void initRegister(RegisterEntity registerEntity) {
    _registerEntity = registerEntity;
  }

  void setImage(File? image) {
    _image = image;
    emit(state);
  }

  void setDateBirth(DateTime date) {
    _dateBirth = date;
    emit(state);
  }

  Future<void> onRegister(RegisterEntity entity) async {
    try {
      _emitter(RequestProcessingState());

      _validateEmail(entity.user.email);

      final bool isMatera = entity.user.email.trim().toLowerCase().endsWith('@matera.com');

      if (isMatera) {
        await _handleMateraRegister(entity);
      } else {
        _navigateToStudentRegister(entity);
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _emitter(RequestCompletedState());
    }
  }

  Future<void> _handleMateraRegister(RegisterEntity entity) async {
    _validateUserFields(entity);

    final adjusted = entity.copyWith(student: null);

    final success = await _repository.registerUser(adjusted);

    if (success) {
      showSnackBar(UtilText.labelRegisterSuccess);
      await _attemptAutoLogin(adjusted.user.email, adjusted.user.password);
    }
  }

  Future<void> onRegisterStudent(RegisterEntity entity) async {
    try {
      _emitter(RequestProcessingState());

      _validateUserFields(entity);

      final success = await _repository.registerUser(entity);

      if (success) {
        showSnackBar(UtilText.labelRegisterSuccess);
        await _attemptAutoLogin(entity.user.email, entity.user.password);
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _emitter(RequestCompletedState());
    }
  }

  Future<void> _attemptAutoLogin(String email, String password) async {
    final login = LoginEntity(usernameOrEmail: email, password: password);

    final result = await _loginRepository.authenticationAsync(login);

    if (result != null) {
      _navigateToHome();
    } else {
      showSnackBar('Login automático falhou. Faça login manualmente.');
    }
  }

  void _validateUserFields(RegisterEntity entity) {
    final user = entity.user;

    if (!UtilValidator.isValidUsername(user.username)) {
      throw UsernameInvalidException();
    }
    if (!UtilValidator.isValidPassword(user.password)) {
      throw PasswordInvalidException();
    }
    if (!UtilValidator.isValidPhone(user.phoneNumber)) {
      throw PhoneNumberInvalidException();
    }
  }

  void _validateEmail(String email) {
    if (!UtilValidator.isValidEmail(email)) {
      throw EmailInvalidException();
    }
  }


  void _navigateToStudentRegister(RegisterEntity entity) {
    getIt<IAppService>().navigateNamedTo(
      RouteGeneratorHelper.kStudentRegister,
      arguments: entity,
    );
  }

  void _navigateToHome() {
    getIt<IAppService>().navigateNamedReplacementTo(
      RouteGeneratorHelper.kHome,
    );
  }


  void _emitter(IRequestState<String> newState) {
    if (!isClosed) emit(newState);
  }

  void _handleError(Object error) {
    final message = _mapErrorToMessage(error);
    showSnackBar(message);
    _emitter(RequestErrorState(error: error));
  }

  String _mapErrorToMessage(Object error) {
    return switch (error) {
      UsernameInvalidException _ => UtilText.labelInvalidUsername,
      EmailInvalidException _ => UtilText.labelInvalidEmail,
      PhoneNumberInvalidException _ => UtilText.labelInvalidPhoneNumber,
      PasswordInvalidException _ => UtilText.labelInvalidPassword,
      DioException dio => dio.response?.data["message"] ?? "An unexpected error occurred.",
      _ => UtilText.labelRegisterFailure,
    };
  }
}
