import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';

void customAlertDialogue({
  required String title,
  required String content,
  String? txtbuttonName1,
  Function? txtbutton1Action,
  String? txtbuttonName2,
  Function? txtbutton2Action,
  bool? errorField = false,
}) {
  Get.dialog(
    barrierDismissible: false,
    PopScope(
      canPop: true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
        title: Text(title, style: const TextStyle(color: AppColors.black)),
        content: Text(
          content,
          style: TextStyle(
            color: errorField == true ? AppColors.red : AppColors.black,
          ),
        ),
        actions: [
          txtbutton1Action == null
              ? const SizedBox()
              : TextButton(
                onPressed: () {
                  txtbutton1Action();
                },
                child: Text(txtbuttonName1!),
              ),
          txtbutton2Action == null
              ? const SizedBox()
              : TextButton(
                onPressed: () {
                  txtbutton2Action();
                },
                child: Text(txtbuttonName2!),
              ),
        ],
      ),
    ),
  );
}
