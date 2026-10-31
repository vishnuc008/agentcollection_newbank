import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

void customAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? txtbuttonName1,
  VoidCallback? txtbutton1Action,
  String? txtbuttonName2,
  VoidCallback? txtbutton2Action,
  bool errorField = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismiss by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(title, style: const TextStyle(color: AppColors.black)),
        content: Text(
          content,
          style: TextStyle(color: errorField ? AppColors.red : AppColors.black),
        ),
        actions: [
          if (txtbutton1Action != null)
            TextButton(
              onPressed: () {
                txtbutton1Action();
              },
              child: Text(txtbuttonName1 ?? "OK"),
            ),
          if (txtbutton2Action != null)
            TextButton(
              onPressed: () {
                txtbutton2Action();
              },
              child: Text(txtbuttonName2 ?? "Cancel"),
            ),
        ],
      );
    },
  );
}
