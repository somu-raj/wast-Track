class GetWasteAgencyModel {
  GetWasteAgencyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetWasteAgencyModel.fromJson(Map<String, dynamic> json){
    return GetWasteAgencyModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.revenueModelId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.roleInfo,
    required this.imageName,
    required this.imageBaseUrl,
    required this.joiningDate,
  });

  final String? id;
  final String? revenueModelId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final RoleInfo? roleInfo;
  final String? imageName;
  final String? imageBaseUrl;
  final String? joiningDate;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      revenueModelId: json["revenueModelId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      roleInfo: json["roleInfo"] == null ? null : RoleInfo.fromJson(json["roleInfo"]),
      imageName: json["imageName"],
      imageBaseUrl: json["imageBaseUrl"],
      joiningDate: json["joiningDate"],
    );
  }

}

class RoleInfo {
  RoleInfo({
    required this.id,
    required this.roleName,
    required this.status,
    required this.v,
    required this.roleId,
  });

  final String? id;
  final String? roleName;
  final int? status;
  final int? v;
  final String? roleId;

  factory RoleInfo.fromJson(Map<String, dynamic> json){
    return RoleInfo(
      id: json["_id"],
      roleName: json["roleName"],
      status: json["status"],
      v: json["__v"],
      roleId: json["roleId"],
    );
  }

}
