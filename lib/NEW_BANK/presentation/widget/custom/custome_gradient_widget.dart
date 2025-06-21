import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonRColor,
    this.buttonLColor,
    this.textColor,
    this.width,
    this.height,
    this.iconButton = false,
    this.icon,
    this.iconColor,
    this.iconRightSide = true,
    this.textStyle,
  });

  final String title;
  final Function onPressed;
  final Color? buttonRColor;
  final Color? buttonLColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool iconButton;
  final IconData? icon;
  final Color? iconColor;
  final bool iconRightSide;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width ?? w * 0.9,
      height: height ?? h * 0.06,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => onPressed(),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null && iconRightSide == false)
                    Icon(
                      icon!,
                      color: iconColor ?? Colors.white,
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: iconRightSide == false ? w * 0.02 : 0,
                      right: iconRightSide == true ? w * 0.02 : 0,
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: textColor ?? AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (icon != null && iconRightSide == true)
                    Icon(
                      icon!,
                      color: iconColor ?? Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
