import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custome_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CollectionPage extends StatelessWidget {
  CollectionPage({super.key});
  final collectionController = Get.find<CollectionController>();
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
              collectionController.reset();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
          ),
          backgroundColor: AppColors.maincolor,
          title: Text(
            "Collection",
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
                SizedBox(
                  height: h * 0.1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          hintText: "Acc No",
                          controller: collectionController.accNoController,
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: w * 0.04),
                      Expanded(
                        child: Obx(
                          () =>
                              collectionController.isLoading.value
                                  ? Center(
                                    child:
                                        LoadingAnimationWidget.threeArchedCircle(
                                          color: Theme.of(context).primaryColor,
                                          size: h * 0.04,
                                        ),
                                  )
                                  : CustomGradientButton(
                                    title: "Search",
                                    onPressed: () {
                                      collectionController.searchAccount(
                                        collectionController
                                            .accNoController
                                            .text,
                                        context,
                                      );
                                    },
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.03),
                Obx(
                  () =>
                      collectionController.isSearched.value
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                child: Container(
                                  height: h * 0.18,
                                  width: w,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: h * 0.01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: w * 0.5,
                                              child: Text(
                                                "RajKumar",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w * 0.05,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: w * 0.02,
                                              ),
                                              child: Text(
                                                "Personal Loan",
                                                style: GoogleFonts.poppins(
                                                  fontSize: w * 0.04,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: h * 0.02),
                                        _buildInfoRow(
                                          "Balance Amount",
                                          "₹ 2000",
                                        ),
                                        SizedBox(height: h * 0.01),
                                        _buildInfoRow(
                                          "Last Updated Date",
                                          "03/04/2025",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.025),

                              Text(
                                'Enter Amount',
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(height: h * 0.01),
                              Container(
                                height: h * 0.1,
                                width: w * 0.9,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey,
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                ),

                                ///Amount
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextFormField(
                                    // controller: controller.collectedAmountController,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "0/-",
                                      prefixIcon: FaIcon(
                                        Icons.currency_rupee_sharp,
                                        size: w * 0.1,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    // readOnly: false,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.08,
                                      ),
                                    ),
                                    inputFormatters: const [],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(w * 0.04, h * 0.05, w * 0.04, h * 0.05),
          child: SizedBox(
            height: h * 0.067,
            width: w,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppPages.dashboard);
                collectionController.reset();
              },
              child: Text(
                "Save",
                style: GoogleFonts.poppins(
                  fontSize: w * 0.04,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isRed = false}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ":",
            style: GoogleFonts.poppins(fontSize: 15, color: AppColors.black),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isRed ? AppColors.red : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
