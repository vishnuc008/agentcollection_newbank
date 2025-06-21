import 'dart:ui';

import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/dashboard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h * 0.32,
                width: w,
                decoration: BoxDecoration(
                  color: AppColors.maincolor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(35),
                    bottomLeft: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.02),
                      Center(
                        child: Text(
                          "Agent Collection",
                          style: GoogleFonts.poppins(
                            fontSize: w * 0.06,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.02, top: h * 0.04),
                        child: Text(
                          "Suresh Kumar",
                          style: GoogleFonts.poppins(
                            fontSize: w * 0.04,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: h * 0.1,
                          width: w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.1,
                            ), // Semi-transparent white
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                0.3,
                              ), // Light border effect
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ), // Blur effect
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Total Collection",
                                      style: GoogleFonts.poppins(
                                        fontSize: w * 0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01),
                                  Center(
                                    child: Text(
                                      "₹ 30000.00 /-",
                                      style: GoogleFonts.poppins(
                                        fontSize: w * 0.06,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.05),
              DashboardWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isRed = false}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ":",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
