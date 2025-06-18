import 'package:flutter_test/flutter_test.dart';
import 'package:noctus_mobile/domain/entities/course/enrolled_course_entity.dart';

import '../../../fixture/library/fixture_helper.dart';

void main() {
  group('EnrolledCourseEntity', () {
    test('should parse EnrolledCourseEntity correctly from remote map', () {
      final List<dynamic> list = FixtureHelper.fetchEnrolledCourseRemoteMap();
      final Map<String, dynamic> map = list.first as Map<String, dynamic>;
      final EnrolledCourseEntity entity = EnrolledCourseEntity.fromRemoteMap(map);

      expect(entity.idEnrrolment, equals(1));
      expect(entity.completed, equals(0));
      expect(entity.expiresAt, equals(DateTime.parse("2025-06-16T02:22:53.355Z")));
      expect(entity.idCourse, equals(1));
      expect(entity.nameCourse, equals("Curso Introdutório ao Docker"));
      expect(entity.courseDescription, contains("Doker"));
      expect(entity.courseImage, contains("dockerjpg"));

      expect(entity.modules.length, equals(3));

      final firstModule = entity.modules[0];
      expect(firstModule.id, equals(1));
      expect(firstModule.name, contains("Introdução"));
      expect(firstModule.description, contains("Docker"));
      expect(firstModule.order, equals(1));

      final firstModuleVideos = firstModule.videos;
      expect(firstModuleVideos.length, equals(1));

      final firstVideo = firstModuleVideos[0];
      expect(firstVideo.id, equals(1));
      expect(firstVideo.name, equals("Video 1"));
      expect(firstVideo.description, contains("Docker"));
      expect(firstVideo.duration, equals(32));
      expect(firstVideo.idProgressVideo, equals(1));
      expect(firstVideo.viewed, equals(40));
    });
  });
}
