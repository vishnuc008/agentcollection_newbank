import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class LoginUsecase extends UseCase<LoginResponseModel, LoginRequestModel> {
  final AppRepository appRepository;

  LoginUsecase(this.appRepository);

  @override
  Future<LoginResponseModel> call(LoginRequestModel params) {
    return appRepository.login(params);
  }
}
