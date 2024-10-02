class GetVendorsModel {
  GetVendorsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<VendorsData> data;
  final Pagination? pagination;

  factory GetVendorsModel.fromJson(Map<String, dynamic> json){
    return GetVendorsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<VendorsData>.from(json["data"]!.map((x) => VendorsData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class VendorsData {
  VendorsData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyAddress,
    required this.vendorId,
    required this.areaId,
    required this.vendorCode,
    required this.website,
    required this.roleId,
    required this.isDeleted,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.rejectedDate,
    required this.v,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? companyAddress;
  final dynamic vendorId;
  final String? areaId;
  final String? vendorCode;
  final String? website;
  final String? roleId;
  final bool? isDeleted;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? rejectedDate;
  final int? v;

  factory VendorsData.fromJson(Map<String, dynamic> json){
    return VendorsData(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
      vendorId: json["vendorId"],
      areaId: json["areaId"],
      vendorCode: json["vendorCode"],
      website: json["website"],
      roleId: json["roleId"],
      isDeleted: json["isDeleted"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      rejectedDate: DateTime.tryParse(json["rejectedDate"] ?? ""),
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
