class GetNylonBatchItemsModel {
  GetNylonBatchItemsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.imageBaseUrl,
    required this.batchNumber,
  });

  final bool? status;
  final String? message;
  final List<NylonBatchItemsData> data;
  final String? imageBaseUrl;
  final String? batchNumber;

  factory GetNylonBatchItemsModel.fromJson(Map<String, dynamic> json){
    return GetNylonBatchItemsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<NylonBatchItemsData>.from(json["data"]!.map((x) => NylonBatchItemsData.fromJson(x))),
      imageBaseUrl: json["imageBaseUrl"],
      batchNumber: json["batchNumber"],
    );
  }

}

class NylonBatchItemsData {
  NylonBatchItemsData({
    required this.withdrawalRequestId,
    required this.id,
    required this.batchId,
    required this.serialNumber,
    required this.qrCodeImageName,
    required this.vendorId,
    required this.collectedStaffId,
    required this.collectionDate,
    required this.price,
    required this.requestApprovedId,
    required this.approvedDate,
    required this.status,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.isWithdrawal,
  });

  final dynamic withdrawalRequestId;
  final String? id;
  final String? batchId;
  final String? serialNumber;
  final String? qrCodeImageName;
  final dynamic vendorId;
  final dynamic collectedStaffId;
  final dynamic collectionDate;
  final int? price;
  final dynamic requestApprovedId;
  final dynamic approvedDate;
  final int? status;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? isWithdrawal;

  factory NylonBatchItemsData.fromJson(Map<String, dynamic> json){
    return NylonBatchItemsData(
      withdrawalRequestId: json["withdrawal_request_id"],
      id: json["_id"],
      batchId: json["batchId"],
      serialNumber: json["serialNumber"],
      qrCodeImageName: json["qrCodeImageName"],
      vendorId: json["vendorId"],
      collectedStaffId: json["collected_staff_id"],
      collectionDate: json["collection_date"],
      price: json["price"],
      requestApprovedId: json["request_approved_id"],
      approvedDate: json["approved_date"],
      status: json["status"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      isWithdrawal: json["is_withdrawal"],
    );
  }

}
