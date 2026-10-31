import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class AccountUsecase
    extends UseCase<AccountResponseModel, AccountRequestModel> {
  final AppRepository appRepository;

  AccountUsecase(this.appRepository);

  @override
  Future<AccountResponseModel> call(AccountRequestModel params) {
    return appRepository.account(params);
  }
}
