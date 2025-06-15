enum Gender {
  male('MALE', 'Male'),
  female('FEMALE', 'Female'),
  nonBinary('NON_BINARY', 'Non-binary'),
  preferNotToSay('PREFER_NOT_TO_SAY', 'Prefer not to say');

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
