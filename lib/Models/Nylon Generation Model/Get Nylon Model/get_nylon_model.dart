class GetNylonModel {
  GetNylonModel({
    required this.status,
    required this.isTokenExpired,
    required this.message,
    required this.data,
  });

  final bool? status;
  final bool? isTokenExpired;
  final String? message;
  final Data? data;

  factory GetNylonModel.fromJson(Map<String, dynamic> json){
    return GetNylonModel(
      status: json["status"],
      isTokenExpired: json["isTokenExpired"]==null?false:json["isTokenExpired"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.availableQty,
    required this.currentPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final int? availableQty;
  final int? currentPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      availableQty: json["availableQty"],
      currentPrice: json["currentPrice"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
