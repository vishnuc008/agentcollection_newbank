class SessionOpenResponseModel {
  final int status;
  final String message;
  final List<SessionData> data;

  SessionOpenResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SessionOpenResponseModel.fromJson(Map<String, dynamic> json) {
    return SessionOpenResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => SessionData.fromJson(item))
              .toList(),
    );
  }
}

class SessionData {
  final int sessionId;

  SessionData({required this.sessionId});

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(sessionId: json['SessionID']);
  }
}
