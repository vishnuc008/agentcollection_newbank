class TotalRequestModel {
  final int agentId;
  final int sessionId;

  TotalRequestModel({required this.agentId, required this.sessionId});

  Map<String, dynamic> toJson() {
    return {'AgentID': agentId, 'SessionID': sessionId};
  }

  factory TotalRequestModel.fromJson(Map<String, dynamic> json) {
    return TotalRequestModel(
      agentId: json['AgentID'],
      sessionId: json['SessionID'],
    );
  }
}
