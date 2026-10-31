import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class SessionCloseUsecase
    extends UseCase<SessionCloseResponseModel, SessionCloseRequestModel> {
  final AppRepository appRepository;

  SessionCloseUsecase(this.appRepository);

  @override
  Future<SessionCloseResponseModel> call(SessionCloseRequestModel params) {
    return appRepository.sessionclose(params);
  }
}
