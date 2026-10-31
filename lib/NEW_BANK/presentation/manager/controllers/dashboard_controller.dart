import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionclose.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/total.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/entities/dashboard_modal.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/session_close_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/total_collection_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/login_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/LocalStorageNames.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_alert_dialogue.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  DashboardController(this.totalCollectionUsecase, this.sessionCloseUsecase);

  final List<DashboardModal> dashList = [
    DashboardModal("Collection", AppAssets.collection, (
      BuildContext context,
    ) async {
      String? isDataDownload = await SecureStorage.read(
        LocalStorageKeys.downloadData,
      );
      if (isDataDownload == "true") {
        context.go(AppPages.collection);
      } else {
        bottomMsg(
          context,
          "Failed",
          "Please download data before opening Collection.",
          false,
        );
      }
    }),
    DashboardModal("Report", AppAssets.report, (BuildContext context) {
      context.go(AppPages.report);
    }),
    DashboardModal("Change Password", AppAssets.changePass, (
      BuildContext context,
    ) {
      context.go(AppPages.changepasswordpage);
    }),
    DashboardModal("Logout", AppAssets.logout, (BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with icon
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Icon container
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.logout_rounded,
                            size: 32,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          "Logout?",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          "Are you sure you want to logout?",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "You'll need to login again to access your account.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  const Divider(height: 1, thickness: 1),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Logout button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              // final dashboardController =
                              //       Provider.of<DashboardController>(
                              //         context,
                              //         listen: false,
                              //       );
                              //   await dashboardController.getSessionClose(
                              //     context,
                              //   );
                              final loginController =
                                  Provider.of<LoginController>(
                                    context,
                                    listen: false,
                                  );
                              loginController.userNameController.clear();
                              loginController.passwordController.clear();
                              Navigator.of(context).pop();
                              context.go(AppPages.login);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.logout_rounded, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "Logout",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }),
  ];

  final TotalCollectionUsecase totalCollectionUsecase;
  final SessionCloseUsecase sessionCloseUsecase;

  double totalAmount = 0.0; // total collection
  final List<TotalData> totalCollectionList = [];

  ResponseClassify<TotalResponseModel> totalCollectionState =
      ResponseClassify<TotalResponseModel>.error("");

  ResponseClassify<SessionCloseResponseModel> sessionCloseState =
      ResponseClassify<SessionCloseResponseModel>.error("");

  final List<AmountData> sessionCloseList = [];

  // ---------------- Get Total Collection from api----------------
  Future<void> getTotalCollection() async {
    totalCollectionState = ResponseClassify.loading();
    notifyListeners();

    try {
      String? agentId = await SecureStorage.read(LocalStorageKeys.agentID);
      String? sessionId = await SecureStorage.read(LocalStorageKeys.sessionID);

      if (agentId == null || sessionId == null) return;

      totalCollectionState = ResponseClassify.completed(
        await totalCollectionUsecase.call(
          TotalRequestModel(
            agentId: int.parse(agentId),
            sessionId: int.parse(sessionId),
          ),
        ),
      );

      totalCollectionList.clear();
      totalCollectionList.addAll(totalCollectionState.data!.data);

      if (totalCollectionList.isNotEmpty) {
        totalAmount = totalCollectionList.first.amount;
      }

      successPrint("Total collection fetched: $totalAmount");
      notifyListeners();
    } catch (e) {
      totalCollectionState = ResponseClassify.error("$e");
      alertPrint("Failed to fetch total collection: $e");
      notifyListeners();
    }
  }

  // ---------------- Session Close ----------------
  Future<void> getSessionClose(BuildContext context) async {
    sessionCloseState = ResponseClassify.loading();
    notifyListeners();

    try {
      String? agentId = await SecureStorage.read(LocalStorageKeys.agentID);
      String? sessionId = await SecureStorage.read(LocalStorageKeys.sessionID);

      if (agentId == null || sessionId == null) return;

      sessionCloseState = ResponseClassify.completed(
        await sessionCloseUsecase.call(
          SessionCloseRequestModel(agentId: agentId, sessionId: sessionId),
        ),
      );

      sessionCloseList.clear();
      sessionCloseList.addAll(sessionCloseState.data!.data);

      // Reset download flag and clear Hive
      await SecureStorage.write(LocalStorageKeys.downloadData, "false");
      await SecureStorage.delete(LocalStorageKeys.sessionID);
      var sessionBox = await Hive.openBox('sessionBox');
      await sessionBox.put('SessionID', 0);
      var box = await Hive.openBox<LoanCollection>('loanCollection');

      await box.clear();

      // Reset total collection
      totalAmount = 0.0;
      totalCollectionList.clear();
      final reportController = Provider.of<ReportController>(
        context,
        listen: false,
      );
      reportController.clearLocalData();

      successPrint("Download flag reset, Hive cleared, totalAmount reset");
      notifyListeners();

      bottomMsg(context, "Success", "Session Closed", true);
    } catch (e) {
      sessionCloseState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "Session Not Closed", false);
      notifyListeners();
    }
  }
}
