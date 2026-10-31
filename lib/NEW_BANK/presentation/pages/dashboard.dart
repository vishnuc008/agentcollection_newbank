import 'dart:ui';

import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/dashboard_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/dashboard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

late DashboardController dashboardController;

class _DashBoardPageState extends State<DashBoardPage> {
  Future<double?> showUploadConfirmationDialog(BuildContext context) async {
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    try {
      final result = await showDialog<double>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        builder:
            (dialogContext) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ===== Header Section =====
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.maincolor.withOpacity(0.08),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Icon
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.maincolor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.document_upload,
                                size: 32,
                                color: AppColors.maincolor,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Title
                            Text(
                              "Upload Collections",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.maincolor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ===== Content Section =====
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please enter the total collection amount for confirmation.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              controller: amountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: InputDecoration(
                                labelText: 'Total Collection Amount',
                                hintText: 'Enter amount',
                                prefixText: '₹ ',
                                prefixIcon: const Icon(Iconsax.money),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.maincolor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter the collection amount';
                                }

                                final amount = double.tryParse(value.trim());

                                if (amount == null ||
                                    !amount.isFinite ||
                                    amount <= 0) {
                                  return 'Please enter a valid amount';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      // ===== Divider =====
                      const Divider(height: 1, color: Colors.grey),

                      // ===== Action Buttons =====
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Cancel Button
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop(null);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(color: Colors.grey.shade400),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Confirm & Upload Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  final enteredAmount = double.parse(
                                    amountController.text.trim(),
                                  );

                                  customPrint(
                                    'User entered collection amount: ₹$enteredAmount',
                                  );

                                  Navigator.of(
                                    dialogContext,
                                  ).pop(enteredAmount);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.maincolor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: Text(
                                  "Confirm & Upload",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      );
      return result;
    } finally {
      amountController.dispose();
    }
  }

  @override
  void initState() {
    customPrint("inside initstate");
    super.initState();
    final collectionController = Provider.of<CollectionController>(
      context,
      listen: false,
    );

    // Load offline total regardless of session
    collectionController.loadOfflineCollection(context);
  }

  @override
  Widget build(BuildContext context) {
    final collectionController = Provider.of<CollectionController>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  //height: h * 0.4,
                  width: w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.maincolor,
                        AppColors.maincolor.withOpacity(0.9),
                        Color(0xFF2d3f63),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.02),

                        // App Title
                        Center(
                          child: Text(
                            "Agent Collection",
                            style: GoogleFonts.poppins(
                              fontSize: w * 0.06,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.02),

                        // Total Collection Card
                        Container(
                          width: w,
                          constraints: BoxConstraints(
                            minHeight: h * 0.16, // ✅ minimum, not fixed
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // ⭐ CRITICAL
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: h * 0.01),
                                    Text(
                                      "Total Collection",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize:
                                            w * 0.055, // 🔽 slightly reduced
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.02),
                                    Consumer<CollectionController>(
                                      builder: (context, value, child) {
                                        return Text(
                                          "₹ ${value.offlineTotalAmount.toStringAsFixed(2)} /-",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                w *
                                                0.065, // 🔽 reduced from 0.07
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.3,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.03),

                        // Upload & Download Buttons
                        Center(
                          child: Container(
                            width: w * 0.95,
                            height: h * 0.075,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Download
                                    _buildActionButton(
                                      context: context,
                                      icon: Iconsax.document_download,
                                      text: "Download",
                                      onPressed: () async {
                                        await collectionController.getAccount(
                                          context,
                                        );
                                      },
                                      backgroundColor: Colors.green.shade400,
                                    ),

                                    Container(
                                      width: 1,
                                      height: h * 0.03,
                                      color: Colors.white.withOpacity(0.3),
                                    ),

                                    // Excel Report
                                    _buildActionButton(
                                      context: context,
                                      icon: Iconsax.document_text,
                                      text: "Excel",
                                      onPressed: () async {
                                        await collectionController
                                            .downloadAllOfflineCollectionsExcel(
                                              context,
                                            );
                                      },
                                      backgroundColor: Colors.orange.shade400,
                                    ),

                                    Container(
                                      width: 1,
                                      height: h * 0.03,
                                      color: Colors.white.withOpacity(0.3),
                                    ),

                                    // Upload
                                    _buildActionButton(
                                      context: context,
                                      icon: Iconsax.document_upload,
                                      text: "Upload",
                                      onPressed: () async {
                                        if (collectionController
                                            .offlineCollectionList
                                            .isEmpty) {
                                          final shouldClose =
                                              await showNoOfflineCollectionsDialog(
                                                context,
                                              );

                                          if (shouldClose == true &&
                                              context.mounted) {
                                            await dashboardController
                                                .getSessionClose(context);
                                          }

                                          return;
                                        }

                                        final enteredAmount =
                                            await showUploadConfirmationDialog(
                                              context,
                                            );

                                        if (enteredAmount != null &&
                                            context.mounted) {
                                          await collectionController
                                              .uploadOfflineCollections(
                                                context,
                                                totalAmount: enteredAmount,
                                              );
                                        }
                                      },
                                      backgroundColor: Colors.blue.shade400,
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

                SizedBox(height: h * 0.03),

                // Dashboard Widget
                DashboardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: w * 0.06,
            height: h * 0.044,
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: w * 0.037, color: Colors.white),
                SizedBox(width: w * 0.02),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.033,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showNoOfflineCollectionsDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder:
          (dialogContext) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.folder_open,
                            size: 32,
                            color: Colors.orange.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          "No Offline Collections",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          "There are no offline collections to upload.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Do you want to close the session?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  const Divider(height: 1, color: Colors.grey),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Cancel Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(false);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Close Session Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              "Close Session",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
