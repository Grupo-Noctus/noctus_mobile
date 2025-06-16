import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:noctus_mobile/domain/entities/student/student_entity.dart';
import 'package:noctus_mobile/domain/entities/user/user_entity.dart';

final class RegisterEntity {
  final UserRegisterEntity user;
  final StudentEntity? student;
  final String? imageUser;

  const RegisterEntity({
    required this.user,
    this.student,
    required this.imageUser,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {
      'user': jsonEncode(user.toMap()),
    };

    if (student != null) {
      map['student'] = jsonEncode(student!.toMap());
    }

    if (imageUser != null && imageUser!.isNotEmpty) {
      final mimeType = lookupMimeType(imageUser!);

      map['imageUser'] = await MultipartFile.fromFile(
        imageUser!,
        filename: imageUser!.split('/').last,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
    }
    return FormData.fromMap(map);
  }
  RegisterEntity copyWith({
    UserRegisterEntity? user,
    StudentEntity? student,
    String? imageUser,
  }) {
    return RegisterEntity(
      user: user ?? this.user,
      student: student ?? this.student,
      imageUser: imageUser ?? this.imageUser,
    );
  }
}