import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';

class RemarkCard extends StatelessWidget {
  final dynamic remark;
  final bool isExpanded;
  final VoidCallback onToggle;

  const RemarkCard({
    required this.remark,
    required this.isExpanded,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionTooLong =
        remark.description.length > 150; // Customize limit

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6,
      margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      remark.date,
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding:  EdgeInsets.only(top: 8.h),
                child: Text(
                  remark.description,
                  style: GoogleFonts.poppins(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: isExpanded ? null : 4,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
              ),
            ),
            if (descriptionTooLong)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onToggle,
                  child: Text(
                    isExpanded ? "Read Less" : "Read More",
                    style: GoogleFonts.poppins(
                        color: AppColors.maincolor2,
                        fontWeight: FontWeight.w500,
                        fontSize: 9.sp),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
