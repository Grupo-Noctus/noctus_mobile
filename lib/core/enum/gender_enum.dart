import 'package:noctus_mobile/core/library/extensions.dart';

enum Gender implements LabeledEnum {
  male('MALE', 'Masculino'),
  female('FEMALE', 'Feminino'),
  nonBinary('NON_BINARY', 'Não binário'),
  preferNotToSay('PREFER_NOT_TO_SAY', 'Prefiro não informar');

  final String value;
  final String label;
  const Gender(this.value, this.label);

  static Gender? fromValue(String? value) {
    return Gender.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Gender.preferNotToSay,
    );
  }
}
