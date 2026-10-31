import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class UploadOfflineCollectionUsecase
    extends
        UseCase<
          UploadOfflineCollectionResponseModal,
          UploadOfflineCollectionRequestModal
        > {
  final AppRepository appRepository;

  UploadOfflineCollectionUsecase(this.appRepository);

  @override
  Future<UploadOfflineCollectionResponseModal> call(
    UploadOfflineCollectionRequestModal params,
  ) {
    return appRepository.uploadOfflineCollection(params);
  }
}
