import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class TotalCollectionUsecase
    extends UseCase<TotalResponseModel, TotalRequestModel> {
  final AppRepository appRepository;

  TotalCollectionUsecase(this.appRepository);

  @override
  Future<TotalResponseModel> call(TotalRequestModel params) {
    return appRepository.total(params);
  }
}
