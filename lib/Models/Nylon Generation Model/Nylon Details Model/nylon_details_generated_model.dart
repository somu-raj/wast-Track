class GetNylonDetailsGeneratedModel {
  GetNylonDetailsGeneratedModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<NylonDetailsGeneratedData> data;
  final Pagination? pagination;

  factory GetNylonDetailsGeneratedModel.fromJson(Map<String, dynamic> json){
    return GetNylonDetailsGeneratedModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<NylonDetailsGeneratedData>.from(json["data"]!.map((x) => NylonDetailsGeneratedData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class NylonDetailsGeneratedData {
  NylonDetailsGeneratedData({
    required this.id,
    required this.batchNumber,
    required this.status,
    required this.createdAt,
  });

  final String? id;
  final String? batchNumber;
  final int? status;
  final DateTime? createdAt;

  factory NylonDetailsGeneratedData.fromJson(Map<String, dynamic> json){
    return NylonDetailsGeneratedData(
      id: json["_id"],
      batchNumber: json["batchNumber"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
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



