class CollectionResponseModal {
  final int status;
  final String message;
  final List<CollectionResponseData> data;

  CollectionResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CollectionResponseModal.fromJson(Map<String, dynamic> json) {
    return CollectionResponseModal(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => CollectionResponseData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class CollectionResponseData {
  final int refId;

  CollectionResponseData({required this.refId});

  factory CollectionResponseData.fromJson(Map<String, dynamic> json) {
    return CollectionResponseData(refId: json['RefID'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {"RefID": refId};
  }
}
