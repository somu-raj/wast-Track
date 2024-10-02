class GetRevenueShareCountModel {
  GetRevenueShareCountModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetRevenueShareCountModel.fromJson(Map<String, dynamic> json){
    return GetRevenueShareCountModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.overall,
    required this.weekly,
    required this.monthly,
    required this.yearly,
  });

  final Monthly? overall;
  final Monthly? weekly;
  final Monthly? monthly;
  final Monthly? yearly;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      overall: json["overall"] == null ? null : Monthly.fromJson(json["overall"]),
      weekly: json["weekly"] == null ? null : Monthly.fromJson(json["weekly"]),
      monthly: json["monthly"] == null ? null : Monthly.fromJson(json["monthly"]),
      yearly: json["yearly"] == null ? null : Monthly.fromJson(json["yearly"]),
    );
  }

}

class Monthly {
  Monthly({
    required this.amount,
    required this.changePercentage,
  });

  final int? amount;
  final int? changePercentage;

  factory Monthly.fromJson(Map<String, dynamic> json){
    return Monthly(
      amount: json["amount"],
      changePercentage: json["changePercentage"],
    );
  }

}
