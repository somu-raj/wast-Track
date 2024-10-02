import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../Models/Vendor/Area Alloted Model/get_area_alloted_model.dart';
import '../../Models/Vendor/Area Alloted Model/get_order_list_model.dart';
import '../../Models/Vendor/Area Alloted Model/get_vendor_batch_model.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
import '../../Utils/colors/app_colors.dart';

class AreaAllotedController extends GetxController{


  /// get Area Alloted Api
  GetAreaAllotedModel? getAreaAllotedModel;
  Future<GetAreaAllotedModel?> getAreaAllotedApi(BuildContext context,page,limit,searchText,vendorId) async {

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
        '${Endpoints.baseUrl}${Endpoints.areaAlloted}?page=$page&limit=$limit&searchText=$searchText&requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

        getAreaAllotedModel = GetAreaAllotedModel.fromJson(result);
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
    return getAreaAllotedModel;
  }

  /// get Area Alloted Api
  GetOrderModel? getOrderModel;
  Future<GetOrderModel?> getOrderListApi(BuildContext context,page,limit,searchText,vendorId) async {

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
        '${Endpoints.baseUrl}${Endpoints.getOrderList}?page=$page&limit=$limit&searchText=$searchText&requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

        getOrderModel = GetOrderModel.fromJson(result);
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
    return getOrderModel;
  }

  /// get Area Alloted Api
  GetVendorBatchListModel? getVendorBatchListModel;
  Future<GetVendorBatchListModel?> getVendorBatchListingApi(BuildContext context,vendorId) async {

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
        '${Endpoints.baseUrl}${Endpoints.getVendorBatchListing}?requestedVendorId=6639d3640c77173ccbb18f20',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

        getVendorBatchListModel = GetVendorBatchListModel.fromJson(result);
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
    return getVendorBatchListModel;
  }


  /// get area Assign Api
  areaAssignApi(BuildContext context,vendorId) async {

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
        '${Endpoints.baseUrl}${Endpoints.areaAssign}?id=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;
         getAreaAllotedApi(context, 1, 10, " ", vendorId);
        // getOrderModel = GetOrderModel.fromJson(result);
        update();
        if(result['status'] == false){

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
              return CupertinoAlertDialog(
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.green,
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${result['message'].toString()}",
                        style: TextStyle(fontSize: 15, color: AppColor.green),
                      ),
                    ),
                  ],
                ), // show pop-up
              );
            },
          );
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getOrderModel;
  }

}