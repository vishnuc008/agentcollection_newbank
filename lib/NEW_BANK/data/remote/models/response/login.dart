class LoginResponseModel {
  final int status;
  final String message;
  final List<LoginData> data;

  LoginResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => LoginData.fromJson(item))
              .toList(),
    );
  }
}

class LoginData {
  final String userStatus;
  final int agentId;

  LoginData({
    required this.userStatus,
    required this.agentId,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      userStatus: json['UserStatus'],
      agentId: json['AgentID'],
    );
  }
}
