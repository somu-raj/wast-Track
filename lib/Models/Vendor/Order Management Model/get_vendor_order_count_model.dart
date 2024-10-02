class GetVendorOrderCountModel {
  GetVendorOrderCountModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetVendorOrderCountModel.fromJson(Map<String, dynamic> json){
    return GetVendorOrderCountModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.pendingOrderCount,
    required this.cancelledOrderCount,
    required this.confirmedOrderCount,
    required this.completedOrderCount,
    required this.refundedOrderCount,
  });

  final int? pendingOrderCount;
  final int? cancelledOrderCount;
  final int? confirmedOrderCount;
  final int? completedOrderCount;
  final int? refundedOrderCount;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      pendingOrderCount: json["pendingOrderCount"],
      cancelledOrderCount: json["cancelledOrderCount"],
      confirmedOrderCount: json["confirmedOrderCount"],
      completedOrderCount: json["completedOrderCount"],
      refundedOrderCount: json["refundedOrderCount"],
    );
  }

}
