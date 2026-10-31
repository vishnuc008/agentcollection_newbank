import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/cutome_label_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SaveCollectionPage extends StatefulWidget {
  const SaveCollectionPage({super.key, required this.modal});
  final LoanCollection modal;

  @override
  State<SaveCollectionPage> createState() => _SaveCollectionPageState();
}

class _SaveCollectionPageState extends State<SaveCollectionPage> {
  bool alreadyCollected = false;
  @override
  void initState() {
    super.initState();
    final saveCollectionController = Provider.of<CollectionController>(
      context,
      listen: false,
    );
    saveCollectionController.amountController.text =
        widget.modal.colAmt.toString();
    alreadyCollected = false;
    // 🔍 Check if this member already has a collection offline
    Future.delayed(Duration.zero, () async {
      var box = await Hive.openBox<LoanCollection>('offlineCollection');
      final exists = box.values.any((e) => e.memberNo == widget.modal.memberNo);

      if (exists) {
        setState(() {
          alreadyCollected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final saveCollectionController = Provider.of<CollectionController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final dateTime = DateFormat(
      'dd-MM-yyyy',
    ).format(widget.modal.lastUpdateDate);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + h * 0.03,
            leading: IconButton(
              onPressed: () {
                context.go(AppPages.collection);
                saveCollectionController.amountController.clear();
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
            ),
            backgroundColor: AppColors.maincolor,
            title: Text(
              "Collection",
              style: GoogleFonts.poppins(
                fontSize: w * 0.05,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (alreadyCollected)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: h * 0.02),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber.shade800,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "This member's collection has already been collected once.",
                              style: GoogleFonts.poppins(
                                color: Colors.amber.shade900,
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: h * 0.01),
                  Container(
                    height: h * 0.28,
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
                          SizedBox(
                            width: w * 0.8,
                            child: Text(
                              widget.modal.customerName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                fontSize: w * 0.05,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.015),
                            child: Text(
                              widget.modal.productType,
                              style: GoogleFonts.poppins(
                                fontSize: w * 0.04,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          SizedBox(height: h * 0.015),
                          _buildInfoRow(
                            "Account Number",
                            widget.modal.accountNo,
                          ),
                          SizedBox(height: h * 0.015),
                          _buildInfoRow("Last Updated Date", dateTime),
                          SizedBox(height: h * 0.015),
                          _buildInfoRow(
                            "Balance Amount",
                            "₹${widget.modal.balance}/-",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  Text('Enter Amount', style: GoogleFonts.poppins()),
                  SizedBox(height: h * 0.01),
                  Container(
                    height: h * 0.1,
                    width: w * 0.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey,
                          blurRadius: 2,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),

                    ///Amount
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: saveCollectionController.amountController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "0/-",
                          prefixIcon: Icon(
                            Icons.currency_rupee_sharp,
                            size: w * 0.1,
                          ),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        // readOnly: false,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.08,
                          ),
                        ),
                        inputFormatters: const [],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.02, right: w * 0.03),
                    child: LabelWithDropDownField(
                      hintText: "Select Payment Mode",
                      textDropDownLabel: "Select Payment Mode",
                      items: (p0, p1) => ["Cash", "UPI"],
                      selectedItem: saveCollectionController.selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          saveCollectionController.selectedPayment = value;
                        });
                      },
                    ),
                  ),
                  if (saveCollectionController.selectedPayment == "UPI")
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(""),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Scan to Pay',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: h * 0.3,
                                          width: w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                AppAssets.qrcodeOrg,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text(
                                          'Close',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("View Qrcode"),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.04,
              h * 0.05,
              w * 0.04,
              h * 0.05,
            ),
            child: SizedBox(
              height: h * 0.067,
              width: w,
              child: Consumer<CollectionController>(
                builder: (context, value, child) {
                  final isLoading =
                      saveCollectionController.saveCollectionState.status ==
                      Status.LOADING;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isLoading ? h * 0.067 : h * 0.067,
                    width: isLoading ? h * 0.067 : w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.maincolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isLoading ? 50 : 12,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed:
                          isLoading
                              ? null
                              : () async {
                                saveCollectionController.setLoading(true);
                                final amountText =
                                    saveCollectionController
                                        .amountController
                                        .text
                                        .trim();

                                final amount =
                                    double.tryParse(amountText) ?? 0.0;

                                if (amountText.isEmpty || amount <= 0) {
                                  bottomMsg(
                                    context,
                                    "Failed",
                                    "Please enter a valid amount",
                                    false,
                                  );
                                  saveCollectionController.setLoading(false);
                                  return;
                                }

                                // Identify Deposit product types
                                final isDeposit = widget.modal.productType
                                    .trim()
                                    .toLowerCase()
                                    .contains('deposit');

                                // Apply balance validation only for non-deposit products
                                if (!isDeposit &&
                                    amount > widget.modal.balance) {
                                  bottomMsg(
                                    context,
                                    "Invalid Amount",
                                    "Entered amount cannot be greater than balance amount",
                                    false,
                                  );
                                  saveCollectionController.setLoading(false);
                                  return;
                                }

                                await Future.delayed(
                                  const Duration(milliseconds: 300),
                                );

                                await saveCollectionController
                                    .saveCollectionOffline(
                                      productType: widget.modal.productType,
                                      memberNo: widget.modal.memberNo,
                                      accountNo: widget.modal.accountNo,
                                      customerName: widget.modal.customerName,
                                      balance: widget.modal.balance,
                                      colAmt:
                                          double.tryParse(
                                            saveCollectionController
                                                .amountController
                                                .text,
                                          ) ??
                                          0.0,
                                      context: context,
                                    );

                                bottomMsg(
                                  context,
                                  "Success",
                                  "Collection saved offline successfully",
                                  true,
                                );

                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                saveCollectionController.amountController
                                    .clear();
                                saveCollectionController.setLoading(false);
                                GoRouter.of(context).go(AppPages.dashboard);
                              },

                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                        child:
                            isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: h * 0.035,
                                )
                                : Text(
                                  "Save",
                                  style: GoogleFonts.poppins(
                                    fontSize: w * 0.04,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
