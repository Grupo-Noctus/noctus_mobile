import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noctus_mobile/models/login.dart';
import 'package:noctus_mobile/models/register.dart';
import 'package:noctus_mobile/models/register_enuns.dart';
import 'package:noctus_mobile/service/auth_service.dart';
import 'package:noctus_mobile/utils/token_storage.dart';
import 'package:noctus_mobile/views/home_view.dart';
import 'package:noctus_mobile/views/register_view_p2.dart';

class RegisterController {
  final IAuthService _authService;

  RegisterController(this._authService);

  Future<void> registerContext({
    required BuildContext context,
    required String username,
    required String name,
    required String email,
    required String password,
    required String phone,
    File? image,
    DateTime? dateBirth,
    EducationLevel? educationLevel,
    BrazilianState? state,
    Ethnicity? ethnicity,
    Gender? gender,
    bool? hasDisability,
    DisabilityType? disabilityType,
    bool? needsSupportResources,
    String? supportResourcesDescription,
  }) async {
    final userDto = RegisterUserDto(
      username: username,
      name: name,
      email: email,
      password: password,
      phoneNumber: phone,
      image: image?.path,
    );
  
    final isMatera = email.toLowerCase().endsWith('@matera.com');

    
    if (isMatera) {
      await _handleMateraRegistration(context, userDto, image);
      return;
    }

    final studentDTO = RegisterStudentDto(
      dateBirth: dateBirth,
      educationLevel: educationLevel,
      state: state,
      ethnicity: ethnicity,
      gender: gender,
      hasDisability: hasDisability,
      disabilityType: disabilityType,
      needsSupportResources: needsSupportResources,
      supportResourcesDescription: supportResourcesDescription,
    );

    if (!studentDTO.hasAnyInfo) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RegisterViewP2(userDto: userDto)),
        );
    } else {
      await _handleStudentRegistration(context, userDto, studentDTO, image);
    }
  }

  Future<void> _handleMateraRegistration(
    BuildContext context,
    RegisterUserDto userDto,
    File? image,
  ) async {
    final dto = Register(user: userDto, student: null);
    final success = await _authService.register(dto, image);

    if (!success) {
      _showError(context, 'Erro no cadastro.');
      return;
    }

    final token = await _authService.login(
      Login(usernameOrEmail: userDto.email, password: userDto.password),
    );

    if (token != null) {
      await _onLoginSuccess(context, token);
      return;
    } else {
      _showError(context, 'Erro ao logar após o cadastro.');
      return;
    }
  }

  Future<void> _handleStudentRegistration(
    BuildContext context,
    RegisterUserDto userDto,
    RegisterStudentDto studentDto,
    File? image,
  ) async {
    final dto = Register(user: userDto, student: studentDto);
    final success = await _authService.register(dto, image);

    if (!success) {
      _showError(context, 'Erro no cadastro.');
      return;
    }

    final token = await _authService.login(
      Login(usernameOrEmail: userDto.email, password: userDto.password),
    );

    if (token != null) {
      await _onLoginSuccess(context, token);
    } else {
      _showError(context, 'Erro ao logar após o cadastro.');
    }
  }

  Future<void> _onLoginSuccess(BuildContext context, String token) async {
    await TokenStorage.saveAccessToken(token);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeView()),
    );
    _showMessage(context, 'Cadastro concluído com sucesso!');
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showError(BuildContext context, String message) {
    _showMessage(context, message);
  }
}