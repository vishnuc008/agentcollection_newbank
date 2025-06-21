
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_assets.dart';
import '../../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle1,
    this.onPressed,
    this.isnotLoginpage = false,
    this.height,
    this.isNotShowBackButton = false,
    required this.subtitle2,
  });
  final double? height;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final void Function()? onPressed;
  final bool? isnotLoginpage;

  final bool? isNotShowBackButton;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Container(
      height: height ?? h * 0.18,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.maincolor.withOpacity(0.7),
                AppColors.maincolor2.withOpacity(0.7),
                AppColors.maincolor3.withOpacity(0.7),
              ])),
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.005, 0, h * 0.005),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isNotShowBackButton == false
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w * 0.08,
                      height: w * 0.08,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: const Color(0xff2563EB))),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            onPressed!();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: w * 0.05,
                            color: AppColors.white,
                          )),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.02, vertical: h * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: h * 0.03,
                        width: w * 0.23,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.spalshLogo))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            subtitle1,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                fontSize: w * 0.032),
                          ),
                          Text(
                            subtitle2,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                fontSize: w * 0.032),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            title!.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(top: h * 0.005),
              child: Text(title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: w * 0.05)),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
