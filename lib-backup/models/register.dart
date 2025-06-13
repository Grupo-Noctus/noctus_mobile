import 'register_enuns.dart';

class Register {
  final RegisterUserDto user;
  final RegisterStudentDto? student;

  Register({
    required this.user,
    this.student,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      if (student != null) 'student': student!.toJson(),
    };
  }
}

class RegisterUserDto {
  final String username;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? image;

  RegisterUserDto({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'image': image,
    };
  }
}

class RegisterStudentDto {
  final DateTime? dateBirth;
  final EducationLevel? educationLevel;
  final BrazilianState? state;
  final Ethnicity? ethnicity;
  final Gender? gender;
  final bool? hasDisability;
  final DisabilityType? disabilityType;
  final bool? needsSupportResources;
  final String? supportResourcesDescription;

  RegisterStudentDto({
    this.dateBirth,
    this.educationLevel,
    this.state,
    this.ethnicity,
    this.gender,
    this.hasDisability,
    this.disabilityType,
    this.needsSupportResources,
    this.supportResourcesDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateBirth': dateBirth?.toIso8601String(),
      'educationLevel': educationLevel?.name,
      'state': state?.name,
      'ethnicity': ethnicity?.name,
      'gender': gender?.name,
      'hasDisability': hasDisability,
      'disabilityType': disabilityType?.name ?? 'null',
      'needsSupportResources': needsSupportResources,
      'supportResourcesDescription': supportResourcesDescription,
    };
  }

}
extension RegisterStudentDtoHelper on RegisterStudentDto {
  bool get isEmpty =>
    dateBirth == null &&
    educationLevel == null &&
    state == null &&
    ethnicity == null &&
    gender == null &&
    hasDisability == null &&
    disabilityType == null &&
    needsSupportResources == null &&
    supportResourcesDescription == null;

  bool get hasAnyInfo => !isEmpty;
}
