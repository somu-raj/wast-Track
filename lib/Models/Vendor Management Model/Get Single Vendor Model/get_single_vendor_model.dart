class GetSingleVendorModel {
  GetSingleVendorModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetSingleVendorModel.fromJson(Map<String, dynamic> json){
    return GetSingleVendorModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyAddress,
    required this.vendorId,
    required this.vendorCode,
    required this.website,
    required this.areaId,
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
  final String? companyName;
  final String? companyAddress;
  final dynamic vendorId;
  final String? vendorCode;
  final String? website;
  final String? areaId;
  final String? roleId;
  final bool? isDeleted;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
      vendorId: json["vendorId"],
      vendorCode: json["vendorCode"],
      website: json["website"],
      areaId: json["areaId"],
      roleId: json["roleId"],
      isDeleted: json["isDeleted"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
