class ReportResponseModel {
  final int status;
  final String message;
  final List<ReportData> data;

  ReportResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportResponseModel(
      status: json['status'],
      message: json['message'],
      data: List<ReportData>.from(
        json['data'].map((item) => ReportData.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
class ReportData {
  final String customerName;
  final String productType;
  final String accountNo;
  final double amount;
  final DateTime trDate;

  ReportData({
    required this.customerName,
    required this.productType,
    required this.accountNo,
    required this.amount,
    required this.trDate,
  });

  /// Extract member number from "BAIJU (456)"
  String get memberNo {
    final match = RegExp(r'\((.*?)\)').firstMatch(customerName);
    return match?.group(1) ?? '';
  }

  /// Extract clean customer name
  String get displayName {
    return customerName.replaceAll(RegExp(r'\s*\(.*?\)'), '').trim();
  }

  /// ✅ ADD THIS
  Map<String, dynamic> toJson() {
    return {
      'CustomerName': customerName,
      'ProductType': productType,
      'AccountNo': accountNo,
      'Amount': amount,
      'TrDate': trDate.toIso8601String(),
    };
  }

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      customerName: json['CustomerName'],
      productType: json['ProductType'],
      accountNo: json['AccountNo'],
      amount: (json['Amount'] as num).toDouble(),
      trDate: DateTime.parse(json['TrDate']),
    );
  }
}
