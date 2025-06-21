import 'dart:async';

import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/login_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body:
           FlutterSplashScreen(
            duration: const Duration(seconds: 2),
            nextScreen:
                
                     const LoginPage(),
            backgroundColor: AppColors.white,
            splashScreenBody:  Center(child: SplashBody()),
          ),
        ),

    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
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
                        image: AssetImage(AppAssets.spalshLogo),
                      ),
                    ),
                  ),
                  SizedBox(height: h*0.02,),
                  Text("Agent Collection",style: GoogleFonts.poppins(
                      fontSize: w*0.06,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
