class LoginRequestModel {
  final String userName;
  final String password;

  LoginRequestModel({required this.userName, required this.password});

  // Convert Dart object to JSON map
  Map<String, dynamic> toJson() {
    return {'UserName': userName, 'Password': password};
  }

  // Optional: Create Dart object from JSON map (if needed)
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      userName: json['UserName'],
      password: json['Password'],
    );
  }
}
