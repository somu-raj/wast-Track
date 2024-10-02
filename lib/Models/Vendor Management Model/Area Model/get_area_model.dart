class GetAreaModel {
  GetAreaModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<DataAreaList> data;
  final Pagination? pagination;

  factory GetAreaModel.fromJson(Map<String, dynamic> json){
    return GetAreaModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<DataAreaList>.from(json["data"]!.map((x) => DataAreaList.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class DataAreaList {
  DataAreaList({
    required this.id,
    required this.areaName,
    required this.status,
    required this.vendorId,
    required this.assignedDate,
    required this.isDeleted,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.statusText,
  });

  final String? id;
  final String? areaName;
  final int? status;
  final dynamic vendorId;
  final dynamic assignedDate;
  final bool? isDeleted;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? statusText;

  factory DataAreaList.fromJson(Map<String, dynamic> json){
    return DataAreaList(
      id: json["_id"],
      areaName: json["areaName"],
      status: json["status"],
      vendorId: json["vendorId"],
      assignedDate: json["assignedDate"],
      isDeleted: json["isDeleted"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      statusText: json["statusText"],
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
