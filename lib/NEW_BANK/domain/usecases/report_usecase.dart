import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class ReportUsecase extends UseCase<ReportResponseModel, ReportRequestModel> {
  final AppRepository appRepository;

  ReportUsecase(this.appRepository);

  @override
  Future<ReportResponseModel> call(ReportRequestModel params) {
    return appRepository.report(params);
  }
}
