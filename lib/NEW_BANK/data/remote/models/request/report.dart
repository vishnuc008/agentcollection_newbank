class ReportRequestModel {
  final String agentId;
  final String sessionId;
  final String productType;

  ReportRequestModel({
    required this.agentId,
    required this.sessionId,
    required this.productType,
  });

  Map<String, dynamic> toJson() {
    return {
      'AgentID': agentId,
      'SessionID': sessionId,
      'ProductType': productType,
    };
  }

  factory ReportRequestModel.fromJson(Map<String, dynamic> json) {
    return ReportRequestModel(
      agentId: json['AgentID'],
      sessionId: json['SessionID'],
      productType: json['ProductType'],
    );
  }
}
