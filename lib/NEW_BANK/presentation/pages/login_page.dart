import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/login_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../themes/app_colors.dart';
import '../widget/custom/custom_text_Filed.dart';
import '../widget/custom/custome_gradient_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginControler = Provider.of<LoginController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background circles
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

              // Foreground login content
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: h * 0.25),
                              Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: w * 0.1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Start with Sign in..!",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: h * 0.05),
                              CustomTextField(
                                hintText: "Username",
                                forceUpperCase: true,
                                controller: loginControler.userNameController,
                                prefix: Icon(Icons.person_2_outlined),
                                showPrefixIcon: true,
                              
                              ),
                              SizedBox(height: h * 0.02),
                              CustomTextField(
                                hintText: "Password",
                                controller: loginControler.passwordController,
                                prefix: Icon(Icons.lock_clock_outlined),
                                showPrefixIcon: true,
                                passwordfield: true,
                              ),
                              SizedBox(height: h * 0.09),
                              Consumer<LoginController>(
                                builder: (context, value, child) {
                                  if (loginControler.isAdminLoading) {
                                    return Center(
                                      child:
                                          LoadingAnimationWidget.threeArchedCircle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: h * 0.04,
                                          ),
                                    );
                                  }
                                  if( loginControler.loginState.status ==
                                          Status.LOADING){
                                     return   Center(
                                        child:
                                            LoadingAnimationWidget.threeArchedCircle(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).primaryColor,
                                              size: h * 0.04,
                                            ),
                                      );
                                          }                                    
                                    return   CustomGradientButton(
                                        title: "Login",
                                        onPressed: () {
                                          if (loginControler
                                                  .userNameController
                                                  .text
                                                  .isEmpty &&
                                              loginControler
                                                  .passwordController
                                                  .text
                                                  .isEmpty) {
                                            bottomMsg(
                                              context,
                                              "Failed",
                                              "Please enter username & password",
                                              false,
                                            );
                                          } else if (loginControler
                                              .passwordController
                                              .text
                                              .isEmpty) {
                                            bottomMsg(
                                              context,
                                              "Failed",
                                              "Please enter password",
                                              false,
                                            );
                                          } else if (loginControler
                                              .userNameController
                                              .text
                                              .isEmpty) {
                                            bottomMsg(
                                              context,
                                              "Failed",
                                              "Please enter username",
                                              false,
                                            );
                                          } else {
                                            loginControler.validate(
                                              loginControler
                                                  .userNameController
                                                  .text,
                                              loginControler
                                                  .passwordController
                                                  .text,
                                              context,
                                            );
                                          }
                                        },
                                      );
                                },
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
