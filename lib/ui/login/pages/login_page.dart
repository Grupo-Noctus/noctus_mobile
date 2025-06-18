import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/assets_helper.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';
import 'package:noctus_mobile/ui/login/view_models/login_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/login/view_models/login_view_model.dart';
import 'package:noctus_mobile/ui/login/widget/login_button_widget.dart';
import 'package:noctus_mobile/ui/login/widget/login_form_input_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: LoginFactoryViewModel().create,
      child: const _LoginPage(),
    );
  }
}
class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<_LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginViewModel>();
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
                  const SizedBox(height: 80),
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
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold, 
                          color: ThemeHelper.kLightGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  Form(
                    key: _formKey,
                    child: LoginFormInputWidget(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Você não tem uma conta? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: ThemeHelper.kLightGray,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onNavigateGoRegister();
                        },
                        child: const Text(
                          "Clique aqui",
                          style: TextStyle(
                            color: ThemeHelper.kAccentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  LoginButtonWidget(
                    onPressed: () {
                      onLogin();
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

  void onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final controller = context.read<LoginViewModel>();
      final loginEntity =  LoginEntity(
        usernameOrEmail: emailController.text.trim(),
        password: passwordController.text,
      );

      controller.onAuthentication(loginEntity);
    }
  }
}
