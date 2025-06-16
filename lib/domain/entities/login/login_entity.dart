final class LoginEntity {
  final String usernameOrEmail;
  final String password;

  const LoginEntity({
    required this.usernameOrEmail,
    required this.password,
  });

  
  factory LoginEntity.fromMap(Map<String, dynamic> map) {
    return LoginEntity(
      usernameOrEmail: map[kKeyUsernameOrEmail],
      password: map[kKeyPassword],
    );
  }

  Map<String, dynamic> toMap() => {
    kKeyUsernameOrEmail: usernameOrEmail,
    kKeyPassword: password,
  };

  static const String kKeyUsernameOrEmail = 'usernameOrEmail';
  static const String kKeyPassword = 'password';
}