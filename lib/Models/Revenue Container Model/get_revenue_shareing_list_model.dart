class GetRevenueShareListModel {
  GetRevenueShareListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;
  final Pagination? pagination;

  factory GetRevenueShareListModel.fromJson(Map<String, dynamic> json){
    return GetRevenueShareListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class Datum {
  Datum({
    required this.orderId,
    required this.createdAt,
    required this.vendorCode,
    required this.companyName,
    required this.orderTotal,
    required this.revenueEarned,
  });

  final String? orderId;
  final String? createdAt;
  final String? vendorCode;
  final String? companyName;
  final num? orderTotal;
  final int? revenueEarned;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      orderId: json["orderId"],
      createdAt: json["createdAt"],
      vendorCode: json["vendorCode"],
      companyName: json["companyName"],
      orderTotal: (json["orderTotal"] as num?)?.toInt(),
      revenueEarned: json["revenueEarned"],
    );
  }

}

class Pagination {
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
  });

  final int? totalItems;
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      totalItems: json["totalItems"],
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
    );
  }

}
