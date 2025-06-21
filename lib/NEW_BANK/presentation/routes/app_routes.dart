import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/bindings/collection_cntrl_binding.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/bindings/dashboard_cntrl_binding.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/bindings/report_cntrl_binding.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/collection_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/dashboard.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/login_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/report_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/splash.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.splash, page: ()=> SplashScreen()),
    GetPage(name: AppPages.login, page: ()=> LoginPage()),
    GetPage(name: AppPages.dashboard, page: ()=> DashBoardPage(),binding: DashboardCntrlBinding()),
    GetPage(name: AppPages.collection, page: ()=> CollectionPage(),binding: CollectionCntrlBinding()),
    GetPage(name: AppPages.report, page: ()=> ReportPage(),binding: ReportCntrlBinding()),
  ];
}
