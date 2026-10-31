import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/login_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + h * 0.03,
          leading: IconButton(
            onPressed: () {
              controller.oldpasswordController.clear();
              controller.newpasswordController.clear();
              controller.confirmnewpasswordController.clear();
              context.go(AppPages.dashboard);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
          ),
          backgroundColor: AppColors.maincolor,
          title: Text(
            "Change Password",
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.025),
                Text(
                  "Update Your Password",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.05,
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text(
                  "Create a strong password to secure your account",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: w * 0.028,
                  ),
                ),
                SizedBox(height: h * 0.04),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02, bottom: h * 0.01),
                  child: Text(
                    "Current Password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.038,
                    ),
                  ),
                ),
                Center(
                  child: CustomTextField(
                    controller: controller.oldpasswordController,
                    hintText: "Enter Current Password",
                    passwordfield: true,
                  ),
                ),
                SizedBox(height: h * 0.025),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02, bottom: h * 0.01),
                  child: Text(
                    "New Password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.038,
                    ),
                  ),
                ),
                Center(
                  child: CustomTextField(
                    controller: controller.newpasswordController,
                    hintText: "Enter New Password",
                    passwordfield: true,
                  ),
                ),
                SizedBox(height: h * 0.025),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02, bottom: h * 0.01),
                  child: Text(
                    "Confirm New Password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: w * 0.038,
                    ),
                  ),
                ),
                Center(
                  child: CustomTextField(
                    controller: controller.confirmnewpasswordController,
                    hintText: "Enter Confirm New Password",
                    passwordfield: true,
                  ),
                ),
                SizedBox(height: h * 0.08),
                Consumer<LoginController>(
                  builder:
                      (context, value, child) =>
                          controller.changePassState.status == Status.LOADING
                              ? Center(
                                child: LoadingAnimationWidget.threeArchedCircle(
                                  color: Theme.of(context).primaryColor,
                                  size: h * 0.04,
                                ),
                              )
                              : Padding(
                                padding: EdgeInsets.only(
                                  left: w * 0.02,
                                  right: w * 0.02,
                                ),
                                child: SizedBox(
                                  width: w,
                                  height: h * 0.055,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (controller
                                          .oldpasswordController
                                          .text
                                          .isEmpty) {
                                        bottomMsg(
                                          context,
                                          "Failed",
                                          "Please enter Current Password",
                                          false,
                                        );
                                      } else if (controller
                                          .newpasswordController
                                          .text
                                          .isEmpty) {
                                        bottomMsg(
                                          context,
                                          "Failed",
                                          "Please enter New Password",
                                          false,
                                        );
                                      } else if (controller
                                          .confirmnewpasswordController
                                          .text
                                          .isEmpty) {
                                        bottomMsg(
                                          context,
                                          "Failed",
                                          "Please enter Confirm New Password",
                                          false,
                                        );
                                      } else if (controller
                                              .newpasswordController
                                              .text !=
                                          controller
                                              .confirmnewpasswordController
                                              .text) {
                                        bottomMsg(
                                          context,
                                          "Failed",
                                          "New Password & Confirm New Password not Same",
                                          false,
                                        );
                                      } else {
                                        controller.getChangepass(
                                          controller.oldpasswordController.text,
                                          controller.newpasswordController.text,
                                          context,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.maincolor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: Text(
                                      "Update Password",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
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
