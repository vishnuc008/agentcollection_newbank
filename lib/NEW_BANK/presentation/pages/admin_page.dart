import 'dart:io';

import 'package:agentcollection_newbank/NEW_BANK/core/api_provider.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/remote_routes/app_remote_routes.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_text_Filed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final urlController = TextEditingController(text: AppRemoteRoutes.baseUrl);
  bool isUpdateing = false;
  String? errorText;

  /// ✅ URL validation function
  bool isValidUrl(String url) {
    try {
      final uri = Uri.tryParse(url);
      return uri != null &&
          uri.isAbsolute &&
          (uri.scheme == "http" || uri.scheme == "https");
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + h * 0.03,
            leading: IconButton(
              onPressed: () {
                context.go(AppPages.login);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
            ),
            backgroundColor: AppColors.maincolor,
            title: Text(
              "Admin Panel",
              style: GoogleFonts.poppins(
                fontSize: w * 0.05,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.maincolor.withOpacity(0.05),
                    AppColors.maincolor.withOpacity(0.1),
                    Colors.grey.shade50,
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: h * 0.01),
                  SizedBox(
                    height: h * 0.25,
                    width: w * 0.5,
                    child: Lottie.asset(AppAssets.adminLottie, height: 100),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    "Paste the URL below to configure system settings",
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Text(
                    "Configuration URL",
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: urlController,
                          hintText: "https://example.com/config",
                          showPrefixIcon: true,
                          prefix: Icon(Icons.link, color: AppColors.maincolor),
                          onChanged: (value) {
                            setState(() {
                              errorText = null; // clear error on typing
                            });
                          },
                        ),
                        if (errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 12),
                            child: Text(
                              errorText!,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  SizedBox(
                    height: h * 0.07,
                    width: w * 0.9,
                    child:
                        isUpdateing
                            ? Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: Theme.of(context).primaryColor,
                                size: h * 0.04,
                              ),
                            )
                            : ElevatedButton(
                              onPressed: () async {
                                final newUrl = urlController.text.trim();

                                // ✅ Validation checks
                                if (newUrl.isEmpty) {
                                  setState(() {
                                    errorText = "URL cannot be empty";
                                  });
                                  return;
                                }
                                if (!isValidUrl(newUrl)) {
                                  setState(() {
                                    errorText =
                                        "Please enter a valid URL (http/https)";
                                  });
                                  return;
                                }

                                setState(() {
                                  isUpdateing = true;
                                  errorText = null;
                                });

                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                ApiProvider().updatebaseUrl(newUrl);

                                bottomMsg(
                                  context,
                                  "Success",
                                  "Url Updated",
                                  true,
                                );
                                setState(() => isUpdateing = false);

                                // ✅ Restart dialog
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  barrierColor: Colors.black.withOpacity(0.6),
                                  builder: (context) {
                                    return PopScope(
                                      canPop: false,
                                      child: Dialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: const EdgeInsets.all(20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.2,
                                                ),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(
                                                  20,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      AppColors.maincolor,
                                                      AppColors.maincolor
                                                          .withOpacity(0.8),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.autorenew_rounded,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      "Restart Required",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  20,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color:
                                                          Colors.green.shade600,
                                                      size: 50,
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      "URL updated successfully!",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors
                                                                    .grey
                                                                    .shade800,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      "Please exit the app to apply changes.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey
                                                                    .shade600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                height: 1,
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          exit(0);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .maincolor,
                                                          foregroundColor:
                                                              Colors.white,
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 14,
                                                              ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                          ),
                                                          elevation: 2,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .refresh_rounded,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Exit Now",
                                                              style: GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.maincolor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: h * 0.02,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                "Update URL",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
