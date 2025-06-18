import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/repositories/login/login_repository.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';
import 'package:noctus_mobile/domain/entities/logged/logged_entity.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';
import 'dart:convert';

import '../../../fixture/library/fixture_helper.dart';
import '../../../fixture/library/mocks.dart';

void main() {
  late IRemoteDataSource remoteDataSource;
  late INonRelationalDataSource nonRelationalDataSource;
  late IEnvironmentHelper environmentHelper;
  late LoginRepository loginRepository;
  late LoginEntity loginEntity;
  late LoggedEntity loggedEntity;
  late Map<String, dynamic> loggedMap;
  late String url;

  setUpAll(() {
    remoteDataSource = MockRemoteDataSource();
    nonRelationalDataSource = MockNonRelationalDataSource();
    environmentHelper = MockEnvironment();
    loginEntity = FixtureHelper.fetchLogin();
    loggedEntity = FixtureHelper.fetchUserLogged();
    loggedMap = FixtureHelper.fetchUserLoggedRemoteMap();
    url = FixtureHelper.url;

    loginRepository = LoginRepository(remoteDataSource, nonRelationalDataSource);
  });

  group('authenticationAsync', () {
    test('returns LoggedEntity and saves token and user on success', () async {
      // Arrange
      when(remoteDataSource.environment).thenReturn(environmentHelper);
      when(environmentHelper.urlAuthentication).thenReturn(url);
      when(remoteDataSource.post(
        url,
        jsonEncode(loginEntity.toMap()),
      )).thenAnswer((_) async => HttpResponseEntity(statusCode: 200, data: loggedMap));
      when(nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserToken,
        loggedEntity.accessToken,
      )).thenAnswer((_) async => true);
      when(nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserLogged,
        jsonEncode(loggedEntity.user.toMap()),
      )).thenAnswer((_) async => true);

      // Act
      final result = await loginRepository.authenticationAsync(loginEntity);

      // Assert
      expect(result, isNotNull);
      expect(result!.accessToken, equals(loggedEntity.accessToken));
      expect(result.user.id, equals(loggedEntity.user.id));

      verify(remoteDataSource.environment).called(1);
      verify(environmentHelper.urlAuthentication).called(1);
      verify(remoteDataSource.post(url, jsonEncode(loginEntity.toMap()))).called(1);
      verify(nonRelationalDataSource.saveString(DataBaseNoSqlSchemaHelper.kUserToken, loggedEntity.accessToken)).called(1);
      verify(nonRelationalDataSource.saveString(DataBaseNoSqlSchemaHelper.kUserLogged, jsonEncode(loggedEntity.user.toMap()))).called(1);

      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(environmentHelper);
      verifyNoMoreInteractions(nonRelationalDataSource);
    });

    test('returns null when remote data source returns null', () async {
      // Arrange
      when(remoteDataSource.environment).thenReturn(environmentHelper);
      when(environmentHelper.urlAuthentication).thenReturn(url);
      when(remoteDataSource.post(
        url,
        jsonEncode(loginEntity.toMap()),
      )).thenAnswer((_) => Future<HttpResponseEntity?>.value(null)); // Retornando explicitamente Future com null

      // Act
      final result = await loginRepository.authenticationAsync(loginEntity);

      // Assert
      expect(result, isNull);

      verify(remoteDataSource.environment).called(1);
      verify(environmentHelper.urlAuthentication).called(1);
      verify(remoteDataSource.post(url, jsonEncode(loginEntity.toMap()))).called(1);

      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(environmentHelper);
      verifyNoMoreInteractions(nonRelationalDataSource);
    });

    test('returns null when response data is invalid', () async {
      // Arrange
      final invalidResponse = {'foo': 'bar'};
      when(remoteDataSource.environment).thenReturn(environmentHelper);
      when(environmentHelper.urlAuthentication).thenReturn(url);
      when(remoteDataSource.post(
        url,
        jsonEncode(loginEntity.toMap()),
      )).thenAnswer((_) async => HttpResponseEntity(statusCode: 200, data: invalidResponse));

      // Act
      final result = await loginRepository.authenticationAsync(loginEntity);

      // Assert
      expect(result, isNull);

      verify(remoteDataSource.environment).called(1);
      verify(environmentHelper.urlAuthentication).called(1);
      verify(remoteDataSource.post(url, jsonEncode(loginEntity.toMap()))).called(1);

      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(environmentHelper);
      verifyNoMoreInteractions(nonRelationalDataSource);
    });

    test('returns null when saving token fails', () async {
      // Arrange
      when(remoteDataSource.environment).thenReturn(environmentHelper);
      when(environmentHelper.urlAuthentication).thenReturn(url);
      when(remoteDataSource.post(
        url,
        jsonEncode(loginEntity.toMap()),
      )).thenAnswer((_) async => HttpResponseEntity(statusCode: 200, data: loggedMap));
      when(nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserToken,
        loggedEntity.accessToken,
      )).thenAnswer((_) async => false); // Falha no save
      when(nonRelationalDataSource.saveString(
        DataBaseNoSqlSchemaHelper.kUserLogged,
        jsonEncode(loggedEntity.user.toMap()),
      )).thenAnswer((_) async => true);

      // Act
      final result = await loginRepository.authenticationAsync(loginEntity);

      // Assert
      expect(result, isNull);

      verify(remoteDataSource.environment).called(1);
      verify(environmentHelper.urlAuthentication).called(1);
      verify(remoteDataSource.post(url, jsonEncode(loginEntity.toMap()))).called(1);
      verify(nonRelationalDataSource.saveString(DataBaseNoSqlSchemaHelper.kUserToken, loggedEntity.accessToken)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(environmentHelper);
      verifyNoMoreInteractions(nonRelationalDataSource);
    });
  });
}
