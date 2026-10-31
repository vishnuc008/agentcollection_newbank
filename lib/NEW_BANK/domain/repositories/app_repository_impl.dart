import 'package:agentcollection_newbank/NEW_BANK/data/remote/data_source/app_datasource.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final AppDataSource appDataSource;

  AppRepositoryImpl(this.appDataSource);

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) {
    return appDataSource.login(requestModel);
  }

  @override
  Future<AccountResponseModel> account(AccountRequestModel requestModel) {
    return appDataSource.accounts(requestModel);
  }

  @override
  Future<CollectionResponseModal> collection(
    CollectionRequestModal requestModel,
  ) {
    return appDataSource.collection(requestModel);
  }

  @override
  Future<ProductResponseModel> product(ProductRequestModel requestModel) {
    return appDataSource.product(requestModel);
  }

  @override
  Future<ReportResponseModel> report(ReportRequestModel requestModel) {
    return appDataSource.report(requestModel);
  }

  @override
  Future<SessionCloseResponseModel> sessionclose(
    SessionCloseRequestModel requestModel,
  ) {
    return appDataSource.sessionclose(requestModel);
  }

  @override
  Future<SessionOpenResponseModel> sessionopen(
    SessionOpenRequestModel requestModel,
  ) {
    return appDataSource.sessionopen(requestModel);
  }

  @override
  Future<TotalResponseModel> total(TotalRequestModel requestModel) {
    return appDataSource.total(requestModel);
  }

  @override
  Future<PassbookDetailsResponseModal> passbookDetails(
    PassbookDetailsRequestModal requestModel,
  ) {
    return appDataSource.passbookDetails(requestModel);
  }

  @override
  Future<ChangePasswordResponseModal> changePass(
    ChangePasswordRequestModal requestModel,
  ) {
    return appDataSource.changePass(requestModel);
  }

  @override
  Future<UploadOfflineCollectionResponseModal> uploadOfflineCollection(
    UploadOfflineCollectionRequestModal requestModel,
  ) {
    return appDataSource.uploadofflineCollection(requestModel);
  }
}
