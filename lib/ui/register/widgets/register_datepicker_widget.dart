import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/domain/entities/core/request_state_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';

class RegisterDatePickerWidget extends StatefulWidget {
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  const RegisterDatePickerWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RegisterDatePickerWidget> createState() => _RegisterDatePickerWidgetState();
}

class _RegisterDatePickerWidgetState extends State<RegisterDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, IRequestState<String>>(
      builder: (context, state) {
        final text = widget.value != null
        ? "${widget.value!.day.toString().padLeft(2, '0')}/"
          "${widget.value!.month.toString().padLeft(2, '0')}/"
          "${widget.value!.year}"
        : "Qual sua data de nascimento?";
        return InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: widget.value ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              widget.onChanged(picked);
            }
          },
          child: InputDecorator(
            decoration: ThemeHelper.buildInputDecoration(
              labelText: 'Data de nascimento',
              hintText: 'Selecione sua data de nascimento',
            ),
            child: Text(
              text,
              style: ThemeHelper.inputTextStyle,
            ),
          ),
        );
      }
    );
  }  
}