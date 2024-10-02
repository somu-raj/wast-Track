class GetVendorWithdrawPendingRequestModel {
  GetVendorWithdrawPendingRequestModel({
    required this.status,
    required this.isTokenExpired,
    required this.message,
    required this.data,
  });

  final bool? status;
  final bool? isTokenExpired;
  final String? message;
  final Data? data;

  factory GetVendorWithdrawPendingRequestModel.fromJson(Map<String, dynamic> json){
    return GetVendorWithdrawPendingRequestModel(
      status: json["status"],
      isTokenExpired: json["isTokenExpired"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.availableAmount,
    required this.pendingAmount,
    required this.withdrawnAmount,
    required this.totalAmount,
  });

  final int? availableAmount;
  final int? pendingAmount;
  final int? withdrawnAmount;
  final int? totalAmount;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      availableAmount: json["availableAmount"],
      pendingAmount: json["pendingAmount"],
      withdrawnAmount: json["withdrawnAmount"],
      totalAmount: json["totalAmount"],
    );
  }

}
