

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import '../../../API Integration/app_base_controller.dart';
import '../../../Models/Revenue Container Model/get_revenue_share_all_Model.dart';
import '../../../Models/Revenue Container Model/get_revenue_share_count_model.dart';
import '../../../Models/Revenue Container Model/get_revenue_share_model.dart';
import '../../../Models/Revenue Container Model/get_revenue_shareing_list_model.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class RevenueController extends AppBaseController {
  final BuildContext context;
  RevenueController({required this.context}); // Constructor
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRevenueShareApi(context);
    await  getRevenueShareAllApi(context);
    getRevenueShareCountApi(context,getRevenueShareAllModel?.data.first.id ?? "",);
    getRevenueShareListApi(context, "1", '10','',getRevenueShareAllModel?.data.first.id??"",);


  }

  /// getRevenueApi
  ///

  List<TextEditingController> parentageControllers = [];
  addControllers(){
    if(getRevenueShareModel?.data != null){
      for (int i = 0; i < getRevenueShareModel!.data.length; i++) {
        parentageControllers.add(TextEditingController());
      }
    }
  }
  /// get RevenueSharingApi
  GetRevenueShareModel? getRevenueShareModel;
  Future<GetRevenueShareModel?> getRevenueShareApi(BuildContext context,) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print("headers: ${headers}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.revenueShare}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("this response${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetRevenueShareModel.fromJson(result);
        getRevenueShareModel = finalResult;
        addControllers();
        debugPrint("message ${getRevenueShareModel!.message}");
        update();
        //CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getRevenueShareModel;
  }





  /// updateRevenueShareApi
  Future<void> updateRevenueShareApi() async {
    if (getRevenueShareModel?.data != null && getRevenueShareModel!.data.isNotEmpty) {
      for (int i = 0; i < parentageControllers.length; i++) {
        String percentage = parentageControllers[i].text;
        if (percentage.isNotEmpty) {
          getRevenueShareModel!.data[i].sharingPercentage = int.parse(percentage);
        }
      }
    } else {
      print('Error: getRevenueShareModel?.data is null or empty');
      return;
    }
    isLoading = true;
    var data = {
      "revenueItems": getRevenueShareModel!.data!.map((item) => {
        "_id": item.id,
        "companyName": item.companyName,
        "sharingPercentage": item.sharingPercentage,
        "roleId": item.roleId
      }).toList()
    };
    var userToken = await SharedPref().getToken();
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response<dynamic> response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.updateRevenueShareList}',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      debugPrint("response: ${response.data}");

      if (response.statusCode == 200) {
        var responseData = response.data;
        var message = responseData['message'];
        isLoading = false;
        update();

        if (responseData['error'] == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 1000), () {
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
                        "${message}",
                        style: TextStyle(fontSize: 15, color: AppColor.green),
                      ),
                    ),
                  ],
                ), // show pop-up
              );
            },
          );
        }
      } else {
        isLoading = false;
        update();
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      isLoading = false;
      update();
      print('Error: $error');
    }
  }

  /// get Revenue Share List Api
  GetRevenueShareListModel? getRevenueShareListModel;
  Future<GetRevenueShareListModel?> getRevenueShareListApi(context,page,limit,searchText,revenueModelId) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print("headers: ${headers}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.revenueShareList}?page=$page&limit=$limit&searchText=$searchText&revenueModelId=$revenueModelId',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("this response${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetRevenueShareListModel.fromJson(result);
        getRevenueShareListModel = finalResult;
        addControllers();
        update();
        //CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getRevenueShareListModel;
  }


  /// get Revenue Share Count Api
  GetRevenueShareCountModel? getRevenueShareCountModel;
  Future<GetRevenueShareCountModel?> getRevenueShareCountApi(context,revenueModelId) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print("headers: ${headers}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.revenueShareCount}?revenueModelId=$revenueModelId',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("this response${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetRevenueShareCountModel.fromJson(result);
        getRevenueShareCountModel = finalResult;
        addControllers();
        update();
        // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getRevenueShareCountModel;
  }


  /// get Revenue Share All Api
  GetRevenueShareAllModel? getRevenueShareAllModel;
  Future<GetRevenueShareAllModel?> getRevenueShareAllApi(BuildContext context,) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token',
    };
    print("headers: ${headers}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.revenueShareAll}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("this response${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetRevenueShareAllModel.fromJson(result);
        getRevenueShareAllModel = finalResult;
        addControllers();

        update();
        //CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getRevenueShareAllModel;
  }

}