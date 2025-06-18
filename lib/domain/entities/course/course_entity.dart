// domain/entities/course/course_entity.dart

final class CourseEntity {
  final String id;
  final String title;
  final String description;
  final String videoUrl;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  factory CourseEntity.fromMap(Map<String, dynamic> map) {
    return CourseEntity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videoUrl: map['video_url'] ?? '',
    );
  }

factory CourseEntity.fromRemoteMap(Map<String, dynamic> map) {
    return CourseEntity.fromMap(map);
  }
}