import 'package:agentcollection_newbank/NEW_BANK/core/api_provider.dart';
import 'package:agentcollection_newbank/NEW_BANK/core/connection_checker.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/data_source/app_datasource.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/repositories/app_repository_impl.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/account_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/change_password_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/collection_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/login_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/passbook_details_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/product_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/report_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/session_close_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/session_open_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/total_collection_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/upload_offline_collection_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> setUp() async {
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(sl()),
  );
  sl.registerLazySingleton<AppDataSource>(() => AppDataSourceImpl(sl()));
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<TotalCollectionUsecase>(
    () => TotalCollectionUsecase(sl()),
  );
  sl.registerLazySingleton<AccountUsecase>(() => AccountUsecase(sl()));
  sl.registerLazySingleton<CollectionUsecase>(() => CollectionUsecase(sl()));
  sl.registerLazySingleton<ProductUsecase>(() => ProductUsecase(sl()));
  sl.registerLazySingleton<ReportUsecase>(() => ReportUsecase(sl()));
  sl.registerLazySingleton<SessionCloseUsecase>(
    () => SessionCloseUsecase(sl()),
  );
  sl.registerLazySingleton<SessionOpenUsecase>(() => SessionOpenUsecase(sl()));
  sl.registerLazySingleton<PassbookDetailsUsecase>(
    () => PassbookDetailsUsecase(sl()),
  );
  sl.registerLazySingleton<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(sl()),
  );
  sl.registerLazySingleton<UploadOfflineCollectionUsecase>(
    () => UploadOfflineCollectionUsecase(sl()),
  );
}
