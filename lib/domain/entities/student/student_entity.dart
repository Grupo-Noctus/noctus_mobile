final class StudentEntity {
  final DateTime dateBirth;
  final String educationLevel;
  final String state;
  final String ethnicity;
  final String gender;
  final bool hasDisability;
  final bool needsSupportResources;

  const StudentEntity({
    required this.dateBirth,
    required this.educationLevel,
    required this.state,
    required this.ethnicity,
    required this.gender,
    required this.hasDisability,
    required this.needsSupportResources,
  });

  factory StudentEntity.fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      dateBirth: DateTime.parse(map[kKeyDateBirth]),
      educationLevel: map[kKeyEducationLevel],
      state: map[kKeyState],
      ethnicity: map[kKeyEthnicity],
      gender: map[kKeyGender],
      hasDisability: map[kKeyHasDisability],
      needsSupportResources: map[kKeyNeedsSupportResources],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyDateBirth: dateBirth.toIso8601String(),
      kKeyEducationLevel: educationLevel,
      kKeyState: state,
      kKeyEthnicity: ethnicity,
      kKeyGender: gender,
      kKeyHasDisability: hasDisability,
      kKeyNeedsSupportResources: needsSupportResources,
    };
  }

  static const String kKeyDateBirth = 'dateBirth';
  static const String kKeyEducationLevel = 'educationLevel';
  static const String kKeyState = 'state';
  static const String kKeyEthnicity = 'ethnicity';
  static const String kKeyGender = 'gender';
  static const String kKeyHasDisability = 'hasDisability';
  static const String kKeyNeedsSupportResources = 'needsSupportResources';
}
