import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_gradient_widget.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/cutome_label_dropdown.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();

    // 🔒 Lock landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // 🔓 Restore portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportController = Provider.of<ReportController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + h * 0.05,
            backgroundColor: AppColors.maincolor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                reportController.clearLocalData();
                context.go(AppPages.dashboard);
              },
            ),
            title: Text(
              "Offline Report",
              style: GoogleFonts.poppins(
                fontSize: w * 0.033,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.03,
                vertical: h * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔽 PRODUCT + SHOW BUTTON
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: LabelWithDropDownField<ProductData>(
                          onBeforePopupOpening: (p0) async {
                            await reportController.getOfflineProducts();
                            return true;
                          },
                          textDropDownLabel: "Select Product",
                          itemAsString: (p0) => p0.productType,
                          items: (p0, p1) => reportController.productList,
                          onChanged: (value) {
                            reportController.selectedProductt.value = value;
                            reportController.reportSearchController.clear();
                            reportController.reportList.clear();
                            reportController.notifyListeners();
                          },
                        ),
                      ),
                      SizedBox(width: w * 0.03),
                      Expanded(
                        flex: 1,
                        child:
                            reportController.reportState.status ==
                                    Status.LOADING
                                ? Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                        color: Theme.of(context).primaryColor,
                                        size: h * 0.04,
                                      ),
                                )
                                : Padding(
                                  padding: EdgeInsets.only(top: h * 0.05),
                                  child: SizedBox(
                                    height: h * 0.13,
                                    width: w * 0.2,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (reportController
                                                .selectedProductt
                                                .value ==
                                            null) {
                                          bottomMsg(
                                            context,
                                            "Failed",
                                            "Please select product",
                                            false,
                                          );
                                          return;
                                        }

                                        await reportController.getOfflineReport(
                                          productType:
                                              reportController
                                                  .selectedProductt
                                                  .value!
                                                  .productType,
                                        );

                                        if (reportController
                                            .reportList
                                            .isEmpty) {
                                          bottomMsg(
                                            context,
                                            "No Data",
                                            "No offline report available",
                                            false,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.maincolor
                                            .withOpacity(0.8),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: Text(
                                        "Show",
                                        style: GoogleFonts.poppins(
                                          fontSize: w * 0.032,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🔽 SEARCH
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 2,
                  //       child: CustomTextField(
                  //         prefix: Icon(Iconsax.user_search),
                  //         showPrefixIcon: true,
                  //         hintText: "Search Member No/Name",
                  //         onChanged: (value) {
                  //           reportController.filterOfflineReport(value);
                  //         },
                  //       ),
                  //     ),
                  //     // Expanded(
                  //     //   flex: 3,
                  //     //   child: Padding(
                  //     //     padding: EdgeInsets.only(
                  //     //       right: w * 0.35,
                  //     //       left: w * 0.02,
                  //     //     ),
                  //     //     child: SizedBox(
                  //     //       height: h * 0.13,
                  //     //       width: w * 0.2,
                  //     //       child: ElevatedButton(
                  //     //         onPressed: () async {},
                  //     //         style: ElevatedButton.styleFrom(
                  //     //           backgroundColor: AppColors.maincolor
                  //     //               .withOpacity(0.8),
                  //     //           foregroundColor: Colors.white,
                  //     //           shape: RoundedRectangleBorder(
                  //     //             borderRadius: BorderRadius.circular(12),
                  //     //           ),
                  //     //           elevation: 2,
                  //     //         ),
                  //     //         child: Text(
                  //     //           "Search",
                  //     //           style: GoogleFonts.poppins(
                  //     //             fontSize: w * 0.032,
                  //     //             fontWeight: FontWeight.w500,
                  //     //             color: Colors.white,
                  //     //           ),
                  //     //         ),
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     Expanded(flex: 3, child: SizedBox.shrink()),
                  //   ],
                  // ),

                  // SizedBox(height: h * 0.04),

                  /// 🔽 SEARCH (show only when table is visible)
                  if (reportController.reportList.isNotEmpty) ...[
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            prefix: const Icon(Iconsax.user_search),
                            showPrefixIcon: true,
                            hintText: "Search Member No/Name",
                            onChanged: (value) {
                              reportController.filterOfflineReport(value);
                            },
                          ),
                        ),
                        Expanded(flex: 3, child: const SizedBox.shrink()),
                      ],
                    ),
                    SizedBox(height: h * 0.04),
                  ],

                  /// 🔽 REPORT TABLE
                  SizedBox(
                    height: h * 0.7, // give fixed height for table
                    child: Consumer<ReportController>(
                      builder: (context, value, child) {
                        if (reportController.reportState.status ==
                            Status.LOADING) {
                          return Center(
                            child: LoadingAnimationWidget.threeArchedCircle(
                              color: Theme.of(context).primaryColor,
                              size: h * 0.05,
                            ),
                          );
                        }

                        if (reportController.reportList.isEmpty) {
                          return Center(
                            child: Text(
                              "No Data Found",
                              style: GoogleFonts.poppins(fontSize: w * 0.03),
                            ),
                          );
                        }

                        return ReportTableWidget(); // table scrolls inside itself
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
