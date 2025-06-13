import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/domain/entities/user/user_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';
import 'package:noctus_mobile/ui/register/widgets/register_avatar_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_button_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_form_widget.dart';
import 'package:noctus_mobile/core/widgets/show_dialog_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _selectedImage;

  void setSelectedImage(File? file) {
    setState(() {
      _selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RegisterViewModel, IRequestState<bool>>(
          listener: (context, state) {
            if (state is RequestErrorState) {
              showSnackBar("Erro no cadastro. Verifique os dados.");
            }
            // Navegação em caso de sucesso é feita no próprio ViewModel
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(42),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  const _HeaderWidget(),
                  const SizedBox(height: 20),
                  RegisterAvatarWidget(
                    selectedImage: _selectedImage,
                    onImageSelected: setSelectedImage,
                  ),
                  const SizedBox(height: 20),
                  RegisterFormFieldWidget(
                    controller: _nameController,
                    labelText: 'Nome',
                    validatorMessage: 'O nome é obrigatório',
                  ),
                  const SizedBox(height: 20),
                  RegisterFormFieldWidget(
                    controller: _usernameController,
                    labelText: 'Username',
                    validatorMessage: 'O username é obrigatório',
                  ),
                  const SizedBox(height: 20),
                  RegisterFormFieldWidget(
                    controller: _phoneController,
                    labelText: 'Telefone',
                    validatorMessage: 'O telefone é obrigatório',
                  ),
                  const SizedBox(height: 20),
                  RegisterFormFieldWidget(
                    controller: _emailController,
                    labelText: 'Email',
                    validatorMessage: 'O email é obrigatório',
                  ),
                  const SizedBox(height: 20),
                  RegisterFormFieldWidget(
                    controller: _passwordController,
                    labelText: 'Senha',
                    validatorMessage: 'A senha é obrigatória',
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  RegisterButtonWidget(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterViewModel>().onRegister(
                              RegisterEntity(
                                imagePath: _selectedImage?.path,
                                user: UserRegisterEntity(
                                  name: _nameController.text.trim(),
                                  username: _usernameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  phoneNumber: _phoneController.text.trim(),
                                ),
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/M Matera.png',
          width: 48,
          height: 48,
        ),
        const SizedBox(width: 4),
        const Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
