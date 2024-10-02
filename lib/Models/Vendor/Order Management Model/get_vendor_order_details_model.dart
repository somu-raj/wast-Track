class GetVendorOrderDetailsModel {
  GetVendorOrderDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetVendorOrderDetailsModel.fromJson(Map<String, dynamic> json){
    return GetVendorOrderDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.orderId,
    required this.vendorId,
    required this.qty,
    required this.qtyPrice,
    required this.subTotal,
    required this.revisionCommissionPercentage,
    required this.revisionCommissionAmount,
    required this.nylonProdCommissionPerrollAmount,
    required this.nylonProdCommissionTotalAmount,
    required this.orderTotal,
    required this.total,
    required this.perQtyQrcodePrice,
    required this.vendorPickupPercentage,
    required this.orderTotalAfterNylonProdCommission,
    required this.orderTotalAfterVendorPurchaseCommission,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.invoiceNo,
    required this.referenceNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.vendorInfo,
    required this.orderStatusText,
    required this.paymentStatusText,
    required this.orderSharing,
  });

  final String? id;
  final String? orderId;
  final String? vendorId;
  final int? qty;
  final int? qtyPrice;
  final int? subTotal;
  final int? revisionCommissionPercentage;
  final int? revisionCommissionAmount;
  final int? nylonProdCommissionPerrollAmount;
  final int? nylonProdCommissionTotalAmount;
  final int? orderTotal;
  final int? total;
  final int? perQtyQrcodePrice;
  final int? vendorPickupPercentage;
  final int? orderTotalAfterNylonProdCommission;
  final int? orderTotalAfterVendorPurchaseCommission;
  final String? paymentMethod;
  final int? paymentStatus;
  final int? orderStatus;
  final String? invoiceNo;
  final String? referenceNo;
  final String? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final VendorInfo? vendorInfo;
  final String? orderStatusText;
  final String? paymentStatusText;
  final List<OrderSharing> orderSharing;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      orderId: json["orderId"],
      vendorId: json["vendorId"],
      qty: json["qty"],
      qtyPrice: json["qty_price"],
      subTotal: json["sub_total"],
      revisionCommissionPercentage: json["revision_commission_percentage"],
      revisionCommissionAmount: json["revision_commission_amount"],
      nylonProdCommissionPerrollAmount: json["nylon_prod_commission_perroll_amount"],
      nylonProdCommissionTotalAmount: json["nylon_prod_commission_total_amount"],
      orderTotal: json["order_total"],
      total: json["total"],
      perQtyQrcodePrice: json["per_qty_qrcode_price"],
      vendorPickupPercentage: json["vendor_pickup_percentage"],
      orderTotalAfterNylonProdCommission: json["order_total_after_nylon_prod_commission"],
      orderTotalAfterVendorPurchaseCommission: json["order_total_after_vendor_purchase_commission"],
      paymentMethod: json["payment_method"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
      invoiceNo: json["invoiceNo"],
      referenceNo: json["referenceNo"],
      createdAt: json["createdAt"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      vendorInfo: json["vendorInfo"] == null ? null : VendorInfo.fromJson(json["vendorInfo"]),
      orderStatusText: json["orderStatusText"],
      paymentStatusText: json["paymentStatusText"],
      orderSharing: json["orderSharing"] == null ? [] : List<OrderSharing>.from(json["orderSharing"]!.map((x) => OrderSharing.fromJson(x))),
    );
  }

}

class OrderSharing {
  OrderSharing({
    required this.id,
    required this.sharingPercentage,
    required this.sharingAmount,
    required this.revenueModelId,
    required this.companyName,
  });

  final String? id;
  final int? sharingPercentage;
  final int? sharingAmount;
  final RevenueModelId? revenueModelId;
  final String? companyName;

  factory OrderSharing.fromJson(Map<String, dynamic> json){
    return OrderSharing(
      id: json["_id"],
      sharingPercentage: json["sharingPercentage"],
      sharingAmount: json["sharingAmount"],
      revenueModelId: json["revenueModelId"] == null ? null : RevenueModelId.fromJson(json["revenueModelId"]),
      companyName: json["companyName"],
    );
  }

}

class RevenueModelId {
  RevenueModelId({
    required this.id,
    required this.companyName,
    required this.roleId,
  });

  final String? id;
  final String? companyName;
  final String? roleId;

  factory RevenueModelId.fromJson(Map<String, dynamic> json){
    return RevenueModelId(
      id: json["_id"],
      companyName: json["companyName"],
      roleId: json["roleId"],
    );
  }

}

class VendorInfo {
  VendorInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyAddress,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? companyAddress;

  factory VendorInfo.fromJson(Map<String, dynamic> json){
    return VendorInfo(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
    );
  }

}
