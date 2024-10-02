class GetInvoiceModel {
  GetInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;
  final Pagination? pagination;

  factory GetInvoiceModel.fromJson(Map<String, dynamic> json){
    return GetInvoiceModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.orderId,
    required this.vendorId,
    required this.qty,
    required this.qtyPrice,
    required this.subTotal,
    required this.total,
    required this.paymentStatus,
    required this.orderStatus,
    required this.invoiceNo,
    required this.referenceNo,
    required this.createdAt,
    required this.paymentStatusText,
    required this.orderStatusText,
    required this.companyName,
    required this.vendorCode,
  });

  final String? id;
  final String? orderId;
  final VendorId? vendorId;
  final int? qty;
  final int? qtyPrice;
  final int? subTotal;
  final int? total;
  final int? paymentStatus;
  final int? orderStatus;
  final String? invoiceNo;
  final String? referenceNo;
  final String? createdAt;
  final String? paymentStatusText;
  final String? orderStatusText;
  final String? companyName;
  final String? vendorCode;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      orderId: json["orderId"],
      vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
      qty: json["qty"],
      qtyPrice: json["qty_price"],
      subTotal: json["sub_total"],
      total: json["total"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
      invoiceNo: json["invoiceNo"],
      referenceNo: json["referenceNo"],
      createdAt: json["createdAt"],
      paymentStatusText: json["paymentStatusText"],
      orderStatusText: json["orderStatusText"],
      companyName: json["companyName"],
      vendorCode: json["vendorCode"],
    );
  }

}

class VendorId {
  VendorId({
    required this.id,
    required this.companyName,
    required this.vendorCode,
  });

  final String? id;
  final String? companyName;
  final String? vendorCode;

  factory VendorId.fromJson(Map<String, dynamic> json){
    return VendorId(
      id: json["_id"],
      companyName: json["companyName"],
      vendorCode: json["vendorCode"],
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
