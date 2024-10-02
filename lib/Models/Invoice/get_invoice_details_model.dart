class GetInvoiceDetailsModel {
  GetInvoiceDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetInvoiceDetailsModel.fromJson(Map<String, dynamic> json){
    return GetInvoiceDetailsModel(
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
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.vatTaxPercentage,
    required this.vatTaxAmount,
    required this.totalWithVatTax,
    required this.invoiceNo,
    required this.referenceNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.bankInfo,
    required this.companyInfo,
  });

  final String? id;
  final String? orderId;
  final VendorId? vendorId;
  final int? qty;
  final int? qtyPrice;
  final int? subTotal;
  final int? revisionCommissionPercentage;
  final int? revisionCommissionAmount;
  final int? total;
  final String? paymentMethod;
  final int? paymentStatus;
  final int? orderStatus;
  final double? vatTaxPercentage;
  final int? vatTaxAmount;
  final int? totalWithVatTax;
  final String? invoiceNo;
  final String? referenceNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final BankInfo? bankInfo;
  final CompanyInfo? companyInfo;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      orderId: json["orderId"],
      vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
      qty: json["qty"],
      qtyPrice: json["qty_price"],
      subTotal: json["sub_total"],
      revisionCommissionPercentage: json["revision_commission_percentage"],
      revisionCommissionAmount: json["revision_commission_amount"],
      total: json["total"],
      paymentMethod: json["payment_method"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
      vatTaxPercentage: json["vatTaxPercentage"],
      vatTaxAmount: json["vatTaxAmount"],
      totalWithVatTax: json["totalWithVatTax"],
      invoiceNo: json["invoiceNo"],
      referenceNo: json["referenceNo"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      bankInfo: json["bankInfo"] == null ? null : BankInfo.fromJson(json["bankInfo"]),
      companyInfo: json["companyInfo"] == null ? null : CompanyInfo.fromJson(json["companyInfo"]),
    );
  }

}

class BankInfo {
  BankInfo({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
    required this.iban,
  });

  final String? id;
  final String? bankName;
  final String? accountNumber;
  final String? accountHolderName;
  final String? iban;

  factory BankInfo.fromJson(Map<String, dynamic> json){
    return BankInfo(
      id: json["_id"],
      bankName: json["bankName"],
      accountNumber: json["accountNumber"],
      accountHolderName: json["accountHolderName"],
      iban: json["iban"],
    );
  }

}

class CompanyInfo {
  CompanyInfo({
    required this.brandName,
    required this.companyName,
    required this.companyAddress,
    required this.companyPhoneNo,
    required this.companyEmail,
  });

  final String? brandName;
  final String? companyName;
  final String? companyAddress;
  final String? companyPhoneNo;
  final String? companyEmail;

  factory CompanyInfo.fromJson(Map<String, dynamic> json){
    return CompanyInfo(
      brandName: json["brandName"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
      companyPhoneNo: json["companyPhoneNo"],
      companyEmail: json["companyEmail"],
    );
  }

}

class VendorId {
  VendorId({
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

  factory VendorId.fromJson(Map<String, dynamic> json){
    return VendorId(
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
