import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';

class LabelCustomTextField extends StatefulWidget {
  const LabelCustomTextField({
    super.key,
    required this.hintText,
    this.hintstyle,
    this.onPressed,
    this.onchanged,
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
    required this.textFieldLabel,
    this.textInputAction,
    this.initialValue,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? showSuffixicon;
  final bool? enable;
  final Function? onPressed;
  final Function? onTap;
  final Function? onchanged;
  final bool? passwordfield;
  final Widget? suffix;
  final Function(String)? validator;
  final TextInputType? inputType;
  final int? lines;
  final Widget? prefix;
  final bool? readOnly;
  final Widget? label;
  final TextStyle? hintstyle;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final String textFieldLabel;
  final TextInputAction? textInputAction;
  final String? initialValue;

  @override
  State<LabelCustomTextField> createState() => _LabelCustomTextField();
}

class _LabelCustomTextField extends State<LabelCustomTextField> {
  bool showpassword = true;
  late bool showPrefixIcon;

  @override
  void initState() {
    showPrefixIcon = widget.showSuffixicon ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.textFieldLabel,
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            width: w,
            child: TextFormField(
              initialValue: widget.initialValue,
              readOnly: widget.readOnly ?? false,
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              autofillHints: widget.autofillHints,
              inputFormatters: widget.inputFormatters,
              onChanged: (value) {
                if (widget.onchanged != null) {
                  widget.onchanged!(value);
                }
              },
              controller: widget.controller,
              validator:
                  widget.validator == null
                      ? null
                      : (val) => widget.validator!(val ?? ""),
              obscureText: widget.passwordfield == true ? showpassword : false,
              keyboardType: widget.inputType ?? TextInputType.text,
              textInputAction: widget.textInputAction ?? TextInputAction.done,
              maxLines: widget.passwordfield == true ? 1 : widget.lines,
              decoration: InputDecoration(
                filled: true,
                label: widget.label,
                labelText: widget.labelText,
                labelStyle: const TextStyle(),
                fillColor: AppColors.white,
                prefixIcon: showPrefixIcon ? widget.prefix : null,
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
                                  ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
                                  )
                                  : Icon(
                                    Icons.remove_red_eye,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        )
                        : widget.suffix,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.white,
                    width: 0.3,
                  ),
                ),
                hintText: widget.hintText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.white,
                    // width: 0.3,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(15),
                hintStyle:
                    widget.hintstyle ?? const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
