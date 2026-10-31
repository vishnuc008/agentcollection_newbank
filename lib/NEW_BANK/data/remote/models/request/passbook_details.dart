class PassbookDetailsRequestModal {
  final String agentId;
  final String productType;
  final String accountNo;

  PassbookDetailsRequestModal({
    required this.agentId,
    required this.productType,
    required this.accountNo,
  });

  /// Convert JSON to Model
  factory PassbookDetailsRequestModal.fromJson(Map<String, dynamic> json) {
    return PassbookDetailsRequestModal(
      agentId: json['AgentID'] ?? '',
      productType: json['ProductType'] ?? '',
      accountNo: json['AccountNo'] ?? '',
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      "AgentID": agentId,
      "ProductType": productType,
      "AccountNo": accountNo,
    };
  }
}
