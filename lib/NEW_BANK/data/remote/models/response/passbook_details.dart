class PassbookDetailsResponseModal {
  final int status;
  final String message;
  final List<PassbookEntry> data;

  PassbookDetailsResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  /// JSON → Model
  factory PassbookDetailsResponseModal.fromJson(Map<String, dynamic> json) {
    return PassbookDetailsResponseModal(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => PassbookEntry.fromJson(e))
              .toList() ??
          [],
    );
  }

  /// Model → JSON
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class PassbookEntry {
  final DateTime trDate;
  final double payment;
  final double receipt;
  final double balance;

  PassbookEntry({
    required this.trDate,
    required this.payment,
    required this.receipt,
    required this.balance,
  });

  /// JSON → Model
  factory PassbookEntry.fromJson(Map<String, dynamic> json) {
    return PassbookEntry(
      trDate: DateTime.parse(json['TrDate']),
      payment: (json['Payment'] as num).toDouble(),
      receipt: (json['Receipt'] as num).toDouble(),
      balance: (json['Balance'] as num).toDouble(),
    );
  }

  /// Model → JSON
  Map<String, dynamic> toJson() {
    return {
      "TrDate": trDate.toIso8601String(),
      "Payment": payment,
      "Receipt": receipt,
      "Balance": balance,
    };
  }
}
