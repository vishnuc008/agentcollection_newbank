import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_assets.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

void bottomMsg(
  BuildContext context,
  String title,
  String msg,
  bool field, {
  bool showOnTop = true,
  bool isWarning = false,
}) {
  final overlay = Overlay.of(context);

  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: showOnTop ? MediaQuery.of(context).padding.top + 10 : null,
        bottom: showOnTop ? null : MediaQuery.of(context).padding.bottom + 10,
        left: w * 0.05,
        right: w * 0.05,
        child: Material(
          color: AppColors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  //offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(
                    //   //  color: AppColors.black,
                    //   height: h * 0.04,
                    //   width: field
                    //       ? w * 0.1
                    //       : isWarning
                    //           ? w * 0.122
                    //           : w * 0.145,
                    //   child: isWarning
                    //       ? const ColorFiltered(
                    //           colorFilter: ColorFilter.mode(
                    //               AppColors.yellow, BlendMode.srcIn),
                    //           child: RiveAnimation.asset(
                    //             alignment: Alignment.centerLeft,
                    //             AppAssets.warningRive,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         )
                    //       : RiveAnimation.asset(
                    //           alignment: Alignment.centerLeft,
                    //           field
                    //               ? AppAssets.successRive
                    //               : AppAssets.failedRive,
                    //           fit: BoxFit.cover,
                    //         ),
                    // )
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  msg,
                  style: const TextStyle(color: AppColors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2)).then((_) => overlayEntry.remove());
}
