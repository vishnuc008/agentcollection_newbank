class SessionCloseRequestModel {
  final String agentId;
  final String sessionId;

  SessionCloseRequestModel({required this.agentId, required this.sessionId});

  Map<String, dynamic> toJson() {
    return {'AgentID': agentId, 'SessionID': sessionId};
  }

  factory SessionCloseRequestModel.fromJson(Map<String, dynamic> json) {
    return SessionCloseRequestModel(
      agentId: json['AgentID'],
      sessionId: json['SessionID'],
    );
  }
}
