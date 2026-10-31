class ProductRequestModel {
  final String agentId;
  final String sessionId;

  ProductRequestModel({required this.agentId, required this.sessionId});

  Map<String, dynamic> toJson() {
    return {'AgentID': agentId, 'SessionID': sessionId};
  }

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) {
    return ProductRequestModel(
      agentId: json['AgentID'],
      sessionId: json['SessionID'],
    );
  }
}
