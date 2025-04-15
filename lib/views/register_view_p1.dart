import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctus_mobile/controllers/register_controller.dart';
import 'package:noctus_mobile/service/auth_service.dart';
import 'package:noctus_mobile/utils/app_colors.dart';
import 'package:noctus_mobile/views/styles.dart';

class RegisterViewP1 extends StatefulWidget {
  const RegisterViewP1({super.key});

  @override
  State<RegisterViewP1> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterViewP1> {
  final RegisterController _registerController = RegisterController(AuthService());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(42.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Row(
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
                      style: textStyleRegister,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.mediumGray,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ? const Icon(Icons.camera_alt, size: 40, color: AppColors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toque para selecionar uma foto',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Nome'),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Username'),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O username é obrigatório';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Telefone'),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O telefone é obrigatório';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Email'),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'O email é obrigatório';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Senha'),
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'A senha é obrigatória';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                       if (_formKey.currentState!.validate()) {
                        _registerController.registerContext(
                          context: context,
                          username: _usernameController.text,
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text,
                          image: _selectedImage,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    ),
                    child: const Text('CONTINUE', style: buttonTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
