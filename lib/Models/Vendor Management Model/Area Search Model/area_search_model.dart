class GetAreaSearchModel {
  GetAreaSearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<AreaData> data;

  factory GetAreaSearchModel.fromJson(Map<String, dynamic> json){
    return GetAreaSearchModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<AreaData>.from(json["data"]!.map((x) => AreaData.fromJson(x))),
    );
  }

}

class AreaData {
  AreaData({
    required this.id,
    required this.areaName,
    required this.isAlreadyAssigned,
  });

  final String? id;
  final String? areaName;
  final bool? isAlreadyAssigned;

  factory AreaData.fromJson(Map<String, dynamic> json){
    return AreaData(
      id: json["_id"],
      areaName: json["areaName"],
      isAlreadyAssigned: json["isAlreadyAssigned"],
    );
  }

}
