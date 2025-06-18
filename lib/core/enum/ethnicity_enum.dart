import 'package:noctus_mobile/core/library/extensions.dart';

enum Ethnicity implements LabeledEnum {
  white('WHITE', 'Branca'),
  black('BLACK', 'Preta'),
  brown('BROWN', 'Parda'),
  asian('ASIAN', 'Amarela'),
  indigenous('INDIGENOUS', 'Indígena'),
  other('OTHER', 'Outra');

  final String value;
  final String label;
  const Ethnicity(this.value, this.label);

  static Ethnicity? fromValue(String? value) {
    return Ethnicity.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Ethnicity.other,
    );
  }
}
