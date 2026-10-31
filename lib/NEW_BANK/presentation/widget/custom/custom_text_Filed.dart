import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/app_colors.dart';

/// 🔹 Uppercase Formatter
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.onPressed,
    this.onChanged,
    this.passwordfield,
    this.showSuffixicon,
    this.controller,
    this.inputFormatters,
    this.suffix,
    this.validator,
    this.inputType,
    this.lines,
    this.onTap,
    this.readOnly,
    this.prefix,
    this.label,
    this.labelText,
    this.enable,
    this.autofillHints,
    this.maxLength,
    this.errorText,
    this.showPrefixIcon,
    this.textInputAction,
    this.hintStyle,

    /// ✅ NEW (optional)
    this.forceUpperCase = false,
  });

  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? labelText;
  final bool? showSuffixicon;
  final bool? enable;
  final Function? onPressed;
  final Function? onTap;
  final Function? onChanged;
  final bool? passwordfield;
  final Widget? suffix;
  final Function(String?)? validator;
  final TextInputType? inputType;
  final int? lines;
  final Widget? prefix;
  final bool? readOnly;
  final Widget? label;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final int? maxLength;
  final String? errorText;
  final bool? showPrefixIcon;
  final TextInputAction? textInputAction;

  /// 🔹 Optional Uppercase
  final bool forceUpperCase;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Container(
      width: w * 0.9,
      child: TextFormField(
        autofillHints: widget.autofillHints,

        /// ✅ Apply conditionally
        inputFormatters: [
          if (widget.forceUpperCase) UpperCaseTextFormatter(),
          ...?widget.inputFormatters,
        ],

        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        enabled: widget.enable,
        controller: widget.controller,
        validator:
            widget.validator == null
                ? null
                : (val) => widget.validator!(val ?? ""),
        obscureText: widget.passwordfield == true ? showpassword : false,
        keyboardType: widget.inputType ?? TextInputType.text,
        maxLines: widget.passwordfield == true ? 1 : widget.lines,
        textInputAction: widget.textInputAction ?? TextInputAction.done,

        decoration: InputDecoration(
          filled: true,
          errorText: widget.errorText,
          label: widget.label,
          labelText: widget.labelText,
          fillColor: AppColors.white,
          prefixIcon: widget.showPrefixIcon == true ? widget.prefix : null,

          suffixIcon:
              widget.passwordfield == true
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        showpassword = !showpassword;
                      });
                    },
                    icon:
                        showpassword
                            ? const Icon(
                              Icons.visibility_off,
                              size: 20,
                              color: AppColors.maincolor2,
                            )
                            : const Icon(
                              Icons.remove_red_eye,
                              color: AppColors.maincolor2,
                            ),
                  )
                  : widget.suffix,

          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyText, width: 0.3),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.3,
            ),
          ),

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppColors.greyText, width: 0.3),
          ),

          disabledBorder: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
