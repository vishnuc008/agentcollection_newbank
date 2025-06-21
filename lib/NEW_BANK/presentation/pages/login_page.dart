import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/cutome_label_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_pages.dart';
import '../themes/app_assets.dart';
import '../themes/app_colors.dart';
import '../widget/custom/custom_text_Filed.dart';
import '../widget/custom/custome_gradient_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -w * 0.2,
              top: -h * 0.04,
              child: CircleAvatar(
                backgroundColor: AppColors.maincolor2,
                radius: w * 0.3,
              ),
            ),
            Positioned(
              right: -w * 0.2,
              top: -h * 0.05,
              child: CircleAvatar(
                backgroundColor: AppColors.maincolor,
                radius: w * 0.25,
              ),
            ),
            Positioned(
              top: h * 0.6,
              left: -w * 0.3,
              child: CircleAvatar(
                radius: w * 0.5,
                backgroundColor: AppColors.maincolor,
              ),
            ),
            Positioned(
              top: h * 0.7,
              left: -w * 0.5,
              child: CircleAvatar(
                radius: w * 0.5,
                backgroundColor: AppColors.maincolor2,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(height: h * 0.25),
                  Text(
                    "Login",
                    style: GoogleFonts.asar(
                      color: AppColors.black,
                      fontSize: w * 0.1,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  Text(
                    "Start with Sign in..!",
                    style: GoogleFonts.arsenal(
                      color: AppColors.black,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: h * 0.1),
                  CustomTextField(
                    hintText: "Username",
                    prefix: Icon(Icons.person_2_outlined),
                    showPrefixIcon: true,
                  ),
                  SizedBox(height: h * 0.03),
                  CustomTextField(
                    hintText: "Password",
                    prefix: Icon(Icons.lock_clock_outlined),
                    showPrefixIcon: true,
                    passwordfield: true,
                  ),
                  SizedBox(height: h * 0.1),
                  CustomGradientButton(
                    title: "Login",
                    onPressed: () {
                      Get.toNamed(AppPages.dashboard);
                      debugPrint("dashboard");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
