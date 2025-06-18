import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/ui/redirect/view_models/splash_view_model.dart';

final class SplashFactoryViewModel implements IFactoryViewModel<SplashViewmodel> {
  @override
  SplashViewmodel create(BuildContext context, {dynamic params}) {
    final INonRelationalDataSource nonRelationalDataSource =
        NonRelationalFactoryDataSource().create();

    return SplashViewmodel(nonRelationalDataSource);
  }

  @override
  void dispose(BuildContext context, SplashViewmodel viewModel) {
    viewModel.close();
  }
}
