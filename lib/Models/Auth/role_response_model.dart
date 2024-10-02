class RoleResponseModel {
  RoleResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<RoleList> data;

  factory RoleResponseModel.fromJson(Map<String, dynamic> json){
    return RoleResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<RoleList>.from(json["data"]!.map((x) => RoleList.fromJson(x))),
    );
  }

}

class RoleList {
  RoleList({
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

  factory RoleList.fromJson(Map<String, dynamic> json){
    return RoleList(
      id: json["_id"],
      roleName: json["roleName"],
      status: json["status"],
      v: json["__v"],
      roleId: json["roleId"],
    );
  }

}
