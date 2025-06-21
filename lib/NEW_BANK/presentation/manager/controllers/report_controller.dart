import 'package:agentcollection_newbank/NEW_BANK/domain/entities/report_modal.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final List<ReportModal> reportList = [
    ReportModal("Rajeev", "Home Loan", "2500", "23/10/34"),
    ReportModal("Sajan", "Vehicle Loan", "3000", "23/10/34"),
    ReportModal("Giri", "Home Loan", "2500", "23/10/34"),
    ReportModal("Shekhar", "Home Loan", "9500", "23/10/34"),
    ReportModal("Venu", "Personal Loan", "2500", "23/10/34"),
  ];

  final isReportSearch = false.obs;
  final isLoading = false.obs;
  final selectedProduct = ''.obs;
  void searchReport(String product, context) async {
    selectedProduct.value = product;
    if (product.isEmpty) {
      bottomMsg(context, "Failed", "Select Product", false);
      return;
    }
    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 800));
    isLoading.value = false;
    isReportSearch.value = true;
  }

  void reset() {
    selectedProduct.value = '';
    isReportSearch.value = false;
  }
}
