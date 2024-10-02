

class GetAdminWithdrawRequestListModel {
  GetAdminWithdrawRequestListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<AdminWithdrawRequestListData> data;
  final Pagination? pagination;

  factory GetAdminWithdrawRequestListModel.fromJson(Map<String, dynamic> json){
    return GetAdminWithdrawRequestListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AdminWithdrawRequestListData>.from(json["data"]!.map((x) => AdminWithdrawRequestListData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class AdminWithdrawRequestListData {
  AdminWithdrawRequestListData({
    required this.id,
    required this.requestId,
    required this.requestedAmount,
    required this.companyName,
    required this.vendorCode,
    required this.status,
    required this.statusText,
  });

  final String? id;
  final int? requestId;
  final int? requestedAmount;
  final String? companyName;
  final String? vendorCode;
  final int? status;
  final String? statusText;

  factory AdminWithdrawRequestListData.fromJson(Map<String, dynamic> json){
    return AdminWithdrawRequestListData(
      id: json["_id"],
      requestId: json["requestId"],
      requestedAmount: json["requestedAmount"],
      companyName: json["companyName"],
      vendorCode: json["vendorCode"],
      status: json["status"],
      statusText: json["statusText"],
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
