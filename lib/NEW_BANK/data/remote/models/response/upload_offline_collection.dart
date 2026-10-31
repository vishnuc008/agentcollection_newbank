class UploadOfflineCollectionResponseModal {
  final int status;
  final String message;
  final List<UploadOfflineCollectionData> data;

  UploadOfflineCollectionResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UploadOfflineCollectionResponseModal.fromJson(Map<String, dynamic> json) {
    return UploadOfflineCollectionResponseModal(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UploadOfflineCollectionData.fromJson(e))
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

class UploadOfflineCollectionData {
  final int? refId;

  UploadOfflineCollectionData({this.refId});

  factory UploadOfflineCollectionData.fromJson(Map<String, dynamic> json) {
    return UploadOfflineCollectionData(refId: json['RefID']);
  }

  Map<String, dynamic> toJson() {
    return {'RefID': refId};
  }
}
