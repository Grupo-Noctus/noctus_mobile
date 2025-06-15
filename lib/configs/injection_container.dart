import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:noctus_mobile/configs/environment_helper.dart';
import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/core/service/app_service.dart';
import 'package:noctus_mobile/core/service/migrate_service.dart';
import 'package:noctus_mobile/core/service/storage_service.dart';
import 'package:noctus_mobile/data/datasources/remote_datasource.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  /// #region EnvironmentHelper
  final IEnvironmentHelper environmentHelper = EnvironmentHelper();
  getIt.registerSingleton<IEnvironmentHelper>(environmentHelper);

  /// #region AppService
  getIt.registerSingleton<IAppService>(AppService(GlobalKey<NavigatorState>()));

  /// #region StorageService
  getIt.registerSingleton<IStorageService>(StorageService(MigrateService(), await SharedPreferences.getInstance()));
}