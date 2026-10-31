class ChangePasswordResponseModal {
  final int status;
  final String message;
  final List<ChangePasswordData> data;

  ChangePasswordResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChangePasswordResponseModal.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModal(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ChangePasswordData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ChangePasswordData {
  final int agentId;

  ChangePasswordData({required this.agentId});

  factory ChangePasswordData.fromJson(Map<String, dynamic> json) {
    return ChangePasswordData(agentId: json['AgentID'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'AgentID': agentId};
  }
}
