import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionController extends GetxController {
  var isSearched = false.obs;
  var isLoading = false.obs;
  final TextEditingController accNoController = TextEditingController();
  final TextEditingController collectedAmtController = TextEditingController();
  void searchAccount(String accNo, context) async {
    if (accNo.isEmpty) {
      bottomMsg(context, "Failed", "Enter Acc No", false);
      return;
    }
    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 800));
    isLoading.value = false;
    isSearched.value = true;
  }

  void reset() {
    accNoController.clear();
    collectedAmtController.clear();
    isSearched.value = false;
  }
}
