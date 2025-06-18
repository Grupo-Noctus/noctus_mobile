final class UserLoggedEntity {
  final int id;
  final String name;
  final String username;
  final String? image;
  final String role;
  final bool active;

  const UserLoggedEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.image,
    required this.role,
    required this.active,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyUsername = 'username';
  static const String kKeyImage = 'image';
  static const String kKeyRole = 'role';
  static const String kKeyActive = 'active';

  factory UserLoggedEntity.fromApiMap(Map<String, dynamic> map) {
    return UserLoggedEntity(
      id: map['sub'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      image: map['image'] as String?,
      role: map['role'] as String,
      active: map['active'] as bool,
    );
  }

  factory UserLoggedEntity.fromMap(Map<String, dynamic> map) {
    return UserLoggedEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      username: map[kKeyUsername] as String,
      image: map[kKeyImage] as String?,
      role: map[kKeyRole] as String,
      active: (map[kKeyActive] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyUsername: username,
      kKeyImage: image,
      kKeyRole: role,
      kKeyActive: active ? 1 : 0,
    };
  }
}
