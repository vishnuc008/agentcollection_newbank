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

abstract class AppRepository {
  Future<LoginResponseModel> login(LoginRequestModel requestModel);
  Future<AccountResponseModel> account(AccountRequestModel requestModel);
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
  Future<UploadOfflineCollectionResponseModal> uploadOfflineCollection(
    UploadOfflineCollectionRequestModal requestModel,
  );
}
