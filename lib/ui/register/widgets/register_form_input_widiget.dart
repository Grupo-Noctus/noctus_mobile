import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/widgets/app_input_form_widget.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';

class RegisterFormInputWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  const RegisterFormInputWidget({
    Key? key,
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  });

  @override
  State<RegisterFormInputWidget> createState() => _RegisterFormInputWidgetState();
}

class _RegisterFormInputWidgetState extends State<RegisterFormInputWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, IRequestState<String>>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return Column(
          children: [
            AppInputFormFieldWidget(
              controller: widget.nameController,
              labelText: 'Nome',
              validatorMessage: 'O nome é obrigatório.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Qual seu nome?',
              obscureText: false,
            ),
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.usernameController,
              labelText: 'Username',
              validatorMessage: 'O username é obrigatório.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Digite seu username.',
              obscureText: false,
            ),
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.emailController,
              labelText: 'Email',
              validatorMessage: 'O email é obrigatório.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Digite seu email.',
              obscureText: false,
            ),
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.phoneController,
              labelText: 'Telefone',
              validatorMessage: 'O número de telefone é obrigatório.',
              enabled: !isProcessing,
              textInputAction: TextInputAction.next,
              hintText: 'Digite seu telefone.',
              obscureText: false,
            ),
            const SizedBox(height: 8),
            AppInputFormFieldWidget(
              controller: widget.passwordController,
              labelText: 'Senha',
              validatorMessage: 'Criar uma senha é obrigatório.',
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

