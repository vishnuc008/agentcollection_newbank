import 'package:get_storage/get_storage.dart';

class AppRemoteRoutes {
  //  static String baseUrl =  GetStorage().read("BASE_URL") ?? "http://135.235.152.214:8002/";
  static String baseUrl =
      GetStorage().read("BASE_URL") ?? "http://61.2.215.14:8002/";
  static const login = "agent/validate";
  static const report = "agent/report";
  static const products = "agent/products";
  static const accounts = "agent/accounts";
  static const sessionClose = "agent/sessionClose";
  static const sessionOpen = "agent/sessionOpen";
  static const collection = "agent/collection";
  static const total = "agent/total";
  static const passbook = "agent/passbook";
  static const changePassword = "agent/changePassword";
  static const uploadOfflineCollection = "agent/bulkCollection";
}
