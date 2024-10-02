class GetNylonDetailsAssignedModel {
  GetNylonDetailsAssignedModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<NylonDetailsAssignedData> data;
  final Pagination? pagination;

  factory GetNylonDetailsAssignedModel.fromJson(Map<String, dynamic> json){
    return GetNylonDetailsAssignedModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<NylonDetailsAssignedData>.from(json["data"]!.map((x) => NylonDetailsAssignedData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class NylonDetailsAssignedData {
  NylonDetailsAssignedData({
    required this.id,
    required this.vendorId,
    required this.batchNumber,
    required this.vendorCode,
    required this.companyName,
    required this.assignedDate,
  });

  final String? id;
  final String? vendorId;
  final String? batchNumber;
  final String? vendorCode;
  final String? companyName;
  final String? assignedDate;

  factory NylonDetailsAssignedData.fromJson(Map<String, dynamic> json){
    return NylonDetailsAssignedData(
      id: json["_id"],
      vendorId: json["vendorId"],
      batchNumber: json["batchNumber"],
      vendorCode: json["vendorCode"],
      companyName: json["companyName"],
      assignedDate: json["assignedDate"],
    );
  }

}

class Pagination {
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
  });

  final int? totalItems;
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      totalItems: json["totalItems"],
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
    );
  }

}
