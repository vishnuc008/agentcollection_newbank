import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/account.dart';
import 'package:flutter/material.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/view_passbook_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CollectionWidget extends StatefulWidget {
  const CollectionWidget({super.key});

  @override
  State<CollectionWidget> createState() => _CollectionWidgetState();
}

class _CollectionWidgetState extends State<CollectionWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // Listen to Hive box
    return Consumer<CollectionController>(
      builder: (context, controller, child) {
        final accountList = controller.accountList;

        if (accountList.isEmpty) {
          return Column(
            children: [
              SizedBox(height: h * 0.25),
              Center(
                child: Text("No Data Found", style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: accountList.length,
          itemBuilder: (context, index) {
            return CollectionItem(modal: accountList[index]);
          },
        );
      },
    );
  }
}

class CollectionItem extends StatelessWidget {
  final LoanCollection modal;

  const CollectionItem({super.key, required this.modal});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final dateTime = DateFormat('dd-MM-yyyy').format(modal.lastUpdateDate);

    final controller = Provider.of<CollectionController>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.go(AppPages.savecollection, extra: modal);
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                modal.productType.trim().toUpperCase().contains('DEPOSIT')
                    ? const Color.fromARGB(255, 234, 125, 16).withOpacity(0.2)
                    : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modal.customerName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text(
                  modal.productType,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: h * 0.01),
                _buildInfoRow("Account Number", modal.accountNo, w),
                SizedBox(height: h * 0.01),
                _buildInfoRow("Last Updated Date", dateTime, w),
                SizedBox(height: h * 0.01),
                _buildInfoRow("Balance Amount", "₹ ${modal.balance}/-", w),
                SizedBox(height: h * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _showPassbookDialog(context, modal, controller);
                      },
                      child: Text(
                        "View Passbook",
                        style: GoogleFonts.poppins(
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w500,
                          color: AppColors.maincolor3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, double w) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: w * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(":", style: GoogleFonts.poppins(fontSize: w * 0.035)),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: w * 0.035,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _showPassbookDialog(
    BuildContext context,
    LoanCollection modal,
    CollectionController controller,
  ) async {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // ✅ 1. Check if device is online before API call
    bool isOnline = await controller.checkInternetConnection();
    if (!isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You're offline! Passbook details require internet."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ 2. Show loading dialog immediately
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.maincolor3,
              size: 40,
            ),
          ),
    );

    // ✅ 3. Fetch passbook details online
    await controller.getPassbookDetails(
      AccountData(
        sessionID: modal.sessionId,
        memberNo: modal.memberNo,
        customerName: modal.customerName,
        productType: modal.productType,
        accountNo: modal.accountNo,
        balance: modal.balance,
        lastUpdateDate: modal.lastUpdateDate,
        colAmt: modal.colAmt,
      ),
      context,
    );

    // Close loading dialog
    Navigator.of(context).pop();

    // ✅ 4. If error occurred, do not open table dialog
    if (controller.passbookDetailState.status == Status.ERROR) return;

    // ✅ 5. Show Passbook details dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(w * 0.05),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(w * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.maincolor3,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passbook Details",
                        style: GoogleFonts.poppins(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: w * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),

                // Customer Info
                Padding(
                  padding: EdgeInsets.only(
                    left: w * 0.04,
                    top: h * 0.01,
                    bottom: h * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        modal.customerName,
                        style: GoogleFonts.poppins(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: h * 0.007),
                      Text(
                        "Account No: ${modal.accountNo}",
                        style: GoogleFonts.poppins(fontSize: w * 0.035),
                      ),
                      Text(
                        "Balance: ₹${modal.balance}/-",
                        style: GoogleFonts.poppins(fontSize: w * 0.035),
                      ),
                    ],
                  ),
                ),

                Divider(height: 1, color: Colors.grey.shade300),

                //  Passbook Table (after fetch)
                Container(
                  constraints: BoxConstraints(maxHeight: h * 0.55),
                  child: const ViewPassbookTable(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
