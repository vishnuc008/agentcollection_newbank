import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/change_password.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/login.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/sessionopen.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/change_password_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/login_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/session_open_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/LocalStorageNames.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/themes/app_colors.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';

class LoginController extends ChangeNotifier {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginUsecase loginUsecase;
  final SessionOpenUsecase sessionOpenUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  LoginController(
    this.loginUsecase,
    this.sessionOpenUsecase,
    this.changePasswordUsecase,
  );

  ResponseClassify<LoginResponseModel> loginState =
      ResponseClassify<LoginResponseModel>.error("");
  final loginList = <LoginData>[];
  bool isAdminLoading = false;
  validate(String userName, String password, context) async {
    alertPrint("username= $userName, password=$password");
    final inputUser = userName.trim();
    final inputPass = password.trim();
    // 🚫 BLOCK LOGIN IF ANOTHER USER HAS ACTIVE SESSION
    bool sessionBlocked = await isSessionActiveForAnotherUser(inputUser);

    if (sessionBlocked) {
      bottomMsg(
        context,
        "Login Blocked",
        "Another user has an active session.\nPlease close the session before logging in.",
        false,
      );
      return;
    }

    //await clearDownloadedDataIfNewUser(inputUser);
    if (inputUser == "ADMIN" && inputPass == "P@ssw0rd") {
      isAdminLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 2));
      isAdminLoading = false;
      notifyListeners();
      bottomMsg(context, "Success", "Welcome Admin", true);
      GoRouter.of(context).pushReplacement(AppPages.adminpage);
      userNameController.clear();
      passwordController.clear();
      notifyListeners();
      return;
    }
    //used to prevent other login while the offline data exist
    String? otherUser = await getOfflineDataOwner(inputUser);
    if (otherUser != null) {
      bottomMsg(
        context,
        "Login Blocked",
        "Offline collections exist from '$otherUser'.\nPlease upload them before logging in.",
        false,
      );
      return; 
    }
//  ALLOW OFFLINE LOGIN FOR SAME USER
    bool canOfflineLogin = await hasDownloadedDataForUser(inputUser);
    if (canOfflineLogin) {
      bottomMsg(context, "Success", "Offline Login", true);

      // Restore saved session + agent details
    String agentId = await SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      SecureStorage.write('username', inputUser);

      GoRouter.of(context).pushReplacement(AppPages.dashboard);
      return;
    }

    //  NO OFFLINE DATA → DO NORMAL LOGIN
    loginState = ResponseClassify.loading();
    notifyListeners();

    try {
      loginState = ResponseClassify.completed(
        await loginUsecase.call(
          LoginRequestModel(userName: userName, password: password),
        ),
      );

    // loginState = ResponseClassify.loading();
    // notifyListeners();
    // try {
    //   loginState = ResponseClassify.completed(
    //     await loginUsecase.call(
    //       LoginRequestModel(userName: userName, password: password),
    //     ),
    //   );
      loginList.clear();
      loginList.addAll(loginState.data!.data);
      SecureStorage.write(LocalStorageKeys.agentID, loginList.first.agentId);
      SecureStorage.write('username', inputUser);

      // await SharedPrefService.write(
      //   LocalStorageKeys.agentID,
      //   loginList.first.agentId.toString(),
      // );
      //   await SharedPrefService.write(
      //   LocalStorageKeys.sessionID,
      //   loginList.first.sessionId.toString(),
      // );
      // if (loginList.isNotEmpty) {
      //   String sessionId = loginList.first.sessionId.toString();
      //   if (sessionId.isEmpty || sessionId == "0") {
      //    // getSessionOpen(context);
      //   } else {
      //     bottomMsg(context, "Success", "Login Sucessfull", true);
      //     GoRouter.of(context).pushReplacement(AppPages.dashboard);
      //     userNameController.clear();
      //     passwordController.clear();
      //     notifyListeners();
      //   }
      // }
      bottomMsg(context, "Success", "Login Sucessfull", true);
      GoRouter.of(context).pushReplacement(AppPages.dashboard);
      userNameController.clear();
      passwordController.clear();
      notifyListeners();
    } catch (e) {
      loginState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      notifyListeners();
    }
  }

  //check another login
  Future<String?> getOfflineDataOwner(String currentUsername) async {
    var box = await Hive.openBox<LoanCollection>('offlineCollection');
    if (box.isEmpty) return null;

    // Check if any offline data exists for a different user
    for (var item in box.values) {
      if (item.createdBy != null && item.createdBy != currentUsername) {
        return item.createdBy; // return the username of the other user
      }
    }
    return null;
  }

  // Clears downloaded collection data if the last logged-in user  is different from the current user.
  Future<void> clearDownloadedDataIfNewUser(String currentUser) async {
    final lastUser = await SecureStorage.read('username') ?? "";

    if (lastUser.isNotEmpty && lastUser != currentUser) {
      // Clear downloaded collection (Hive box)
      var box = await Hive.openBox<LoanCollection>('loanCollection');
      await box.clear();
      successPrint(
        "Cleared downloaded collection for previous user: $lastUser",
      );

      // Reset session info
      var sessionBox = await Hive.openBox('sessionBox');
      await sessionBox.put('SessionID', 0);
      await SecureStorage.write(LocalStorageKeys.sessionID, "0");
      await SecureStorage.write(LocalStorageKeys.downloadData, "false");
    }

    // Update the last logged-in user
    await SecureStorage.write('username', currentUser);
  }

  //check to login through offline via the data is exist in offline collection
  Future<bool> hasOfflineData(String username) async {
    var box = await Hive.openBox<LoanCollection>('offlineCollection');
    if (box.isEmpty) return false;

    // Check if ANY entry belongs to the current user
    return box.values.any((item) => item.createdBy == username);
  }

  Future<bool> hasDownloadedDataForUser(String username) async {
    final storedUser = await SecureStorage.read('username') ?? "";
    final downloadFlag =
        await SecureStorage.read(LocalStorageKeys.downloadData) ?? "false";

    if (storedUser != username) return false;
    if (downloadFlag != "true") return false;

    var box = await Hive.openBox<LoanCollection>('loanCollection');
    return box.isNotEmpty;
  }
Future<bool> isSessionActiveForAnotherUser(String currentUser) async {
    var sessionBox = await Hive.openBox('sessionBox');
    int sessionId = sessionBox.get('SessionID', defaultValue: 0);

    if (sessionId == 0) return false; // no active session

    final storedUser = await SecureStorage.read('username') ?? "";

    // session exists but user is different
    return storedUser.isNotEmpty && storedUser != currentUser;
  }



  //session open

  ResponseClassify<SessionOpenResponseModel> sessionOpenState =
      ResponseClassify<SessionOpenResponseModel>.error("");
  final sessionOpenList = <SessionData>[];
  getSessionOpen(context) async {
    customPrint("session loading");
    sessionOpenState = ResponseClassify.loading();
    notifyListeners();
    try {
      customPrint("session inside try");
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      sessionOpenState = ResponseClassify.completed(
        await sessionOpenUsecase.call(
          SessionOpenRequestModel(agentId: agentId),
        ),
      );
      sessionOpenList.clear();
      sessionOpenList.addAll(sessionOpenState.data!.data);
      customPrint("session add all");
      SecureStorage.write(
        LocalStorageKeys.sessionID,
        sessionOpenList.first.sessionId,
      );
      customPrint("sessionId= ${sessionOpenList.first.sessionId}");
      bottomMsg(context, "Success", "Login Sucessfull", true);
      alertPrint("session id opened suceess");
      GoRouter.of(context).pushReplacement(AppPages.dashboard);
      userNameController.clear();
      passwordController.clear();
      notifyListeners();
    } catch (e) {
      sessionOpenState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      notifyListeners();
    }
  }

  void showGlassmorphicDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.grey,
          elevation: 0,
          child: GlassmorphicDialogContent(
            callBack: () => getSessionOpen(context),
          ),
        );
      },
    );
  }

  //changepassword
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final confirmnewpasswordController = TextEditingController();
  ResponseClassify<ChangePasswordResponseModal> changePassState =
      ResponseClassify<ChangePasswordResponseModal>.error("");
  final changePassList = <ChangePasswordData>[];
  getChangepass(String oldPassword, String newPassword, context) async {
    changePassState = ResponseClassify.loading();
    notifyListeners();
    try {
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      changePassState = ResponseClassify.completed(
        await changePasswordUsecase.call(
          ChangePasswordRequestModal(
            agentId: agentId,
            oldPassword: oldPassword,
            newPassword: newPassword,
          ),
        ),
      );
      changePassList.clear();
      changePassList.addAll(changePassState.data!.data);
      bottomMsg(context, "Success", "Password Changed Success", true);
      oldpasswordController.clear();
      newpasswordController.clear();
      confirmnewpasswordController.clear();
      GoRouter.of(context).pushReplacement(AppPages.dashboard);
      notifyListeners();
    } catch (e) {
      changePassState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      notifyListeners();
    }
  }
}

class GlassmorphicDialogContent extends StatelessWidget {
  GlassmorphicDialogContent({super.key, required this.callBack});
  final void Function()? callBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.white.withOpacity(0.15),
        // border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Session Alert',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Would you like to fetch your session ID?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 92, 81, 137),
              // foregroundColor: Color(0xFF0E2C5E),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              customPrint("callback caled");
              callBack?.call();
            },

            child: const Text(
              'Get Session ID',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
