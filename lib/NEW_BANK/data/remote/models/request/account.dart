class AccountRequestModel {
  final String agentID;

  AccountRequestModel({required this.agentID});

  // Convert JSON to model
  factory AccountRequestModel.fromJson(Map<String, dynamic> json) {
    return AccountRequestModel(agentID: json['AgentID'] as String);
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {'AgentID': agentID};
  }
}
