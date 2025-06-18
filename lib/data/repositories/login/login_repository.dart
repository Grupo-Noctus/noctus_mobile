import 'dart:convert';

import 'package:noctus_mobile/configs/data_base_schema_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/library/extensions.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';
import 'package:noctus_mobile/domain/entities/logged/logged_entity.dart';
import 'package:noctus_mobile/domain/entities/logged/user_logged.dart';
import 'package:noctus_mobile/domain/entities/login/login_entity.dart';

abstract interface class ILoginRepository {
  Future<LoggedEntity?> authenticationAsync(LoginEntity login);
}

final class LoginRepository implements ILoginRepository {
  final IRemoteDataSource _remoteDataSource;
  final INonRelationalDataSource _nonRelationalDataSource;

  const LoginRepository(this._remoteDataSource, this._nonRelationalDataSource);

  @override
  Future<LoggedEntity?> authenticationAsync(LoginEntity login) async {
    final HttpResponseEntity? httpResponse = await _remoteDataSource.post(
      _urlAuthentication,
      jsonEncode(login.toMap()),
    );

    if (!(httpResponse?.toBool() ?? false)) {
      return null;
    }

    final data = httpResponse!.data;

    if (data is Map<String, dynamic> &&
        data.containsKey('access_token') &&
        data['access_token'] is String &&
        data.containsKey('payload')) {
      
      final logged = LoggedEntity.fromMap(data);

      await _saveTokenAsync(logged.accessToken);
      await _saveUserLoggedAsync(logged.user);

      return logged;
    }

    return null;
  }

  Future<bool> _saveTokenAsync(String token) {
    return _nonRelationalDataSource.saveString(
      DataBaseNoSqlSchemaHelper.kUserToken,
      token,
    )!;
  }

  Future<bool> _saveUserLoggedAsync(UserLoggedEntity user) {
    final String jsonUser = jsonEncode(user.toMap());
    return _nonRelationalDataSource.saveString(
      DataBaseNoSqlSchemaHelper.kUserLogged,
      jsonUser,
    )!;
  }

  String get _urlAuthentication => _remoteDataSource.environment?.urlAuthentication ?? '';
}
