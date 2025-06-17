import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/data/repositories/register/login_repository.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';

final class RegisterFactoryViewmodel implements IFactoryViewModel<RegisterViewModel> {
  @override
  RegisterViewModel create(BuildContext context, {RegisterEntity? registerEntity}) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final INonRelationalDataSource nonRelationalDataSource = NonRelationalFactoryDataSource().create();

    final IRegisterRepository registerRepository = RegisterRepository(remoteDataSource);
    final ILoginRepository loginRepository = LoginRepository(remoteDataSource, nonRelationalDataSource);

    final viewModel = RegisterViewModel(registerRepository, loginRepository);

    if (registerEntity != null) {
      viewModel.initRegister(registerEntity);
    }
    return viewModel;
  }

  @override
  void dispose(BuildContext context, RegisterViewModel viewModel) {
    viewModel.close();
  }
}

