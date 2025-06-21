import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_routes.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.splash,
      getPages: AppRoutes.routes,
    );
  }
}
