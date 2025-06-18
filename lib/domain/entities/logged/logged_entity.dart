import 'package:noctus_mobile/domain/entities/logged/user_logged.dart';

final class LoggedEntity {
  final String accessToken;
  final UserLoggedEntity user;

  const LoggedEntity({
    required this.accessToken,
    required this.user,
  });

  factory LoggedEntity.fromMap(Map<String, dynamic> map) {
    return LoggedEntity(
      accessToken: map['access_token'] as String,
      user: UserLoggedEntity.fromApiMap(map['payload'] as Map<String, dynamic>),
    );
  }
}
