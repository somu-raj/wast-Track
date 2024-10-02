class GetEcoBlueAdminUpdateDataModel {
  GetEcoBlueAdminUpdateDataModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<SubAdminListData> data;
  final Pagination? pagination;

  factory GetEcoBlueAdminUpdateDataModel.fromJson(Map<String, dynamic> json){
    return GetEcoBlueAdminUpdateDataModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SubAdminListData>.from(json["data"]!.map((x) => SubAdminListData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class SubAdminListData {
  SubAdminListData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.vendorId,
    required this.vendorCode,
    required this.website,
    required this.roleId,
    required this.isDeleted,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final dynamic vendorId;
  final dynamic vendorCode;
  final dynamic website;
  final String? roleId;
  final bool? isDeleted;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory SubAdminListData.fromJson(Map<String, dynamic> json){
    return SubAdminListData(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      vendorId: json["vendorId"],
      vendorCode: json["vendorCode"],
      website: json["website"],
      roleId: json["roleId"],
      isDeleted: json["isDeleted"],
      status: json["status"],
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
