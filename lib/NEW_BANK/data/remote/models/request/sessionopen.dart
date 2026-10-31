class SessionOpenRequestModel {
  final String agentId;

  SessionOpenRequestModel({required this.agentId});

  Map<String, dynamic> toJson() {
    return {'AgentID': agentId};
  }

  factory SessionOpenRequestModel.fromJson(Map<String, dynamic> json) {
    return SessionOpenRequestModel(agentId: json['AgentID']);
  }
}
