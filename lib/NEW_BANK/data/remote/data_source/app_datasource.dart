import 'package:agentcollection_newbank/NEW_BANK/core/api_provider.dart';
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
import 'package:agentcollection_newbank/NEW_BANK/data/remote/remote_routes/app_remote_routes.dart';

abstract class AppDataSource {
  final ApiProvider apiProvider;

  AppDataSource(this.apiProvider);

  Future<LoginResponseModel> login(LoginRequestModel requestModel);
  Future<AccountResponseModel> accounts(AccountRequestModel requestModel);
  Future<CollectionResponseModal> collection(
    CollectionRequestModal requestModel,
  );
  Future<ProductResponseModel> product(ProductRequestModel requestModel);
  Future<ReportResponseModel> report(ReportRequestModel requestModel);
  Future<SessionCloseResponseModel> sessionclose(
    SessionCloseRequestModel requestModel,
  );
  Future<SessionOpenResponseModel> sessionopen(
    SessionOpenRequestModel requestModel,
  );
  Future<TotalResponseModel> total(TotalRequestModel requestModel);
  Future<PassbookDetailsResponseModal> passbookDetails(
    PassbookDetailsRequestModal requestModel,
  );
  Future<ChangePasswordResponseModal> changePass(
    ChangePasswordRequestModal requestModel,
  );
  Future<UploadOfflineCollectionResponseModal> uploadofflineCollection(
    UploadOfflineCollectionRequestModal requestModel,
  );
}

class AppDataSourceImpl extends AppDataSource {
  AppDataSourceImpl(super.apiProvider);

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    return LoginResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.login, requestModel),
    );
  }

  @override
  Future<AccountResponseModel> accounts(
    AccountRequestModel requestModel,
  ) async {
    return AccountResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.accounts, requestModel),
    );
  }

  @override
  Future<CollectionResponseModal> collection(
    CollectionRequestModal requestModel,
  ) async {
    return CollectionResponseModal.fromJson(
      await apiProvider.post(AppRemoteRoutes.collection, requestModel),
    );
  }

  @override
  Future<ProductResponseModel> product(ProductRequestModel requestModel) async {
    return ProductResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.products, requestModel),
    );
  }

  @override
  Future<ReportResponseModel> report(ReportRequestModel requestModel) async {
    return ReportResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.report, requestModel),
    );
  }

  @override
  Future<SessionCloseResponseModel> sessionclose(
    SessionCloseRequestModel requestModel,
  ) async {
    return SessionCloseResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.sessionClose, requestModel),
    );
  }

  @override
  Future<SessionOpenResponseModel> sessionopen(
    SessionOpenRequestModel requestModel,
  ) async {
    return SessionOpenResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.sessionOpen, requestModel),
    );
  }

  @override
  Future<TotalResponseModel> total(TotalRequestModel requestModel) async {
    return TotalResponseModel.fromJson(
      await apiProvider.post(AppRemoteRoutes.total, requestModel),
    );
  }

  @override
  Future<PassbookDetailsResponseModal> passbookDetails(
    PassbookDetailsRequestModal requestModel,
  ) async {
    return PassbookDetailsResponseModal.fromJson(
      await apiProvider.post(AppRemoteRoutes.passbook, requestModel),
    );
  }

  @override
  Future<ChangePasswordResponseModal> changePass(
    ChangePasswordRequestModal requestModel,
  ) async {
    return ChangePasswordResponseModal.fromJson(
      await apiProvider.post(AppRemoteRoutes.changePassword, requestModel),
    );
  }

  @override
  Future<UploadOfflineCollectionResponseModal> uploadofflineCollection(
    UploadOfflineCollectionRequestModal requestModel,
  ) async {
    return UploadOfflineCollectionResponseModal.fromJson(
      await apiProvider.post(
        AppRemoteRoutes.uploadOfflineCollection,
        requestModel,
      ),
    );
  }
}
