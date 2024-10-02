class GetVendorWithdrawRequestHistoryListModel {
  GetVendorWithdrawRequestHistoryListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<GetVendorWithdrawRequestHistoryListData> data;
  final Pagination? pagination;

  factory GetVendorWithdrawRequestHistoryListModel.fromJson(Map<String, dynamic> json){
    return GetVendorWithdrawRequestHistoryListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<GetVendorWithdrawRequestHistoryListData>.from(json["data"]!.map((x) => GetVendorWithdrawRequestHistoryListData.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class GetVendorWithdrawRequestHistoryListData {
  GetVendorWithdrawRequestHistoryListData({
    required this.id,
    required this.requestId,
    required this.requestedAmount,
    required this.requestedDate,
    required this.approvalDate,
    required this.rejectReason,
    required this.status,
    required this.statusText,
  });

  final String? id;
  final int? requestId;
  final int? requestedAmount;
  final String? requestedDate;
  final dynamic approvalDate;
  final dynamic rejectReason;
  final int? status;
  final String? statusText;

  factory GetVendorWithdrawRequestHistoryListData.fromJson(Map<String, dynamic> json){
    return GetVendorWithdrawRequestHistoryListData(
      id: json["_id"],
      requestId: json["requestId"],
      requestedAmount: json["requestedAmount"],
      requestedDate: json["requestedDate"],
      approvalDate: json["approvalDate"],
      rejectReason: json["rejectReason"],
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
