abstract interface class IEnvironmentHelper {
  String? get urlBase; // adicione aqui
  String? get urlAuthentication;
  String? get urlRegister;
  String? get urlCoursesAdmin;
  String? get urlCoursesEnrolled;
  String? get urlCoursesPreview;
  String? get urlUploadBase;
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


  @override
  String get urlCoursesAdmin => '$_urlBase/course/admin/find-many';

  @override
  String get urlCoursesEnrolled => '$_urlBase/enrollment-course/find-many';

  @override
  String get urlCoursesPreview => '$_urlBase/course/preview';

  
  @override
  String? get urlUploadBase => '$_urlBase/uploads/';
}
