class GetVendorStaffCollectionListModel {
  GetVendorStaffCollectionListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<Datum> data;
  final Pagination? pagination;

  factory GetVendorStaffCollectionListModel.fromJson(Map<String, dynamic> json){
    return GetVendorStaffCollectionListModel(
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
    required this.status,
    required this.statusText,
    required this.serialNumber,
    required this.batchNumber,
    required this.contactNo,
    required this.name,
    required this.collectedDate,
  });

  final String? id;
  final int? status;
  final String? statusText;
  final String? serialNumber;
  final String? batchNumber;
  final String? contactNo;
  final String? name;
  final String? collectedDate;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      status: json["status"],
      statusText: json["statusText"],
      serialNumber: json["serialNumber"],
      batchNumber: json["batchNumber"],
      contactNo: json["contactNo"],
      name: json["name"],
      collectedDate: json["collectedDate"],
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
