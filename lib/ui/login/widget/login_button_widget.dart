import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/core/widgets/app_button_widget.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/ui/login/view_models/login_view_model.dart';

class LoginButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const LoginButtonWidget({
    super.key,
    required this.onPressed
  });

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, IRequestState<String>>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return AppButtonWidget(
          text: 'LOGIN',
          onPressed: () => widget.onPressed(),
          isProcessing: isProcessing,
        );
      }
    );
  }
}
