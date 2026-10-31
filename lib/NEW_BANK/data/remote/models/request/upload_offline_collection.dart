class UploadOfflineCollectionRequestModal {
  final String agentId;
  final String sessionId;
  final String colJson;
  final double totalAmount;

  UploadOfflineCollectionRequestModal({
    required this.agentId,
    required this.sessionId,
    required this.colJson,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      "AgentID": int.tryParse(agentId) ?? 0,
      "SessionID": int.tryParse(sessionId) ?? 0,
      "ColJson": colJson,
      "TotalAmount": totalAmount,
    };
  }
}
