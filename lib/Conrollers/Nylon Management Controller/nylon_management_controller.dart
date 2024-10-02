


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Admin%20Withdraw%20Request%20Model/admin_withdraw_request_list_model.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_count_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';

import '../../Models/Nylon Generation Model/Nylon Details Model/nylon_details_assigned_model.dart';
import '../../Models/Nylon Generation Model/Nylon Details Model/nylon_details_generated_model.dart';
import '../../Models/Nylon Generation Model/get_single_vendor_model.dart';
import '../../Models/Vendor Staff/Vendor Staff Waste Collected Model/get_vendor_staff_waste_collected_model.dart';

class NylonManagementController extends GetxController{


  /// get Nylon list  Api
  GetNylonDetailsAssignedModel? getNylonDetailsAssignedModel;
  Future<GetNylonDetailsAssignedModel?> getNylonDetailsApi(BuildContext context,page,limit,searchText) async {

    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getNylonDetails}?is_assigned=1&page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

          getNylonDetailsAssignedModel = GetNylonDetailsAssignedModel.fromJson(result);
          update();
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getNylonDetailsAssignedModel;
  }


  /// get Single Vendor Api
  GetSingleVendorModel? getSingleVendorModel;
  Future<GetSingleVendorModel?> getVendorListApi(BuildContext context,vendorId) async {

    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getSingleVendor}?id=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

        getSingleVendorModel = GetSingleVendorModel.fromJson(result);
        update();
      await  getVendorCollectionApi(context,getSingleVendorModel?.data?.id);
        update();
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getSingleVendorModel;
  }



  /// get Vendor Staff Collection Api
  GetVendorStaffCollectionListModel? getVendorStaffCollectionListModel;
  Future<GetVendorStaffCollectionListModel?> getVendorCollectionApi(context,vendorId) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getCollectionListApi}?requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print("aaaaaaaaaaaaaa${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetVendorStaffCollectionListModel.fromJson(result);
        getVendorStaffCollectionListModel = finalResult;
        update();
        // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorStaffCollectionListModel;
  }
}