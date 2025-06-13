abstract interface class IEnvironmentHelper {
  String? get urlAuthentication;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => '';

  @override
  String? get urlAuthentication => '$_urlBase/auth/login';
}