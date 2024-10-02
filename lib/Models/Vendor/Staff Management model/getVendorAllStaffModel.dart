class GetVendorAllStaffModel {
  GetVendorAllStaffModel({
    required this.status,
    required this.isTokenExpired,
    required this.message,
    required this.vendorAllStaffData,
    required this.pagination,
  });

  final bool? status;
  final bool? isTokenExpired;
  final String? message;
  final List<VendorAllStaffData> vendorAllStaffData;
  final Pagination? pagination;

  factory GetVendorAllStaffModel.fromJson(Map<String, dynamic> json){
    return GetVendorAllStaffModel(
      status: json["status"],
      isTokenExpired: json["isTokenExpired"] == null?false:json["isTokenExpired"],
      message: json["message"],
      vendorAllStaffData: json["data"] == null ? [] : List<VendorAllStaffData>.from(json["data"]!.map((x) => VendorAllStaffData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class VendorAllStaffData {
  VendorAllStaffData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.vendorId,
    required this.vendorCode,
    required this.website,
    required this.areaId,
    required this.roleId,
    required this.isDeleted,
    required this.rejectedDate,
    required this.approvedDate,
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
  final String? vendorId;
  final dynamic vendorCode;
  final dynamic website;
  final dynamic areaId;
  final String? roleId;
  final bool? isDeleted;
  final dynamic rejectedDate;
  final dynamic approvedDate;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory VendorAllStaffData.fromJson(Map<String, dynamic> json){
    return VendorAllStaffData(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      vendorId: json["vendorId"],
      vendorCode: json["vendorCode"],
      website: json["website"],
      areaId: json["areaId"],
      roleId: json["roleId"],
      isDeleted: json["isDeleted"],
      rejectedDate: json["rejectedDate"],
      approvedDate: json["approvedDate"],
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
