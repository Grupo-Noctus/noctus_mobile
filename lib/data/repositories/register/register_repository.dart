import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/library/extensions.dart';
import 'package:noctus_mobile/domain/entities/core/http_response_entity.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';

abstract interface class IRegisterRepository {
  Future<bool> registerUser(RegisterEntity registerEntity);
}

final class RegisterRepository implements IRegisterRepository {
  final IRemoteDataSource _remoteDataSource;

  const RegisterRepository(this._remoteDataSource);

  @override
  Future<bool> registerUser(RegisterEntity registerEntity) async {
    final HttpResponseEntity? httpResponse = await _remoteDataSource.post(
      _urlAuthentication,
      await registerEntity.toFormData(),
    );

    if (httpResponse.toBool()) {
      final data = httpResponse!.data;
      if (data is String) {
        return data.toLowerCase() == 'true';
      }
    }
    return false;
  }

  String get _urlAuthentication => _remoteDataSource.environment?.urlRegister ?? '';
}
