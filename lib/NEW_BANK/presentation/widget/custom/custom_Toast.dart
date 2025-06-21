import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../../themes/app_colors.dart';

void showCustomToast(String msg,
    {Color bgcolor = AppColors.grey,
    Color textcolor = AppColors.white,
    double fontsize = 16.0}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: bgcolor,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: textcolor,
    fontSize: fontsize,
    toastLength: Toast.LENGTH_SHORT,
  );
}
