import 'package:flutter_test/flutter_test.dart';
import 'package:noctus_mobile/domain/entities/course/course_preview_entity.dart';

import '../../../fixture/library/fixture_helper.dart';
void main() {
  test('should parse CoursePreviewEntity correctly from remote map', () {
    final List<dynamic> list = FixtureHelper.fetchCoursePreviewRemoteMap();
    final Map<String, dynamic> map = list.first as Map<String, dynamic>;
    final CoursePreviewEntity entity = CoursePreviewEntity.fromRemoteMap(map);

    expect(entity.id, equals(1));
    expect(entity.name, equals('Curso Introdutório ao Docker'));
    expect(entity.description, contains('Doker'));
    expect(entity.image, contains('dockerjpg'));
    expect(entity.duration, equals(21));

    expect(entity.countModules, equals(3));
    expect(entity.countVideos, equals(1));
    expect(entity.durationVideos, equals(32));

    expect(entity.modules.length, equals(3));
    expect(entity.modules[0].name, contains('Introdução'));
    expect(entity.modules[1].order, equals(2));
  });
}

