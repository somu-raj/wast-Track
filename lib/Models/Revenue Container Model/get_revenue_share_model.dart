class GetRevenueShareModel {
  GetRevenueShareModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<RevenueList> data;

  factory GetRevenueShareModel.fromJson(Map<String, dynamic> json){
    return GetRevenueShareModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<RevenueList>.from(json["data"]!.map((x) => RevenueList.fromJson(x))),
    );
  }

}

class RevenueList {
  RevenueList({
    required this.id,
    required this.companyName,
    required this.sharingPercentage,
    required this.roleId,
    required this.sharingType,
  });

  final String? id;
  final String? companyName;
   int? sharingPercentage;
  final String? roleId;
  final int? sharingType;

  factory RevenueList.fromJson(Map<String, dynamic> json){
    return RevenueList(
      id: json["_id"],
      companyName: json["companyName"],
      sharingPercentage: json["sharingPercentage"],
      roleId: json["roleId"],
      sharingType: json["sharingType"],
    );
  }

}
