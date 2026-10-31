import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportTableWidget extends StatelessWidget {
  const ReportTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ReportController>(context);
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // 🔽 Vertical scroll
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // ➡️ Horizontal scroll
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: w),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
              AppColors.maincolor.withOpacity(0.8),
            ),
            columnSpacing: w * 0.02,
            dataRowMinHeight: 48,
            dataRowMaxHeight: 56,
            columns: [
              _header("Customer Name", w),
              _header("Member No", w),
              _header("Product", w),
              _header("Account No", w),
              _header("Amount", w),
              // _header("Date", w),
            ],
            rows:
                controller.reportList.map((e) {
                  return DataRow(
                    cells: [
                      DataCell(Text(e.displayName)),
                      DataCell(Text(e.memberNo)),
                      DataCell(Text(e.productType)),
                      DataCell(Text(e.accountNo)),
                      DataCell(Text("₹ ${e.amount}")),
                     // DataCell(Text(DateFormat('dd-MM-yyyy').format(e.trDate))),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  DataColumn _header(String title, double w) {
    return DataColumn(
      label: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: w * 0.018,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
