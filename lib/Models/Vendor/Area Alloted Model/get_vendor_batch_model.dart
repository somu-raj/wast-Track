class GetVendorBatchListModel {
  GetVendorBatchListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;

  factory GetVendorBatchListModel.fromJson(Map<String, dynamic> json){
    return GetVendorBatchListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.batchNumber,
  });

  final String? id;
  final String? batchNumber;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      batchNumber: json["batchNumber"],
    );
  }

}
