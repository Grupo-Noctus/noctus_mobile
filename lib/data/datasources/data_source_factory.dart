import 'package:noctus_mobile/configs/environment_helper.dart';
import 'package:noctus_mobile/configs/injection_container.dart';
import 'package:noctus_mobile/data/datasources/data_source.dart';
import 'package:noctus_mobile/data/datasources/non_relational_datasource.dart';
import 'package:noctus_mobile/data/datasources/relational_datasource.dart';
import 'package:noctus_mobile/data/datasources/remote_datasource.dart';
import 'package:noctus_mobile/core/service/clock_helper.dart';
import 'package:noctus_mobile/core/service/http_service.dart';
import 'package:noctus_mobile/core/service/storage_service.dart';

final class NonRelationalFactoryDataSource {
  INonRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return NonRelationalDataSource(
      storageService,
      clockHelper,
    );
  }
}

final class RelationalFactoryDataSource {
  IRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return RelationalDataSource(
      storageService, 
      clockHelper,
    );
  }
}

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    final IClockHelper clockHelper = ClockHelper();
    return RemoteDataSource(
      httpService, 
      environmentHelper, 
      clockHelper,
    );
  }
}