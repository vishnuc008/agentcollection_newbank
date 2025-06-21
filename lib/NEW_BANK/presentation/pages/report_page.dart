import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_gradient_widget.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/cutome_label_dropdown.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final reportController = Get.find<ReportController>();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + h * 0.03,
          leading: IconButton(
            onPressed: () {
              Get.back();
              reportController.reset();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
          ),
          backgroundColor: AppColors.maincolor,
          title: Text(
            "Report",
            style: GoogleFonts.poppins(
              fontSize: w * 0.05,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.04,
              h * 0.04,
              w * 0.04,
              h * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: LabelWithDropDownField(
                        onChanged: (value) {
                          reportController.selectedProduct.value = value;
                        },
                        textDropDownLabel: "Select Product",
                        items: (p0, p1) => ["All", "Vehicle Loan", "Home Loan"],
                      ),
                    ),
                    SizedBox(width: w * 0.04),
                    Expanded(
                      child: Obx(
                        () =>
                            reportController.isLoading.value
                                ? Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                        color: Theme.of(context).primaryColor,
                                        size: h * 0.04,
                                      ),
                                )
                                : Padding(
                                  padding: EdgeInsets.only(top: h * 0.03),
                                  child: CustomGradientButton(
                                    title: "Show",
                                    onPressed: () {
                                      reportController.searchReport(
                                        reportController.selectedProduct.value,
                                        context,
                                      );
                                    },
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.03),
                Obx(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child:
                        reportController.isReportSearch.value
                            ? ReportWidget()
                            : SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
