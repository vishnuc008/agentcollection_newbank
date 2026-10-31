class CollectionRequestModal {
  final String agentId;
  final String sessionId;
  final String productType;
  final String accountNo;
  final String amount;
  final String paymentType;

  CollectionRequestModal({
    required this.agentId,
    required this.sessionId,
    required this.productType,
    required this.accountNo,
    required this.amount,
    required this.paymentType,
  });

  /// Convert from JSON to Dart object
  factory CollectionRequestModal.fromJson(Map<String, dynamic> json) {
    return CollectionRequestModal(
      agentId: json['AgentID'] ?? '',
      sessionId: json['SessionID'] ?? '',
      productType: json['ProductType'] ?? '',
      accountNo: json['AccountNo'] ?? '',
      amount: json['Amount'] ?? '',
      paymentType: json['PaymentType'] ?? '',
    );
  }

  /// Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      "AgentID": agentId,
      "SessionID": sessionId,
      "ProductType": productType,
      "AccountNo": accountNo,
      "Amount": amount,
      "PaymentType": paymentType,
    };
  }
}
