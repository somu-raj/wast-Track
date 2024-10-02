class GetAdminSingleWithdrawRequestModel {
  GetAdminSingleWithdrawRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetAdminSingleWithdrawRequestModel.fromJson(Map<String, dynamic> json){
    return GetAdminSingleWithdrawRequestModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.requestId,
    required this.requestedAmount,
    required this.status,
    required this.statusText,
    required this.requestedDate,
    required this.approvalDate,
    required this.rejectReason,
    required this.vendorCompanyName,
    required this.vendorCode,
    required this.vendorPhoneNumber,
    required this.vendorEmail,
    required this.vendorFirstName,
    required this.vendorLastName,
    required this.vendorCompanyAddress,
    required this.bankInfo,
    required this.uniqueId,
    required this.approvalId,
    required this.withdrawalId,
    required this.serialNumbers,
  });

  final String? id;
  final int? requestId;
  final int? requestedAmount;
  final int? status;
  final String? statusText;
  final String? requestedDate;
  final dynamic approvalDate;
  final dynamic rejectReason;
  final String? vendorCompanyName;
  final String? vendorCode;
  final String? vendorPhoneNumber;
  final String? vendorEmail;
  final String? vendorFirstName;
  final String? vendorLastName;
  final String? vendorCompanyAddress;
  final dynamic bankInfo;
  final dynamic uniqueId;
  final dynamic approvalId;
  final dynamic withdrawalId;
  final List<SerialNumber> serialNumbers;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      requestId: json["requestId"],
      requestedAmount: json["requestedAmount"],
      status: json["status"],
      statusText: json["statusText"],
      requestedDate: json["requestedDate"],
      approvalDate: json["approvalDate"],
      rejectReason: json["rejectReason"],
      vendorCompanyName: json["vendorCompanyName"],
      vendorCode: json["vendorCode"],
      vendorPhoneNumber: json["VendorPhoneNumber"],
      vendorEmail: json["VendorEmail"],
      vendorFirstName: json["VendorFirstName"],
      vendorLastName: json["VendorLastName"],
      vendorCompanyAddress: json["VendorCompanyAddress"],
      bankInfo: json["bankInfo"],
      uniqueId: json["uniqueId"],
      approvalId: json["approvalId"],
      withdrawalId: json["withdrawalId"],
      serialNumbers: json["serialNumbers"] == null ? [] : List<SerialNumber>.from(json["serialNumbers"]!.map((x) => SerialNumber.fromJson(x))),
    );
  }

}

class SerialNumber {
  SerialNumber({
    required this.id,
    required this.pricePerBag,
    required this.revenuePrice,
    required this.serialNumber,
    required this.collectedDate,
  });

  final String? id;
  final int? pricePerBag;
  final int? revenuePrice;
  final String? serialNumber;
  final String? collectedDate;

  factory SerialNumber.fromJson(Map<String, dynamic> json){
    return SerialNumber(
      id: json["_id"],
      pricePerBag: json["pricePerBag"],
      revenuePrice: json["revenuePrice"],
      serialNumber: json["serialNumber"],
      collectedDate: json["collectedDate"],
    );
  }

}
