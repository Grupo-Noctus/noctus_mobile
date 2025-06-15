import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:noctus_mobile/configs/environment_helper.dart';
export 'package:noctus_mobile/configs/injection_container.dart';
export 'package:noctus_mobile/data/datasources/data_source.dart';
export 'package:noctus_mobile/data/datasources/non_relational_datasource.dart';
export 'package:noctus_mobile/data/datasources/relational_datasource.dart';
export 'package:noctus_mobile/core/service/app_service.dart';
export 'package:noctus_mobile/core/service/clock_helper.dart';
export 'package:noctus_mobile/core/service/storage_service.dart';

abstract interface class IFactoryViewModel<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T viewModel);
}