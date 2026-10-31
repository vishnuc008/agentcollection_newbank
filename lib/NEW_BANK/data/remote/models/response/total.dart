class TotalResponseModel {
  final int status;
  final String message;
  final List<TotalData> data;

  TotalResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TotalResponseModel.fromJson(Map<String, dynamic> json) {
    return TotalResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => TotalData.fromJson(item))
              .toList(),
    );
  }
}

class TotalData {
  final double amount;

  TotalData({required this.amount});

  factory TotalData.fromJson(Map<String, dynamic> json) {
    return TotalData(amount: (json['amount'] as num).toDouble());
  }
}
