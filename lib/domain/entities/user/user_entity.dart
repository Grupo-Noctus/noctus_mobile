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

  Map<String, dynamic> toMap() => {
    'username': username,
    'name': name,
    'email': email,
    'password': password,
    'phoneNumber': phoneNumber,
  };
}
