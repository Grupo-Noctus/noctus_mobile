import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/assets_helper.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/entities/user/user_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';
import 'package:noctus_mobile/ui/register/widgets/register_avatar_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_button_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_form_input_widiget.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterViewModel>(
      create: RegisterFactoryViewmodel().create,
      child: const _RegisterPage(),
    );
  }
}
class _RegisterPage extends StatefulWidget {
  const _RegisterPage();

  @override
  State<_RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<_RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RegisterViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AssetsHelper.assetsM,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Cadastro',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold, 
                          color: ThemeHelper.kLightGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  RegisterAvatarWidget(
                    selectedImage: controller.image,
                    onImageSelected: controller.setImage,
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: RegisterFormInputWidget(
                      nameController: nameController,
                      usernameController: usernameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      phoneController: phoneController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  RegisterButtonWidget(
                    onPressed: () {
                      onRegister();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      final controller = context.read<RegisterViewModel>();
      final registerEntity = RegisterEntity(
        user: UserRegisterEntity(
          username: usernameController.text.trim(),
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          phoneNumber: phoneController.text.trim(),
        ),
        student: null,
        imageUser: controller.image?.path,
      );

      controller.onRegister(registerEntity);
    }
  }
}
