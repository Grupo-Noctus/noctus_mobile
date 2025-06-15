import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/enum/gender_enum.dart';
import 'package:noctus_mobile/core/widgets/show_dialog_widget.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/error/register/register_errors.dart';
import 'package:noctus_mobile/routing/route_generator.dart';
import 'package:noctus_mobile/utils/util_text.dart';
import 'package:noctus_mobile/utils/util_validator.dart';

final class RegisterViewModel extends Cubit<IRequestState<String>> {
  final IRegisterRepository _repository;
  late RegisterEntity _registerEntity;

  RegisterViewModel(this._repository) : super(const RequestInitiationState());

  void initRegister(RegisterEntity registerEntity) {
    _registerEntity = registerEntity;
  }

  RegisterEntity get registerEntity => _registerEntity;

  File? _image;
  File? get image => _image;
  void setImage(File? image) {
    _image = image;
    emit(state);
  }

  DateTime? _dateBirth;
  DateTime? get dateBirth => _dateBirth;

  void setDateBirth(DateTime date) {
    _dateBirth = date;
    emit(state);
  }

  void onRegister(RegisterEntity registerEntity) async {
    try {
      _emitter(RequestProcessingState());

      final String email = registerEntity.user.email;

      if (!UtilValidator.isValidEmail(email)) {
        throw EmailInvalidException();
      }

      final bool isMatera = email.trim().toLowerCase().endsWith('@matera.com');

      if (isMatera) {
        await _registerMatera(registerEntity);
      } else {
        _onNavigateGoStudentRegister(registerEntity);
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _emitter(RequestCompletedState());
    }
  }

  Future<void> _registerMatera(RegisterEntity registerEntity) async {
    _validateUserFields(registerEntity);

    final adjustedEntity = RegisterEntity(
      user: registerEntity.user,
      student: null,
      imageUser: registerEntity.imageUser,
    );

    final bool success = await _repository.registerUser(adjustedEntity);

    if (success) {
      showSnackBar(UtilText.labelRegisterSuccess);
      _emitter(RequestCompletedState());
      _onNavigateGoHome();
    }

    _emitter(RequestCompletedState());
  }

  void onRegisterStudent(RegisterEntity registerEntity) async {
    try {
      _emitter(RequestProcessingState());

      _validateUserFields(registerEntity);

      final bool success = await _repository.registerUser(registerEntity);

      if (success) {
        showSnackBar(UtilText.labelRegisterSuccess);
        _onNavigateGoHome();
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _emitter(RequestCompletedState());
    }
  }

  void _validateUserFields(RegisterEntity entity) {
    final username = entity.user.username;
    final password = entity.user.password;
    final phoneNumber = entity.user.phoneNumber;

    if (!UtilValidator.isValidPassword(password)) {
      throw PasswordInvalidException();
    }
    if (!UtilValidator.isValidPhone(phoneNumber)) {
      throw PhoneNumberInvalidException();
    }
    if (!UtilValidator.isValidUsername(username)) {
      throw UsernameInvalidException();
    }
  }

  void _onNavigateGoStudentRegister(RegisterEntity entity) {
    getIt<IAppService>().navigateNamedTo(
      RouteGeneratorHelper.kStudentRegister,
      arguments: entity,
    );
  }

  void _onNavigateGoHome() {
    getIt<IAppService>().navigateNamedReplacementTo(RouteGeneratorHelper.kRegister); 
  }

  void _emitter(IRequestState<String> state) {
    if (isClosed) return;
    emit(state);
  }

  void _handleError(Object error) {
    final String message = _createErrorDescription(error);
    showSnackBar(message);
    _emitter(RequestErrorState(error: error));
  }

  String _createErrorDescription(Object? error) {
    if (error is UsernameInvalidException) return UtilText.labelInvalidUsername;
    if (error is EmailInvalidException) return UtilText.labelInvalidEmail;
    if (error is PhoneNumberInvalidException) return UtilText.labelInvalidPhoneNumber;
    if (error is PasswordInvalidException) return UtilText.labelInvalidPassword;

    if (error is DioException) {
      return error.response?.data["message"] ?? "An unexpected error occurred.";
    }

    return UtilText.labelRegisterFailure;
  }
}
