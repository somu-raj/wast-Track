
class GetNylonBuyDetailsModel {
  GetNylonBuyDetailsModel({
    required this.status,
    required this.isTokenExpired,
    required this.message,
    required this.data,
  });

  final bool? status;
  final bool? isTokenExpired;
  final String? message;
  final Data? data;

  factory GetNylonBuyDetailsModel.fromJson(Map<String, dynamic> json){
    return GetNylonBuyDetailsModel(
      status: json["status"],
      message: json["message"],
      isTokenExpired: json["isTokenExpired"]==null?false:json["isTokenExpired"],

      data: json["data"] == null ? null : Data.fromJson(json["data"]),

    );
  }

}

class Data {
  Data({
    required this.commisionInfo,
    required this.bankInfo,
    required this.vendorInfo,
    required this.nylonInfo,
    required this.previusQtyInfo,
    required this.productionCommisionPerQty,
  });

  final CommisionInfo? commisionInfo;
  final BankInfo? bankInfo;
  final VendorInfo? vendorInfo;
  final NylonInfo? nylonInfo;
  final PreviusQtyInfo? previusQtyInfo;
  final int? productionCommisionPerQty;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      commisionInfo: json["commisionInfo"] == null ? null : CommisionInfo.fromJson(json["commisionInfo"]),
      bankInfo: json["bankInfo"] == null ? null : BankInfo.fromJson(json["bankInfo"]),
      vendorInfo: json["vendorInfo"] == null ? null : VendorInfo.fromJson(json["vendorInfo"]),
      nylonInfo: json["nylonInfo"] == null ? null : NylonInfo.fromJson(json["nylonInfo"]),
      previusQtyInfo: json["previusQtyInfo"] == null ? null : PreviusQtyInfo.fromJson(json["previusQtyInfo"]),
      productionCommisionPerQty: json["productionCommisionPerQty"],
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
    required this.ifsc,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? bankName;
  final String? accountNumber;
  final String? accountHolderName;
  final String? iban;
  final String? ifsc;
  final String? vendorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory BankInfo.fromJson(Map<String, dynamic> json){
    return BankInfo(
      id: json["_id"],
      bankName: json["bankName"],
      accountNumber: json["accountNumber"],
      accountHolderName: json["accountHolderName"],
      iban: json["iban"],
      ifsc: json["ifsc"],
      vendorId: json["vendorId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class CommisionInfo {
  CommisionInfo({
    required this.id,
    required this.companyName,
    required this.sharingPercentage,
  });

  final String? id;
  final String? companyName;
  final int? sharingPercentage;

  factory CommisionInfo.fromJson(Map<String, dynamic> json){
    return CommisionInfo(
      id: json["_id"],
      companyName: json["companyName"],
      sharingPercentage: json["sharingPercentage"],
    );
  }

}

class NylonInfo {
  NylonInfo({
    required this.id,
    required this.currentPrice,
  });

  final String? id;
  final int? currentPrice;

  factory NylonInfo.fromJson(Map<String, dynamic> json){
    return NylonInfo(
      id: json["_id"],
      currentPrice: json["currentPrice"],
    );
  }

}

class PreviusQtyInfo {
  PreviusQtyInfo({
    required this.id,
    required this.qty,
  });

  final String? id;
  final int? qty;

  factory PreviusQtyInfo.fromJson(Map<String, dynamic> json){
    return PreviusQtyInfo(
      id: json["_id"],
      qty: json["qty"],
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
