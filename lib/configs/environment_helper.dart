abstract interface class IEnvironmentHelper {
  String? get urlAuthentication;
  String? get urlRegister;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => '';

  @override
  String? get urlAuthentication => '$_urlBase/auth/login';

  @override
  String? get urlRegister => '$_urlBase/auth/register';
}