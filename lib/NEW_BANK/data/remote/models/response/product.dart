class ProductResponseModel {
  final int status;
  final String message;
  final List<ProductData> data;

  ProductResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((item) => ProductData.fromJson(item))
              .toList(),
    );
  }
}

class ProductData {
  final String productType;

  ProductData({required this.productType});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(productType: json['ProductType']);
  }
}
