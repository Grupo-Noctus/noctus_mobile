import 'package:mockito/mockito.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/service/http_service.dart';

final class MockRelationalDataSource extends Mock implements IRelationalDataSource {}

final class MockEnvironment extends Mock implements IEnvironmentHelper {}

final class MockRemoteDataSource extends Mock implements IRemoteDataSource {}

final class MockNonRelationalDataSource extends Mock implements INonRelationalDataSource {}

final class MockHttpService extends Mock implements IHttpService {}

final class MockStorageService extends Mock implements IStorageService {}

final class MockAppService extends Mock implements IAppService {}

final class MockClockHelper extends Mock implements IClockHelper {}