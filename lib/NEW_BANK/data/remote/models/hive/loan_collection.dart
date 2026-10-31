
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'loan_collection.g.dart';

@HiveType(typeId: 0)
class LoanCollection {
  @HiveField(0)
  int sessionId;

  @HiveField(1)
  String productType;

  @HiveField(2)
  String memberNo;

  @HiveField(3)
  String accountNo;

  @HiveField(4)
  String customerName;

  @HiveField(5)
  double balance;

  @HiveField(6)
  DateTime lastUpdateDate;

  @HiveField(7)
  double colAmt;

  @HiveField(8)
  String ?paymentType;

  @HiveField(9)
  String? createdBy;

  LoanCollection({
    required this.sessionId,
    required this.productType,
    required this.memberNo,
    required this.accountNo,
    required this.customerName,
    required this.balance,
    required this.lastUpdateDate,
    required this.colAmt,
    this.paymentType,
    this.createdBy
  });

  factory LoanCollection.fromJson(Map<String, dynamic> json) => LoanCollection(
    sessionId: json['SessionID'],
    productType: json['ProductType'],
    memberNo: json['MemberNo'],
    accountNo: json['AccountNo'],
    customerName: json['CustomerName'],
    balance: (json['Balance'] as num).toDouble(),
    lastUpdateDate: DateTime.parse(json['LastUpdateDate']),
    colAmt: (json['ColAmt'] as num).toDouble(),
    paymentType: json['PaymentType'],
    createdBy: json['CreatedBy'],
  );

  Map<String, dynamic> toJson() => {
    'SessionID': sessionId,
    'ProductType': productType,
    'MemberNo': memberNo,
    'AccountNo': accountNo,
    'CustomerName': customerName,
    'Balance': balance,
    'LastUpdateDate': lastUpdateDate.toIso8601String(),
    'ColAmt': colAmt,
    'PaymentType':paymentType,
    'CreatedBy':createdBy
  };
}
