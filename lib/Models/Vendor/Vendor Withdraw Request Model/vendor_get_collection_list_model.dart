class GetVendorCollectionListModel {
  GetVendorCollectionListModel({
    required this.status,
    required this.isTokenExpired,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final bool? isTokenExpired;
  final String? message;
  final List<Datum> data;
  final Pagination? pagination;

  factory GetVendorCollectionListModel.fromJson(Map<String, dynamic> json){
    return GetVendorCollectionListModel(
      status: json["status"],
      isTokenExpired: json["isTokenExpired"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      pricePerBag: json["pricePerBag"],
      revenuePrice: json["revenuePrice"],
      serialNumber: json["serialNumber"],
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
