import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class SessionOpenUsecase
    extends UseCase<SessionOpenResponseModel, SessionOpenRequestModel> {
  final AppRepository appRepository;

  SessionOpenUsecase(this.appRepository);

  @override
  Future<SessionOpenResponseModel> call(SessionOpenRequestModel params) {
    return appRepository.sessionopen(params);
  }
}
