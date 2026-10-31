class SessionCloseResponseModel {
  final int status;
  final String message;
  final List<AmountData> data;

  SessionCloseResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SessionCloseResponseModel.fromJson(Map<String, dynamic> json) {
    return SessionCloseResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => AmountData.fromJson(item))
              .toList(),
    );
  }
}

class AmountData {
  final double amt;

  AmountData({required this.amt});

  factory AmountData.fromJson(Map<String, dynamic> json) {
    return AmountData(amt: (json['Amt'] as num).toDouble());
  }
}
