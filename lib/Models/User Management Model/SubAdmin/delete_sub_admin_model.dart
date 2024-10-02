class DeleteSubAdminResponseModel {
  DeleteSubAdminResponseModel({
    required this.status,
    required this.message,
  });

  final bool? status;
  final String? message;

  factory DeleteSubAdminResponseModel.fromJson(Map<String, dynamic> json){
    return DeleteSubAdminResponseModel(
      status: json["status"],
      message: json["message"],
    );
  }

}
