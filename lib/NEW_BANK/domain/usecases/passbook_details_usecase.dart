import 'dart:io';

import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class PassbookDetailsUsecase
    extends UseCase<PassbookDetailsResponseModal, PassbookDetailsRequestModal> {
  final AppRepository appRepository;

  PassbookDetailsUsecase(this.appRepository);

  @override
  Future<PassbookDetailsResponseModal> call(
    PassbookDetailsRequestModal params,
  ) {
    return appRepository.passbookDetails(params);
  }
}
