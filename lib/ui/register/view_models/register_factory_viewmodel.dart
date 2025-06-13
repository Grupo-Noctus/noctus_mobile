import 'package:noctus_mobile/configs/factory_viewmodel.dart';
import 'package:noctus_mobile/data/datasources/data_source_factory.dart';
import 'package:noctus_mobile/data/repositories/register/register_repository.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';

final class RegisterFactoryViewmodel implements IFactoryViewModel<RegisterViewModel>{
  @override
  RegisterViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final IRegisterRepository registerRepository = RegisterRepository(remoteDataSource);
    return RegisterViewModel(registerRepository);
  }

  @override
  void dispose(BuildContext context, RegisterViewModel viewModel) {
    viewModel.close();
  }
}