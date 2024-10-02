class GetNylonProductionModel {
  GetNylonProductionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetNylonProductionModel.fromJson(Map<String, dynamic> json){
    return GetNylonProductionModel(
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
    required this.companyName,
    required this.companyAddress,
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
  final String? companyName;
  final String? companyAddress;
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
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
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
    required this.revenueModelId,
    required this.roleName,
    required this.status,
    required this.activeRole,
    required this.roleOrder,
    required this.revenueOrder,
    required this.activeRevenue,
    required this.v,
    required this.roleId,
  });

  final String? id;
  final String? revenueModelId;
  final String? roleName;
  final int? status;
  final int? activeRole;
  final int? roleOrder;
  final int? revenueOrder;
  final int? activeRevenue;
  final int? v;
  final String? roleId;

  factory RoleInfo.fromJson(Map<String, dynamic> json){
    return RoleInfo(
      id: json["_id"],
      revenueModelId: json["revenueModelId"],
      roleName: json["roleName"],
      status: json["status"],
      activeRole: json["activeRole"],
      roleOrder: json["roleOrder"],
      revenueOrder: json["revenueOrder"],
      activeRevenue: json["activeRevenue"],
      v: json["__v"],
      roleId: json["roleId"],
    );
  }

}
