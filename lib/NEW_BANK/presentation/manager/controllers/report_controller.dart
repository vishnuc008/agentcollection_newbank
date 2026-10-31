import 'package:agentcollection_newbank/NEW_BANK/core/response_classify.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/report.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/product_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/domain/usecases/report_usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/routes/LocalStorageNames.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_bottom_msg.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class ReportController extends ChangeNotifier {
  final ProductUsecase productUsecase;
  final ReportUsecase reportUsecase;
  ReportController(this.productUsecase, this.reportUsecase);

  //fetch products
  final Rxn<ProductData> selectedProductt = Rxn<ProductData>();
  ResponseClassify<ProductResponseModel> productState =
      ResponseClassify<ProductResponseModel>.error("");
  final productList = <ProductData>[];
  getProduct() async {
    productState = ResponseClassify.loading();
    notifyListeners();
    try {
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      successPrint("agentId= $agentId");
      String sessionId = SecureStorage.read(LocalStorageKeys.sessionID) ?? "";
      successPrint("session Id= $sessionId");

      productState = ResponseClassify.completed(
        await productUsecase.call(
          ProductRequestModel(agentId: agentId, sessionId: sessionId),
        ),
      );
      productList.clear();
      productList.addAll(productState.data!.data);
      notifyListeners();
      successPrint("products= ${productList.first.productType}");
    } catch (e) {
      productState = ResponseClassify.error("$e");
      alertPrint("products= $e");
      notifyListeners();
    }
  }

  // report

  ResponseClassify<ReportResponseModel> reportState =
      ResponseClassify<ReportResponseModel>.error("");
  final reportList = <ReportData>[];
  getReport(context) async {
    reportState = ResponseClassify.loading();
    notifyListeners();
    try {
      String agentId = SecureStorage.read(LocalStorageKeys.agentID) ?? "";
      successPrint("report agentId= $agentId");
      String sessionId = SecureStorage.read(LocalStorageKeys.sessionID) ?? "";
      successPrint("report sessionid= $sessionId");
      reportState = ResponseClassify.completed(
        await reportUsecase.call(
          ReportRequestModel(
            agentId: agentId,
            sessionId: sessionId,
            productType: selectedProductt.value?.productType ?? "",
          ),
        ),
      );
      reportList.clear();
      reportList.addAll(reportState.data!.data);
      notifyListeners();
      bottomMsg(context, "Success", "Report Fetch Successfully", true);
    } catch (e) {
      reportState = ResponseClassify.error("$e");
      bottomMsg(context, "Failed", "Report Fetch Failed", false);
      notifyListeners();
    }
  }

  static const String offlineCollectionBoxName = 'offlineCollection';
  final reportSearchController = TextEditingController();
  //report local from hive
  Future<void> getOfflineReport({required String productType}) async {
    reportState = ResponseClassify.loading();
    notifyListeners();
    try {
      var box = await Hive.openBox<LoanCollection>(offlineCollectionBoxName);
      List<LoanCollection> allData = box.values.toList();
      // Filter by product type
      final filteredData =
          allData
              .where((e) => e.productType == productType)
              .map(
                (e) => ReportData(
                  customerName: e.customerName,
                  productType: e.productType,
                  accountNo: e.accountNo,
                  amount: e.colAmt,
                  trDate: e.lastUpdateDate,
                ),
              )
              .toList();
     allReportList.clear();
      allReportList.addAll(filteredData);

      reportList.clear();
      reportList.addAll(filteredData);

      if (reportList.isNotEmpty) {
        reportState = ResponseClassify.completed(
          ReportResponseModel(
            status: 200,
            message: "Offline Report for $productType",
            data: reportList,
          ),
        );
        successPrint("Offline report fetched: ${reportList.length} entries");
      } else {
        reportState = ResponseClassify.completed(
          ReportResponseModel(
            status: 200,
            message: "No offline data found for $productType",
            data: [],
          ),
        );
        successPrint("No offline data found for product: $productType");
      }

      notifyListeners();
    } catch (e) {
      reportState = ResponseClassify.error("$e");
      alertPrint("Failed to fetch local report: $e");
      notifyListeners();
    }
  }

  Future<void> getOfflineProducts() async {
    try {
      var box = await Hive.openBox<LoanCollection>(offlineCollectionBoxName);
      final allData = box.values.toList();
      final productTypes =
          allData
              .where((e) => e.colAmt != null && e.colAmt > 0)
              .map((e) => e.productType)
              .toSet();
      productList.clear();
      productList.addAll(
        productTypes.map((e) => ProductData(productType: e)).toList(),
      );
      if (selectedProductt.value != null &&
          !productTypes.contains(selectedProductt.value!.productType)) {
        selectedProductt.value = null;
      }
      successPrint("Offline products fetched: ${productList.length}");
      notifyListeners();
    } catch (e) {
      alertPrint("Failed to fetch local products: $e");
    }
  }

  //search the report
  final List<ReportData> allReportList = [];
  void filterOfflineReport(String query) {
    if (query.isEmpty) {
      reportList
        ..clear()
        ..addAll(allReportList);
    } else {
      final lowerQuery = query.toLowerCase();

      reportList
        ..clear()
        ..addAll(
          allReportList.where((e) {
            final name = e.customerName?.toLowerCase() ?? '';
            final accNo = e.accountNo?.toLowerCase() ?? '';

            return name.contains(lowerQuery) || accNo.contains(lowerQuery);
          }),
        );
    }
    notifyListeners();
  }



  void clearLocalData() {
    productList.clear();
    reportList.clear();
    reportSearchController.clear();
    selectedProductt.value = null;

    productState = ResponseClassify<ProductResponseModel>.error("");
    reportState = ResponseClassify<ReportResponseModel>.error("");

    notifyListeners();
    successPrint("ReportController local data cleared");
  }
}
