final class ModulePreviewEntity {
  final int id;
  final String name;
  final String description;
  final int order;

  const ModulePreviewEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
  });

  static const String kKeyId = 'id';
  static const String kKeyName = 'name';
  static const String kKeyDescription = 'description';
  static const String kKeyOrder = 'order';

  factory ModulePreviewEntity.fromMap(Map<String, dynamic> map) {
    return ModulePreviewEntity(
      id: map[kKeyId] as int,
      name: map[kKeyName] as String,
      description: map[kKeyDescription] as String,
      order: map[kKeyOrder] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyName: name,
      kKeyDescription: description,
      kKeyOrder: order,
    };
  }
}
