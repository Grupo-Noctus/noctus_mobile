enum EducationLevel {
  noSchooling('NO_SCHOOLING', 'No schooling'),
  primaryIncomplete('PRIMARY_INCOMPLETE', 'Primary incomplete'),
  primaryComplete('PRIMARY_COMPLETE', 'Primary complete'),
  secondaryIncomplete('SECONDARY_INCOMPLETE', 'Secondary incomplete'),
  secondaryComplete('SECONDARY_COMPLETE', 'Secondary complete'),
  higherIncomplete('HIGHER_INCOMPLETE', 'Higher education incomplete'),
  higherComplete('HIGHER_COMPLETE', 'Higher education complete'),
  postgraduate('POSTGRADUATE', 'Postgraduate'),
  masters('MASTERS', 'Masters'),
  doctorate('DOCTORATE', 'Doctorate');

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
