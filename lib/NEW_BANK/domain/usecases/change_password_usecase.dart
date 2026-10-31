import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class ChangePasswordUsecase
    extends UseCase<ChangePasswordResponseModal, ChangePasswordRequestModal> {
  final AppRepository appRepository;

  ChangePasswordUsecase(this.appRepository);

  @override
  Future<ChangePasswordResponseModal> call(ChangePasswordRequestModal params) {
    return appRepository.changePass(params);
  }
}
