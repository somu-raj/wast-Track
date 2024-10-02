class GetNotificationModel {
  GetNotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;

  factory GetNotificationModel.fromJson(Map<String, dynamic> json){
    return GetNotificationModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.message,
    required this.referenceCollectionId,
    required this.type,
    required this.createdAt,
  });

  final String? id;
  final String? title;
  final String? message;
  final String? referenceCollectionId;
  final String? type;
  final DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      title: json["title"],
      message: json["message"],
      referenceCollectionId: json["reference_collection_id"],
      type: json["type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
