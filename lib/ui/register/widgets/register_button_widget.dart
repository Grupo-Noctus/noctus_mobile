import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/core/widgets/app_button_widget.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';

class RegisterButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const RegisterButtonWidget({
    super.key,
    required this.onPressed
  });

  @override
  State<RegisterButtonWidget> createState() => _RegisterButtonWidgetState();
}

class _RegisterButtonWidgetState extends State<RegisterButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, IRequestState<String>>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return AppButtonWidget(
          text: 'CONTINUE',
          onPressed: () => widget.onPressed(),
          isProcessing: isProcessing,
        );
      }
    );
  }
}
