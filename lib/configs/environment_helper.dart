abstract interface class IEnvironmentHelper {
  String? get urlBase; // adicione aqui
  String? get urlAuthentication;
  String? get urlRegister;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => 'https://36d2-2804-f84-4-c568-5a0-e9cf-3839-dc56.ngrok-free.app';

  @override
  String? get urlBase => _urlBase;
  
  @override
  String? get urlAuthentication => '$_urlBase/auth/login';

  @override
  String? get urlRegister => '$_urlBase/auth/register';
}
