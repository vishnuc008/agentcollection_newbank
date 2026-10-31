import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/admin_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/collection_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/dashboard.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/login_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/report_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/savecollection_page.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/pages/splash.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  // static List<GetPage> routes = [
  //   GetPage(name: AppPages.splash, page: ()=> SplashScreen()),
  //   GetPage(name: AppPages.login, page: ()=> LoginPage()),
  //   GetPage(name: AppPages.dashboard, page: ()=> DashBoardPage(),binding: DashboardCntrlBinding()),
  //   GetPage(name: AppPages.collection, page: ()=> CollectionPage(),binding: CollectionCntrlBinding()),
  //   GetPage(name: AppPages.report, page: ()=> ReportPage(),binding: ReportCntrlBinding()),
  // ];
  static GoRouter routes = GoRouter(
    initialLocation: AppPages.splash,
    routes: [
      GoRoute(
        path: AppPages.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(path: AppPages.login, builder: (context, state) => LoginPage()),
      GoRoute(
        path: AppPages.dashboard,
        builder: (context, state) => DashBoardPage(),
      ),
      GoRoute(
        path: AppPages.collection,
        builder: (context, state) => CollectionPage(),
      ),
      GoRoute(path: AppPages.report, builder: (context, state) => ReportPage()),
      GoRoute(path: AppPages.savecollection,builder: (context, state) {
         final LoanCollection accmodal = state.extra as LoanCollection;
          return SaveCollectionPage(modal: accmodal);
      },),
      GoRoute(path: AppPages.adminpage,builder: (context, state) => AdminPage(),),
      GoRoute(path: AppPages.changepasswordpage,builder: (context, state) => ChangePasswordPage(),)
    ],
  );
}
