class ChangePasswordRequestModal {
  final String agentId;
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequestModal({
    required this.agentId,
    required this.oldPassword,
    required this.newPassword,
  });

  /// Convert object to JSON (for API request)
  Map<String, dynamic> toJson() {
    return {
      "AgentID": agentId,
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
    };
  }

  /// Create object from JSON (if needed for debugging/response mapping)
  factory ChangePasswordRequestModal.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequestModal(
      agentId: json["AgentID"] ?? "",
      oldPassword: json["OldPassword"] ?? "",
      newPassword: json["NewPassword"] ?? "",
    );
  }
}
