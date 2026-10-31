import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ViewPassbookTable extends StatelessWidget {
  const ViewPassbookTable({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final passbookDetailCntrl = Provider.of<CollectionController>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<CollectionController>(
        builder: (context, value, child) {
          if (passbookDetailCntrl.passbookDetailState.status ==
              Status.LOADING) {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Theme.of(context).primaryColor,
                size: h * 0.04,
              ),
            );
          } else if (passbookDetailCntrl.passbookDetailList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                const Text(
                  "No Data Found",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                border: TableBorder.all(color: AppColors.maincolor),
                headingRowColor: WidgetStateColor.resolveWith(
                  (states) => AppColors.maincolor,
                ),
                headingTextStyle: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
                columns: [
                  DataColumn(label: Text("Date", style: GoogleFonts.poppins())),
                  DataColumn(
                    label: Text("Amount", style: GoogleFonts.poppins()),
                  ),
                  DataColumn(
                    label: Text("Balance", style: GoogleFonts.poppins()),
                  ),
                ],
                rows:
                    passbookDetailCntrl.passbookDetailList.map((e) {
                      final bool isPayment =
                          (e.payment != 0 && e.payment != null);
                      final displayAmount = isPayment ? e.payment : e.receipt;

                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              DateFormat(
                                'dd-MM-yyyy',
                              ).format(DateTime.parse(e.trDate.toString())),
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                displayAmount.toString(),
                                style: GoogleFonts.poppins(
                                  color: isPayment ? Colors.red : Colors.green,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                e.balance.toString(),
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
