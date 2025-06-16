import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/widgets/app_input_form_widget.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/ui/login/view_models/login_view_model.dart';

class LoginFormInputWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormInputWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormInputWidget> createState() => _LoginFormInputWidgetState();
}

class _LoginFormInputWidgetState extends State<LoginFormInputWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, IRequestState<String>>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return Column(
          children: [
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.emailController,
              labelText: 'Email',
              validatorMessage: 'O email é obrigatório.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Insira seu email.',
              obscureText: false,
            ),
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.passwordController,
              labelText: 'Senha',
              validatorMessage: 'Insira sua senha.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Digite sua senha.',
              obscureText: true,
            ),
          ]
        );
      }
    );
  }
}

