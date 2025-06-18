import 'package:flutter_test/flutter_test.dart';
import 'package:noctus_mobile/domain/entities/logged/logged_entity.dart';
import 'package:noctus_mobile/domain/entities/logged/user_logged.dart';

import '../../../fixture/library/fixture_helper.dart';

void main() {
  test('should validate the UserLoggedEntity', () {
    final Map<String, dynamic> userMap = FixtureHelper.fetchUserLoggedRemoteMap();

    final LoggedEntity loggedEntity = LoggedEntity.fromRemoteMap(userMap);
    final UserLoggedEntity user = loggedEntity.user;

    expect(user.id, isA<int>());
    expect(user.name, isA<String>());
    expect(user.username, isA<String>());
    expect(user.image, isA<String?>());
    expect(user.role, isA<String>());
    expect(user.active, isA<bool>());
  });
}
