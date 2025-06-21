import 'package:agentcollection_newbank/NEW_BANK/core/api_provider.dart';
import 'package:agentcollection_newbank/NEW_BANK/core/connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> setUp() async {
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(sl()),
  );
}
