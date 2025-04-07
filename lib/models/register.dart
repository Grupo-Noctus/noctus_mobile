class Register {
  final String username;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? image;

  Register({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.image
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "name": name,
      "email": email,
      "password": password,
      "image": image,
      "phoneNumber": phoneNumber
    };
  } 
}