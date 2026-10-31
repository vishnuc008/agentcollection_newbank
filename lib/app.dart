import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/collection_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/dashboard_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/login_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/report_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_routes.dart';
import 'package:agentcollection_newbank/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => LoginController(sl(), sl(),sl()),),
      ChangeNotifierProvider(create: (context) => DashboardController(sl(), sl()),),
      ChangeNotifierProvider(create: (context) => CollectionController(sl(), sl(),sl(),sl()),),
      ChangeNotifierProvider(create: (context) => ReportController(sl(), sl()),)
    ],
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.routes,
    ),
    );
  }
}
