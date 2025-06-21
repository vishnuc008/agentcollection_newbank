// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../manager/controller/advocate/dashboard_controller.dart';
// import '../../themes/app_colors.dart';

// class CheckInternetWidget extends StatefulWidget {
//   final Function() retryLoadData;
//   const CheckInternetWidget({super.key, required this.retryLoadData});

//   @override
//   State<CheckInternetWidget> createState() => _CheckInternetWidgetState();
// }

// final dashboardController = Get.find<DashboardController>();

// class _CheckInternetWidgetState extends State<CheckInternetWidget> {
//   @override
//   void initState() {
//     dashboardController.initConnectivity(context);
//     dashboardController.connectivity.onConnectivityChanged
//         .listen((List<ConnectivityResult> results) {
//       if (results.isEmpty) {
//         dashboardController.updateConnectionStatus(
//             ConnectivityResult.none, context);
//       } else {
//         bool hasActiveConnection = results.any((result) =>
//             result != ConnectivityResult.none &&
//             result != ConnectivityResult.bluetooth);
//         dashboardController.updateConnectionStatus(
//             hasActiveConnection ? results.first : ConnectivityResult.none,
//             context);
//       }
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           height: 700.h,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Center(
//                 child: Text('No Internet Connection'),
//               ),
//               SizedBox(height: 10.h),
//               GestureDetector(
//                 onTap: () {
//                   widget.retryLoadData();
//                 },
//                 child: Container(
//                   width: 100.w,
//                   padding:
//                       EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
//                   decoration: BoxDecoration(
//                     color: AppColors.red,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.2),
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                         offset: const Offset(2, 3),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     'Retry',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
