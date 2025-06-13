import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/widgets/show_dialog_widget.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/error/register/register_errors.dart';
import 'package:noctus_mobile/routing/route_generator.dart';
import 'package:noctus_mobile/utils/util_text.dart';
import 'package:noctus_mobile/utils/util_validator.dart';

final class RegisterViewModel extends Cubit<IRequestState<bool>> {
  final IRegisterRepository _repository;

  RegisterViewModel(this._repository) : super(const RequestInitiationState());

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
        await _registerExternal(registerEntity);
      }
    } catch (error) {
      final String errorDescription = _createErrorDescription(error);
      showSnackBar(errorDescription);
      _emitter(RequestErrorState(error: error));
    }
  }

  Future<void> _registerMatera(RegisterEntity registerEntity) async {
    final String username = registerEntity.user.username;
    final String password = registerEntity.user.password;
    final String phoneNumber = registerEntity.user.phoneNumber;

    if (!UtilValidator.isValidPassword(password)) {
      throw PasswordInvalidException();
    }
    if (!UtilValidator.isValidPhone(phoneNumber)) {
      throw PhoneNumberInvalidException();
    }
    if (!UtilValidator.isValidUsername(username)) {
      throw UsernameInvalidException();
    }

    final adjustedEntity = RegisterEntity(
      user: registerEntity.user,
      student: null,
      imagePath: registerEntity.imagePath,
    );

    final bool success = await _repository.registerUser(adjustedEntity);

    if (success) _onNavigateGoLogin();

    _emitter(RequestCompletedState(value: success));
  }

  Future<void> _registerExternal(RegisterEntity registerEntity) async {
    final String username = registerEntity.user.username;
    final String password = registerEntity.user.password;
    final String phoneNumber = registerEntity.user.phoneNumber;

    if (!UtilValidator.isValidPassword(password)) {
      throw PasswordInvalidException();
    }
    if (!UtilValidator.isValidPhone(phoneNumber)) {
      throw PhoneNumberInvalidException();
    }
    if (!UtilValidator.isValidUsername(username)) {
      throw UsernameInvalidException();
    }

    final bool success = await _repository.registerUser(registerEntity);

    if (success) _onNavigateGoLogin();

    _emitter(RequestCompletedState(value: success));
  }

  void _onNavigateGoLogin() {
    getIt<IAppService>().navigateNamedReplacementTo(RouteGeneratorHelper.kRegister);
  }

  String _createErrorDescription(Object? error) {
    if (error is EmailInvalidException) return UtilText.labelInvalidEmail;
    if (error is PasswordInvalidException) return UtilText.labelInvalidPassword;
    if (error is UsernameInvalidException) return UtilText.labelInvalidUsername;
    if (error is PhoneNumberInvalidException) return UtilText.labelInvalidPhoneNumber;
    return UtilText.labelRegisterFailure;
  }

  void _emitter(IRequestState<bool> state) {
    if (isClosed) return;
    emit(state);
  }
}
