import 'package:agentcollection_newbank/NEW_BANK/domain/entities/dashboard_modal.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../manager/controllers/dashboard_controller.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    final dashboardcontroller = Provider.of<DashboardController>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dashboardcontroller.dashList.length,
      itemBuilder: (context, index) {
        return DashboardItem(modal: dashboardcontroller.dashList[index]);
      },
    );
  }
}

class DashboardItem extends StatelessWidget {
  final DashboardModal modal;

  const DashboardItem({super.key, required this.modal});
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.04, h * 0.02, w * 0.04, h * 0.01),
      child: GestureDetector(
        onTap: () {
          modal.onTap(context);
        },
        child: Container(
          height: h * 0.09,
          width: w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: h * 0.06,
                width: w * 0.1,
                child: Image.asset(modal.img),
              ),
              Text(
                modal.name,
                style: GoogleFonts.poppins(
                  fontSize: w * 0.05,
                  color: AppColors.maincolor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  modal.onTap(context);
                },
                icon: Icon(Icons.arrow_forward_ios, color: AppColors.maincolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
