import 'package:agentcollection_newbank/NEW_BANK/domain/entities/dashboard_modal.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_alert_dialogue.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final List<DashboardModal> dashList = [
    DashboardModal("Collection", AppAssets.collection, () {
      Get.toNamed(AppPages.collection);
    }),
    DashboardModal("Report", AppAssets.report, () {
      Get.toNamed(AppPages.report);
    }),
    DashboardModal("Logout", AppAssets.logout, () {
         customAlertDialogue(
        title: "Are You Sure!",
        content: "You Want To Exit?",
        txtbuttonName1: "No",
        txtbutton1Action: () {
          Get.close(1);
        },
        txtbuttonName2: "Yes",
        txtbutton2Action: () {
          Get.offAllNamed(AppPages.login);
        },
      );
    }),
  ];
}
