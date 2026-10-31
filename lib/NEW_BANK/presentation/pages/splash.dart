import 'dart:async';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppPages.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: h * 0.2,
                        width: w * 0.8,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAssets.growSplashLogo),
                          ),
                        ),
                      ),
                      // SizedBox(height: h * 0.02),
                      // Text(
                      //   "Agent Collection",
                      //   style: GoogleFonts.poppins(
                      //     fontSize: w * 0.06,
                      //     color: AppColors.black,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
