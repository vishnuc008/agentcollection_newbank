import 'dart:convert';
class AccountResponseModel {
  final int status;
  final String message;
  final List<AccountData> data;

  AccountResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AccountResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => AccountData.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.map((item) => item.toJson()).toList(),
  };
}

// Individual account data model
class AccountData {
  final int sessionID;
  final String productType;
  final String memberNo;
  final String accountNo;
  final String customerName;
  final dynamic balance;
  final DateTime lastUpdateDate;
  final dynamic colAmt;

  AccountData({
    required this.sessionID,
    required this.productType,
    required this.memberNo,
    required this.accountNo,
    required this.customerName,
    required this.balance,
    required this.lastUpdateDate,
    required this.colAmt,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      sessionID: json['SessionID'],
      productType: json['ProductType'],
      memberNo: json['MemberNo']??"",
      accountNo: json['AccountNo'],
      customerName: json['CustomerName'],
      balance: json['Balance'],
      lastUpdateDate: DateTime.parse(json['LastUpdateDate']),
      colAmt: json['ColAmt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'SessionID': sessionID,
    'ProductType': productType,
    'MemberNo': memberNo,
    'AccountNo': accountNo,
    'CustomerName': customerName,
    'Balance': balance,
    'LastUpdateDate': lastUpdateDate.toIso8601String(),
    'ColAmt': colAmt,
  };
}

// Helper functions for parsing JSON string
AccountResponseModel accountResponseModelFromJson(String str) =>
    AccountResponseModel.fromJson(json.decode(str));

String accountResponseModelToJson(AccountResponseModel data) =>
    json.encode(data.toJson());
