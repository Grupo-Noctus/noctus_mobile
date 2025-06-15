import 'package:noctus_mobile/core/enum/brasilian_state_enum.dart';
import 'package:noctus_mobile/core/enum/education_level_enum.dart';
import 'package:noctus_mobile/core/enum/ethnicity_enum.dart';
import 'package:noctus_mobile/core/enum/gender_enum.dart';

final class StudentEntity {
  final DateTime dateBirth;
  final EducationLevel educationLevel;
  final BrazilianState state;
  final Ethnicity ethnicity;
  final Gender gender;
  final bool hasDisability;
  final String? disabilityType;
  final bool needsSupportResources;
  final String? supportResourcesDescription;

  const StudentEntity({
    required this.dateBirth,
    required this.educationLevel,
    required this.state,
    required this.ethnicity,
    required this.gender,
    required this.hasDisability,
    this.disabilityType,
    required this.needsSupportResources,
    this.supportResourcesDescription,
  });

  factory StudentEntity.fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      dateBirth: DateTime.parse(map[kKeyDateBirth]),
      educationLevel: map[kKeyEducationLevel],
      state: map[kKeyState],
      ethnicity: map[kKeyEthnicity],
      gender: map[kKeyGender],
      hasDisability: map[kKeyHasDisability],
      disabilityType: map[kKeyDisabilityType],
      needsSupportResources: map[kKeyNeedsSupportResources],
      supportResourcesDescription: map[kKeySupportResourcesDescription],
    );
  }

  Map<String, dynamic> toMap() {
  final map = {
    kKeyDateBirth: dateBirth.toIso8601String(),
    kKeyEducationLevel: educationLevel.value,
    kKeyState: state.value,
    kKeyEthnicity: ethnicity.value,
    kKeyGender: gender.value,
    kKeyHasDisability: hasDisability,
    kKeyNeedsSupportResources: needsSupportResources,
  };

  final localDisabilityType = disabilityType;
  if (hasDisability && localDisabilityType != null && localDisabilityType.isNotEmpty) {
    map[kKeyDisabilityType] = localDisabilityType;
  }

  final localSupportDescription = supportResourcesDescription;
  if (needsSupportResources &&
      localSupportDescription != null &&
      localSupportDescription.isNotEmpty) {
    map[kKeySupportResourcesDescription] = localSupportDescription;
  }

  return map;
}


  static const String kKeyDateBirth = 'dateBirth';
  static const String kKeyEducationLevel = 'educationLevel';
  static const String kKeyState = 'state';
  static const String kKeyEthnicity = 'ethnicity';
  static const String kKeyGender = 'gender';
  static const String kKeyHasDisability = 'hasDisability';
  static const String kKeyDisabilityType = 'disabilityType';
  static const String kKeyNeedsSupportResources = 'needsSupportResources';
  static const String kKeySupportResourcesDescription = 'supportResourcesDescription';
}
