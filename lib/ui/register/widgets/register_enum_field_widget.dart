import 'package:flutter/material.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/core/enum/gender_enum.dart';

class RegisterEnumDropdownWidget<T extends Enum> extends StatelessWidget {
  final String label;
  final List<T> values;
  final T? selectedValue;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const RegisterEnumDropdownWidget({
    super.key,
    required this.label,
    required this.values,
    required this.selectedValue,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items: values.map((e) {
        final displayLabel = (e is Gender) ? e.label : e.name;
        return DropdownMenuItem<T>(
          value: e,
          child: Text(
            displayLabel,
            style: ThemeHelper.inputTextStyle,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator, // 👈 validação aqui
      iconEnabledColor: ThemeHelper.kAccentGreen,
      dropdownColor: ThemeHelper.kDarkBlack,
      decoration: ThemeHelper.buildInputDecoration(labelText: label),
    );
  }
}
