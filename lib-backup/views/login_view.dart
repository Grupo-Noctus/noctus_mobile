import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../service/auth_service.dart';
import '../utils/app_colors.dart';
import 'register_view_p1.dart';
import 'styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController(AuthService());

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
                const SizedBox(height: 130),
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
                      'Login',
                      style: textStyleRegister,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                TextFormField(
                  controller: _emailController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Username ou email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite seu email ou username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: inputTextStyle,
                  decoration: customInputDecoration('Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        _loginController.loginContext(
                          context: context,
                          usernameOrEmail: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    ),
                    child: const Text('LOGIN', style: buttonTextStyle),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Não possui uma conta? ',
                    style: TextStyle(
                      color: AppColors.accentGreen,
                    ),
                    children: [
                      TextSpan(
                        text: 'Clique aqui.',
                        style: textSpanRegisterStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const RegisterViewP1()),
                            );
                          },
                      ),
                    ],
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