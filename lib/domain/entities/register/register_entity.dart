import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:noctus_mobile/domain/entities/student/student_entity.dart';
import 'package:noctus_mobile/domain/entities/user/user_entity.dart';

final class RegisterEntity {
  final UserRegisterEntity user;
  final StudentEntity? student;
  final String? imagePath;

  const RegisterEntity({
    required this.user,
    this.student,
    required this.imagePath,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'user': jsonEncode(user.toMap()),
    };

    if (student != null) {
      map['student'] = jsonEncode(student!.toMap());
    }

    if (imagePath != null && imagePath!.isNotEmpty) {
      map['imageUser'] = await MultipartFile.fromFile(
        imagePath!,
        filename: imagePath!.split('/').last,
      );
    }

    return FormData.fromMap(map);
  }
}