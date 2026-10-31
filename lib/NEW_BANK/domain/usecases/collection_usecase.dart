import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class CollectionUsecase
    extends UseCase<CollectionResponseModal, CollectionRequestModal> {
  final AppRepository appRepository;

  CollectionUsecase(this.appRepository);

  @override
  Future<CollectionResponseModal> call(CollectionRequestModal params) {
    return appRepository.collection(params);
  }
}
