class SubAdminUpdateDataModel {
  SubAdminUpdateDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory SubAdminUpdateDataModel.fromJson(Map<String, dynamic> json){
    return SubAdminUpdateDataModel(
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
    required this.vendorId,
    required this.vendorCode,
    required this.website,
    required this.roleId,
    required this.isDeleted,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.phoneNumber,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic vendorId;
  final dynamic vendorCode;
  final dynamic website;
  final String? roleId;
  final bool? isDeleted;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? phoneNumber;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      vendorId: json["vendorId"],
      vendorCode: json["vendorCode"],
      website: json["website"],
      roleId: json["roleId"],
      isDeleted: json["isDeleted"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      phoneNumber: json["phoneNumber"],
    );
  }

}
