class RegisterResponseModel {
  RegisterResponseModel({
    required this.status,
    required this.message,
  });

  final bool? status;
  final String? message;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json){
    return RegisterResponseModel(
      status: json["status"],
      message: json["message"],
    );
  }

}
