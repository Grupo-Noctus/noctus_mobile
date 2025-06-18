import 'package:noctus_mobile/core/library/extensions.dart';

enum EducationLevel implements LabeledEnum {
  noSchooling('NO_SCHOOLING', 'Sem escolaridade'),
  primaryIncomplete('PRIMARY_INCOMPLETE', 'Ensino fundamental incompleto'),
  primaryComplete('PRIMARY_COMPLETE', 'Ensino fundamental completo'),
  secondaryIncomplete('SECONDARY_INCOMPLETE', 'Ensino médio incompleto'),
  secondaryComplete('SECONDARY_COMPLETE', 'Ensino médio completo'),
  higherIncomplete('HIGHER_INCOMPLETE', 'Ensino superior incompleto'),
  higherComplete('HIGHER_COMPLETE', 'Ensino superior completo'),
  postgraduate('POSTGRADUATE', 'Pós-graduação'),
  masters('MASTERS', 'Mestrado'),
  doctorate('DOCTORATE', 'Doutorado');

  final String value;
  final String label;
  const EducationLevel(this.value, this.label);

  static EducationLevel? fromValue(String? value) {
    return EducationLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EducationLevel.noSchooling,
    );
  }
}
