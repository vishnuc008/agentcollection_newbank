import 'package:agentcollection_newbank/NEW_BANK/domain/entities/report_modal.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}
final reportController= Get.find<ReportController>();
class _ReportWidgetState extends State<ReportWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reportController.reportList.length,
      itemBuilder: (context, index) {
        return ReportItem(modal: reportController.reportList[index]);
      },
    );
  }
}

class ReportItem extends StatelessWidget {
  const ReportItem({super.key, required this.modal});
  final ReportModal modal;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: h * 0.2,
        width: w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.5,
                    child: Text(
                      modal.name,
                      style: GoogleFonts.poppins(
                        fontSize: w * 0.05,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.02),
                    child: Text(
                      modal.product,
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
              _buildInfoRow("Balance Amount", "₹ ${modal.amt}"),
              SizedBox(height: h * 0.01),
              _buildInfoRow("Last Updated Date", modal.date),
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
