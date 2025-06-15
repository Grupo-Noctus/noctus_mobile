enum Ethnicity {
  white('WHITE', 'White'),
  black('BLACK', 'Black'),
  brown('BROWN', 'Brown'),
  asian('ASIAN', 'Asian'),
  indigenous('INDIGENOUS', 'Indigenous'),
  other('OTHER', 'Other');

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
