import 'package:flutter/material.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';

void bottomMsg(
  BuildContext context,
  String title,
  String msg,
  bool success, {
  bool showOnTop = true,
  bool isWarning = false,
}) {
  final overlay = Overlay.of(context);
  double w = MediaQuery.of(context).size.width;

  Color bgColor;
  IconData iconData;

  if (isWarning) {
    bgColor = Colors.amber.shade600;
    iconData = Icons.warning_amber_rounded;
  } else if (success) {
    bgColor = Colors.green.shade600;
    iconData = Icons.check_circle_rounded;
  } else {
    bgColor = Colors.red.shade600;
    iconData = Icons.error_rounded;
  }

  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: showOnTop ? MediaQuery.of(context).padding.top + 20 : null,
        bottom: showOnTop ? null : MediaQuery.of(context).padding.bottom + 30,
        left: w * 0.05,
        right: w * 0.05,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, opacity, child) {
            return Opacity(opacity: opacity, child: child);
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(iconData, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          msg,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2)).then((_) {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
