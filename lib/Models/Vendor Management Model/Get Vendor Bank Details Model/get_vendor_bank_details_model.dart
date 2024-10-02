class GetVendorBankDetailsModel {
  GetVendorBankDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetVendorBankDetailsModel.fromJson(Map<String, dynamic> json){
    return GetVendorBankDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
