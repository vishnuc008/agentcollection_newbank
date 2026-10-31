import 'dart:io';

import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/account.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/passbook_details.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/upload_offline_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/account_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/collection_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/passbook_details_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/upload_offline_collection_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/manager/controllers/dashboard_controller.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/LocalStorageNames.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/app_pages.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/secure_storage.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/loading_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class CollectionController extends ChangeNotifier {
  final AccountUsecase accountUsecase;
  final CollectionUsecase collectionUsecase;
  final PassbookDetailsUsecase passbookDetailsUsecase;
  final UploadOfflineCollectionUsecase uploadOfflineCollectionUsecase;
  CollectionController(
    this.accountUsecase,
    this.collectionUsecase,
    this.passbookDetailsUsecase,
    this.uploadOfflineCollectionUsecase,
  );
  final TextEditingController accNoController = TextEditingController();

  //fetchAccount

  List<LoanCollection> accountList = [];
  late ResponseClassify<List<LoanCollection>> accountState =
      ResponseClassify.completed([]);

  // Fetch data from API and save to Hive
  Future<void> getAccount(BuildContext context) async {
    String? isDataDownloaded = await SecureStorage.read(
      LocalStorageKeys.downloadData,
    );

    var box = await Hive.openBox<LoanCollection>('loanCollection');
    var sessionBox = await Hive.openBox('sessionBox');
    int sessionId = sessionBox.get('SessionID', defaultValue: 0);

    await loadOfflineCollection(context);

    if (sessionId != 0) {
      bottomMsg(
        context,
        "Session Active",
        "You already have an active session. Please close it before downloading again.",
        false,
      );
      return;
    }

    if (isDataDownloaded == "true" && box.isNotEmpty) {
      bottomMsg(
        context,
        "Already Downloaded",
        "You have already downloaded the collection data.",
        false,
      );
      return;
    }

    accountList.clear();
    accountState = ResponseClassify.loading();
    notifyListeners();

    try {
      LoadingScreen.instance().show(context: context, text: "Downloading...");
      await Future.delayed(const Duration(seconds: 1));

      String agentId = await SecureStorage.read(LocalStorageKeys.agentID) ?? "";

      final apiResponse = await accountUsecase.call(
        AccountRequestModel(agentID: agentId),
      );

      // ✅ Check empty response before mapping/using first
      if (apiResponse.data.isEmpty) {
        LoadingScreen.instance().hide();
        accountList.clear();
        accountState = ResponseClassify.completed([]);
        notifyListeners();

        bottomMsg(context, "Info", "Data is empty", false);
        return;
      }

      accountList =
          apiResponse.data
              .map<LoanCollection>((e) => LoanCollection.fromJson(e.toJson()))
              .toList();

      int newSessionId = apiResponse.data.first.sessionID;

      await saveDownloadDataToHive(accountList, context);

      await sessionBox.put('SessionID', newSessionId);
      await SecureStorage.write(
        LocalStorageKeys.sessionID,
        newSessionId.toString(),
      );
      await SecureStorage.write(LocalStorageKeys.downloadData, "true");

      successPrint("SessionID $newSessionId saved to Hive");
      successPrint("Data downloaded and saved to Hive successfully");

      bottomMsg(context, "Success", "Data downloaded successfully", true);
      accountState = ResponseClassify.completed(accountList);
      notifyListeners();
      LoadingScreen.instance().hide();
    } catch (e) {
      await SecureStorage.write(LocalStorageKeys.downloadData, "false");
      LoadingScreen.instance().hide();
      ErrorScreen.instance().show(context: context, text: "$e");
      await Future.delayed(const Duration(seconds: 2));
      ErrorScreen.instance().hide();
      errorPrint("Download failed: $e");
      notifyListeners();
    }
  }

  // Save list to Hive
  Future<void> saveDownloadDataToHive(
    List<LoanCollection> dataList,
    BuildContext context,
  ) async {
    var box = await Hive.openBox<LoanCollection>('loanCollection');
    await box.clear();
    for (var data in dataList) {
      await box.add(data);
    }
    successPrint("All data added to Hive successfully");
  }

  //save collection
  String selectedPayment = "Cash";
  final amountController = TextEditingController();
  ResponseClassify<CollectionResponseModal> saveCollectionState =
      ResponseClassify<CollectionResponseModal>.error("");
  final saveCollectionList = <CollectionResponseData>[];
  static const String hiveBoxName = 'loanCollection';
  static const String offlineCollectionBoxname = 'offlineCollection';

  //save collection locally................
  List<LoanCollection> offlineCollectionList = [];
  double offlineTotalAmount = 0.0;
  //load all offline collections from hive
  Future<void> loadOfflineCollection(BuildContext context) async {
    var box = await Hive.openBox<LoanCollection>(offlineCollectionBoxname);
    offlineCollectionList = box.values.toList();
    successPrint("offline collection count - ${offlineCollectionList.length}");
    offlineTotalAmount = 0.0;
    for (var item in offlineCollectionList) {
      offlineTotalAmount += item.colAmt;
    }
    successPrint(
      "Updated total collection amount after reload: $offlineTotalAmount",
    );
    notifyListeners();
  }

  Future<int> getSessionIdFromHive() async {
    var box = await Hive.openBox('sessionBox');
    return box.get('SessionID', defaultValue: 0);
  }

  //save collection locally
  Future<void> saveCollectionOffline({
    required String productType,
    required String memberNo,
    required String accountNo,
    required String customerName,
    required double balance,
    required double colAmt,
    required BuildContext context,
  }) async {
    var box = await Hive.openBox<LoanCollection>('offlineCollection');
    int sessionId = await getSessionIdFromHive();
    final currentUser = await SecureStorage.read('username') ?? "";
    LoanCollection collection = LoanCollection(
      sessionId: sessionId,
      productType: productType,
      memberNo: memberNo,
      accountNo: accountNo,
      customerName: customerName,
      balance: balance,
      lastUpdateDate: DateTime.now(),
      colAmt: colAmt,
      paymentType: selectedPayment,
      createdBy: currentUser,
    );
    await box.add(collection);
    await loadOfflineCollection(context);
    successPrint("Offline collection saved. New total: $offlineTotalAmount");
    successPrint(
      "Offline collection saved in separate Hive box: $offlineCollectionBoxname",
    );
    successPrint("Collection saved offline with sessionId: $sessionId");
    warningPrint("saved to local - $productType");
    warningPrint("saved to local - $memberNo");
    warningPrint("saved to local - $accountNo");
    warningPrint("saved to local - $customerName");
    warningPrint("saved to local - $balance");
    warningPrint("saved to local - $colAmt");
    warningPrint("saved to local - $selectedPayment");
    String formattedDate = DateFormat(
      'dd-MM-yyyy HH:mm:ss',
    ).format(collection.lastUpdateDate);
    warningPrint("saved to local - $formattedDate");
    warningPrint("saved to local -created by- $currentUser");
    accNoController.clear();
    selectedPayment = "Cash";
    accountList.clear();
    notifyListeners();
  }

  //upload offline collection in xml
  ResponseClassify<UploadOfflineCollectionResponseModal> uploadOfflineState =
      ResponseClassify<UploadOfflineCollectionResponseModal>.error("");
  final uploadofflineList = <UploadOfflineCollectionData>[];

  Future<void> uploadOfflineCollections(
    BuildContext context, {
    required double totalAmount,
  }) async {
    final offlineBox = await Hive.openBox<LoanCollection>(
      offlineCollectionBoxname,
    );

    final offlineCollections = offlineBox.values.toList();

    if (offlineCollections.isEmpty) {
      if (context.mounted) {
        bottomMsg(
          context,
          "No Offline Collections",
          "There are no offline collections to upload.",
          false,
        );
      }
      return;
    }

    if (!totalAmount.isFinite || totalAmount <= 0) {
      if (context.mounted) {
        bottomMsg(
          context,
          "Invalid Amount",
          "Please enter a valid total collection amount.",
          false,
        );
      }
      return;
    }

    uploadOfflineState = ResponseClassify.loading();
    notifyListeners();

    bool uploadSucceeded = false;

    try {
      LoadingScreen.instance().show(
        context: context,
        text: "Uploading Collections...",
      );

      final agentId = await SecureStorage.read(LocalStorageKeys.agentID) ?? "";

      final sessionId =
          await SecureStorage.read(LocalStorageKeys.sessionID) ?? "";

      if (agentId.isEmpty || sessionId.isEmpty) {
        throw Exception(
          "Agent ID or Session ID is missing. Please log in again.",
        );
      }

      // Build collection XML.
      final xmlBuffer = StringBuffer();
      xmlBuffer.write("<ColJson>");

      for (final collection in offlineCollections) {
        xmlBuffer.write("<Collection>");
        xmlBuffer.write("<ProductType>${collection.productType}</ProductType>");
        xmlBuffer.write("<AccountNo>${collection.accountNo}</AccountNo>");
        xmlBuffer.write("<Amount>${collection.colAmt}</Amount>");
        xmlBuffer.write("<PaymentType>${collection.paymentType}</PaymentType>");
        xmlBuffer.write("</Collection>");
      }

      xmlBuffer.write("</ColJson>");

      final xmlData = xmlBuffer.toString();

      // Include TotalAmount in the request.
      final request = UploadOfflineCollectionRequestModal(
        agentId: agentId,
        sessionId: sessionId,
        colJson: xmlData,
        totalAmount: totalAmount,
      );

      customPrint("Uploading offline collections...");
      customPrint("Agent ID: $agentId");
      customPrint("Session ID: $sessionId");
      customPrint("Entered Total Amount: $totalAmount");
      customPrint("Collection Count: ${offlineCollections.length}");

      // The API layer must throw for unsuccessful HTTP responses.
      final response = await uploadOfflineCollectionUsecase.call(request);

      // Reaching this point means the API call returned normally.
      // Verify HTTP status and business-level success in the API layer
      // before treating the operation as successful.
      uploadOfflineState = ResponseClassify.completed(response);
      uploadSucceeded = true;

      // Clear local data only after confirmed upload success.
      await offlineBox.clear();

      offlineCollectionList.clear();
      offlineTotalAmount = 0.0;

      if (context.mounted) {
        final dashboardController = Provider.of<DashboardController>(
          context,
          listen: false,
        );

        dashboardController.totalAmount = 0.0;
        dashboardController.totalCollectionList.clear();
        dashboardController.notifyListeners();

        // Session closing is separate from upload success.
        try {
          await dashboardController.getSessionClose(context);
        } catch (sessionError) {
          errorPrint("Session close failed: $sessionError");
        }
      }

      successPrint(
        "Uploaded ${offlineCollections.length} offline collections.",
      );

      if (context.mounted) {
        bottomMsg(
          context,
          "Success",
          "Offline collections uploaded successfully.",
          true,
        );
      }
    } catch (e, stackTrace) {
      uploadOfflineState = ResponseClassify.error("$e");

      errorPrint("Upload failed: $e");
      errorPrint("$stackTrace");

      if (context.mounted) {
        bottomMsg(context, "Upload Failed", "$e", false);
      }
    } finally {
      LoadingScreen.instance().hide();

      notifyListeners();
    }
  }

  //collection save on online

  getSaveCollection(double amount, context, AccountData modal) async {
    saveCollectionState = ResponseClassify.loading();
    notifyListeners();
    try {
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      String sessionId = SecureStorage.read(LocalStorageKeys.sessionID) ?? "";
      saveCollectionState = ResponseClassify.completed(
        await collectionUsecase.call(
          CollectionRequestModal(
            agentId: agentId,
            sessionId: sessionId,
            productType: modal.productType,
            accountNo: modal.accountNo,
            amount: amount.toString(),
            paymentType: selectedPayment,
          ),
        ),
      );
      saveCollectionList.clear();
      saveCollectionList.addAll(saveCollectionState.data!.data);
      bottomMsg(context, "Success", "Collection Saved Successfully", true);
      successPrint("refiD save= ${saveCollectionList.first.refId}");
      customPrint("agentid save= $agentId");
      customPrint("sessionid save= $sessionId");
      customPrint("producttype save= ${modal.productType}");
      customPrint("accNo save= ${modal.accountNo}");
      customPrint("amount save= $amount");
      customPrint("paymenttype save= $selectedPayment");
      accNoController.clear();
      amountController.clear();
      selectedPayment = "Cash";
      accountList.clear();
      notifyListeners();
      GoRouter.of(context).go(AppPages.dashboard);
    } catch (e) {
      saveCollectionState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "Collection Not Saved", false);
      notifyListeners();
    }
  }

  //passbook details
  ResponseClassify<PassbookDetailsResponseModal> passbookDetailState =
      ResponseClassify<PassbookDetailsResponseModal>.error("");
  final passbookDetailList = <PassbookEntry>[];
  getPassbookDetails(AccountData modal, context) async {
    passbookDetailState = ResponseClassify.loading();
    notifyListeners();
    try {
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      passbookDetailState = ResponseClassify.completed(
        await passbookDetailsUsecase.call(
          PassbookDetailsRequestModal(
            agentId: agentId,
            productType: modal.productType,
            accountNo: modal.accountNo,
          ),
        ),
      );
      passbookDetailList.clear();
      passbookDetailList.addAll(passbookDetailState.data!.data);
      successPrint("passbook details fetched");
      alertPrint("acc no- ${modal.accountNo}");
      notifyListeners();
    } catch (e) {
      passbookDetailState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "$e", false);
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    saveCollectionState = ResponseClassify.loading();
    if (!value) {
      saveCollectionState = ResponseClassify.completed(null);
    }
    notifyListeners();
  }

  void filterByMemberNo(String query) {
    final box = Hive.box<LoanCollection>('loanCollection');
    final allCollections = box.values.toList();

    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      accountList = allCollections;
    } else {
      accountList =
          allCollections.where((element) {
            final memberNo = element.memberNo.trim().toLowerCase();
            final customerName = element.customerName.trim().toLowerCase();
            final accountNo = element.accountNo.trim().toLowerCase();

            return memberNo.contains(searchQuery) ||
                customerName.contains(searchQuery) ||
                accountNo.contains(searchQuery);
          }).toList();
    }

    // Sort by member number
    accountList.sort((a, b) {
      final memberA = int.tryParse(a.memberNo) ?? 0;
      final memberB = int.tryParse(b.memberNo) ?? 0;

      return memberA.compareTo(memberB);
    });

    notifyListeners();
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  //download excel report before upload collection

  Future<void> downloadAllOfflineCollectionsExcel(BuildContext context) async {
    try {
      final box = await Hive.openBox<LoanCollection>(offlineCollectionBoxname);

      // Fetch ALL offline collections
      final List<LoanCollection> collections = box.values.toList();

      if (collections.isEmpty) {
        bottomMsg(
          context,
          "No Data",
          "No offline collections available to download.",
          false,
        );
        return;
      }

      LoadingScreen.instance().show(
        context: context,
        text: "Generating Excel Report...",
      );

      final excel = Excel.createExcel();
      final sheet = excel['All Collection Report'];

      final headers = [
        'Sl No',
        'Session ID',
        'Product Type',
        'Member No',
        'Customer Name',
        'Account No',
        'Balance',
        'Collection Amount',
        'Payment Type',
        'Created By',
        'Collection Date',
      ];

      // Header
      for (int i = 0; i < headers.length; i++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
        );

        cell.value = TextCellValue(headers[i]);
        cell.cellStyle = CellStyle(
          bold: true,
          backgroundColorHex: ExcelColor.fromHexString('#D9EAF7'),
        );
      }

      double totalAmount = 0;

      // All product collections
      for (int i = 0; i < collections.length; i++) {
        final item = collections[i];

        totalAmount += item.colAmt;

        final row = [
          i + 1,
          item.sessionId,
          item.productType,
          item.memberNo,
          item.customerName,
          item.accountNo,
          item.balance,
          item.colAmt,
          item.paymentType,
          item.createdBy,
          DateFormat('dd-MM-yyyy HH:mm:ss').format(item.lastUpdateDate),
        ];

        for (int j = 0; j < row.length; j++) {
          final cell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1),
          );

          final value = row[j];

          if (value is int) {
            cell.value = IntCellValue(value);
          } else if (value is double) {
            cell.value = DoubleCellValue(value);
          } else {
            cell.value = TextCellValue(value.toString());
          }
        }
      }

      // Total collection
      final totalRow = collections.length + 1;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: totalRow))
          .value = TextCellValue('Total Collection');

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: totalRow))
          .value = DoubleCellValue(totalAmount);

      // Generate Excel file
      final directory = await getApplicationDocumentsDirectory();

      final fileName =
          'All_Offline_Collections_${DateFormat('ddMMyyyy_HHmmss').format(DateTime.now())}.xlsx';

      final file = File('${directory.path}/$fileName');

      final bytes = excel.save();

      if (bytes == null) {
        throw Exception('Unable to generate Excel file');
      }

      await file.writeAsBytes(bytes, flush: true);

      LoadingScreen.instance().hide();

      // Open share/save option
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'All Offline Collection Report',
        ),
      );

      successPrint('Excel report generated: ${file.path}');
    } catch (e) {
      LoadingScreen.instance().hide();

      errorPrint('Excel report error: $e');

      if (context.mounted) {
        bottomMsg(
          context,
          "Failed",
          "Unable to generate Excel report: $e",
          false,
        );
      }
    }
  }
}
