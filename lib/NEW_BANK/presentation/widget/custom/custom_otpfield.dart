import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class OtptextField extends StatelessWidget {
  OtptextField(
      {super.key,
      required this.controller,
      required this.autoFocus,
      this.obsecureText,
      this.onChanged});

  final TextEditingController controller;
  final bool autoFocus;
  bool? obsecureText = false;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    String? previousValue;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 1),
            blurRadius: 6,
            spreadRadius: 1)
      ]),
      height: 50,
      width: 40,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          obscureText: obsecureText == true ? true : false,
          obscuringCharacter: "*",
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintStyle: TextStyle(color: AppColors.black, fontSize: 20),
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
              if (onChanged != null) {
                onChanged!(value);
              }
              previousValue = value;
            } else if (previousValue != null) {
              FocusScope.of(context).previousFocus();
              previousValue = null;
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
