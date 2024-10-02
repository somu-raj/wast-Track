class GetNylonDetailsModel {
  GetNylonDetailsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<NylonDetailsList> data;
  final Pagination? pagination;

  factory GetNylonDetailsModel.fromJson(Map<String, dynamic> json){
    return GetNylonDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<NylonDetailsList>.from(json["data"]!.map((x) => NylonDetailsList.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class NylonDetailsList {
  NylonDetailsList({
    required this.id,
    required this.batchNumber,
    required this.price,
    required this.nylonOrderId,
    required this.status,
    required this.isAssigned,
    required this.vendorId,
    required this.assignedDate,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? batchNumber;
  final int? price;
  final dynamic nylonOrderId;
  final int? status;
  final int? isAssigned;
  final dynamic vendorId;
  final dynamic assignedDate;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory NylonDetailsList.fromJson(Map<String, dynamic> json){
    return NylonDetailsList(
      id: json["_id"],
      batchNumber: json["batchNumber"],
      price: json["price"],
      nylonOrderId: json["nylonOrderId"],
      status: json["status"],
      isAssigned: json["is_assigned"],
      vendorId: json["vendorId"],
      assignedDate: json["assignedDate"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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
