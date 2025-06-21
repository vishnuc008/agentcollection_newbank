import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardCntrlBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> DashboardController());
  }

}