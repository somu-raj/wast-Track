class GetVendorWithdrawRequestHistoryCountModel {
  GetVendorWithdrawRequestHistoryCountModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetVendorWithdrawRequestHistoryCountModel.fromJson(Map<String, dynamic> json){
    return GetVendorWithdrawRequestHistoryCountModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.totalReqCount,
    required this.pendingReqCount,
    required this.approveReqCount,
    required this.rejectReqCount,
  });

  final int? totalReqCount;
  final int? pendingReqCount;
  final int? approveReqCount;
  final int? rejectReqCount;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      totalReqCount: json["totalReqCount"],
      pendingReqCount: json["pendingReqCount"],
      approveReqCount: json["approveReqCount"],
      rejectReqCount: json["rejectReqCount"],
    );
  }

}
