final class UserRegisterEntity {
  final String username;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  const UserRegisterEntity({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory UserRegisterEntity.fromMap(Map<String, dynamic> map) {
    return UserRegisterEntity(
      username: map[kKeyUsername],
      name: map[kKeyName],
      email: map[kKeyEmail],
      password: map[kKeyPassword],
      phoneNumber: map[kKeyPhoneNumber],
    );
  }

  Map<String, dynamic> toMap() => {
    kKeyUsername: username,
    kKeyName: name,
    kKeyEmail: email,
    kKeyPassword: password,
    kKeyPhoneNumber: phoneNumber,
  };

  static const String kKeyUsername = 'username';
  static const String kKeyName = 'name';
  static const String kKeyEmail = 'email';
  static const String kKeyPassword = 'password';
  static const String kKeyPhoneNumber = 'phoneNumber';
}
