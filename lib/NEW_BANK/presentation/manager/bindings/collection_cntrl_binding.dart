import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:get/get.dart';

class CollectionCntrlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionController());
  }
}
