import 'package:flutter_test/flutter_test.dart';
import 'package:noctus_mobile/domain/entities/course/course_entity.dart';

import '../../../fixture/library/fixture_helper.dart';

void main() {
  test('should parse CourseEntity correctly from remote map', () {
    final map = FixtureHelper.fetchCourseAdminRemoteMap();
    final Map<String, dynamic> courseMap = (map['courses'] as List).first;
    final CourseEntity entity = CourseEntity.fromRemoteMap(courseMap);

    expect(entity.id, equals(1));
    expect(entity.name, equals("Curso Introdutório ao Docker"));
    expect(entity.modules, isA<List>());
    expect(entity.modules.length, equals(1));
    expect(entity.modules.first.name, contains("Introdução"));
    expect(entity.modules.first.videos.length, equals(1));
  });
}
