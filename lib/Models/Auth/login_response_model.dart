class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.message,
    required this.token,
    required this.data,
  });

  final bool? status;
  final String? message;
  final String? token;
  final Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(
      status: json["status"],
      message: json["message"],
      token: json["token"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyAddress,
    required this.roleInfo,
    required this.imageName,
    required this.imageBaseUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? companyAddress;
  final RoleInfo? roleInfo;
  final String? imageName;
  final String? imageBaseUrl;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
      roleInfo: json["roleInfo"] == null ? null : RoleInfo.fromJson(json["roleInfo"]),
      imageName: json["imageName"],
      imageBaseUrl: json["imageBaseUrl"],
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
