abstract interface class IRegisterException implements Exception {}

final class RegisterInvalid implements IRegisterException {}

final class UsernameInvalidException implements IRegisterException {}

final class EmailInvalidException implements IRegisterException {}

final class PasswordInvalidException implements IRegisterException {}

final class PhoneNumberInvalidException implements IRegisterException {}