import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/data/repositories/register/login_repository.dart';
import 'package:noctus_mobile/ui/login/view_models/login_view_model.dart';

final class LoginFactoryViewModel implements IFactoryViewModel<LoginViewModel> {
  @override
  LoginViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final INonRelationalDataSource nonRelationalDataSource = NonRelationalFactoryDataSource().create();
    final ILoginRepository loginRepository = LoginRepository(remoteDataSource, nonRelationalDataSource);
    return LoginViewModel(loginRepository);
  }

  @override
  void dispose(BuildContext context, LoginViewModel viewModel) {
    viewModel.close();
  }
}