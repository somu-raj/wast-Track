class GetRevenueShareAllModel {
  GetRevenueShareAllModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;

  factory GetRevenueShareAllModel.fromJson(Map<String, dynamic> json){
    return GetRevenueShareAllModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.companyName,
  });

  final String? id;
  final String? companyName;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      companyName: json["companyName"],
    );
  }

}
