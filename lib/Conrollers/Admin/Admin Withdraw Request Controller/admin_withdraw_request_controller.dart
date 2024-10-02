


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Admin%20Withdraw%20Request%20Model/admin_withdraw_request_list_model.dart';
import 'package:waste_track/Models/Admin%20Withdraw%20Request%20Model/single%20_withdraw_request_details_model.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_count_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class AdminWithdrawRequestController extends GetxController{


  RxInt tabIndex = 0.obs;


  tabIndexChanging(index) async {
    tabIndex.value = index;
    debugPrint("orderType ${tabIndex.value}");

  }

  /// get api for withdraw request count
  GetVendorWithdrawRequestHistoryCountModel? getWithdrawRequestHistoryCountModel;
  Future<GetVendorWithdrawRequestHistoryCountModel?> getWithdrawRequestHistoryCountApi(BuildContext context) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    debugPrint("api called");
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
        '${Endpoints.baseUrl}${Endpoints.withdrawRequestHistoryCount}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getWithdrawRequestHistoryCountModel = GetVendorWithdrawRequestHistoryCountModel.fromJson(result);
        if(!(getWithdrawRequestHistoryCountModel?.status??false) || result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${getWithdrawRequestHistoryCountModel!.message}");
        }
        else{
          debugPrint("data fetched!!!");
          //areOptionVisibleList.value = List.generate(getVendorWithdrawPendingRequestModel?..length??0, (index) => false);
          // debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getWithdrawRequestHistoryCountModel;
  }
  //withdrawal/withdrawal-request-list?page=1&limit=10&searchText=&orderType=0
  /// get api for withdraw request list
  GetAdminWithdrawRequestListModel? getAdminWithdrawRequestListModel;
  Future<GetAdminWithdrawRequestListModel?> getVendorWithdrawRequestHistoryListApi(BuildContext context,page,limit,searchText) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    debugPrint("api called");
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
        '${Endpoints.baseUrl}${Endpoints.adminWithdrawRequestList}?page=1$page&limit=&$limit&searchText=$searchText&orderType=${tabIndex.value}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getAdminWithdrawRequestListModel = GetAdminWithdrawRequestListModel.fromJson(result);
        if(!(getAdminWithdrawRequestListModel?.status??false) || result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${getAdminWithdrawRequestListModel!.message}");
        }
        else{
          debugPrint("data list fetched!!!");
          // areOptionCheckedList.value = List.generate(getVendorWithdrawRequestHistoryListModel?.data.length??0, (index) => false);
          // debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getAdminWithdrawRequestListModel;
  }

  // RxString id = "".obs;
  // changeIdValue(String id,context) async {
  //   this.id.value = id;
  //   await getSingleWithdrawRequestApi(context);
  // }
  /// get api for single withdraw request
  GetAdminSingleWithdrawRequestModel? getAdminSingleWithdrawRequestModel;
  Future<GetAdminSingleWithdrawRequestModel?> getSingleWithdrawRequestApi(BuildContext context,id) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    debugPrint("single withdraw request api called");
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
        '${Endpoints.baseUrl}${Endpoints.adminSingleWithdrawRequest}?id=${id}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getAdminSingleWithdrawRequestModel = GetAdminSingleWithdrawRequestModel.fromJson(result);
        if(!(getWithdrawRequestHistoryCountModel?.status??false) || result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${getAdminSingleWithdrawRequestModel!.message}");
        }
        else{
          debugPrint("data fetched!!!");
          //areOptionVisibleList.value = List.generate(getVendorWithdrawPendingRequestModel?..length??0, (index) => false);
          // debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getAdminSingleWithdrawRequestModel;
  }

  RxBool isLoading = false.obs;
  ///update request status
  Future<void> updateWithdrawRequestStatusApi(BuildContext context,
      {String? id, int? status, String? reason}) async {
    showLoader(context);
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    Object data = jsonEncode(
        {
          "id":id,
          "order_status":status, // 1=accepted, 2=rejected,
          "reject_reason": reason // 1=accepted, 2=rejected,
        }
    );
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.post(
          '${Endpoints.baseUrl}${Endpoints.updateSingleWithdrawRequestStatus}',
          options: Options(
            headers: headers,
          ),
          data: data
      );
      debugPrint("update status api response code == ${response.statusCode}");
      debugPrint("update status api data request  == ${response.requestOptions.data}");
      if (response.statusCode == 200) {
        Navigator.pop(context);
        dynamic result = response.data;
        debugPrint("response of withdraw request api ${response.data}");
        if(!(result['status']??false)){
          Navigator.pop(context);
          CustomSnackBar.mySnackBar(context, "${result['message']}");
        }
        else{
          status == 1?
          showApprovedSuccessDialog(context):
          showRejectSuccessDialog(context);
        }
      } else {
        Navigator.pop(context);
        CustomSnackBar.mySnackBar(context, "Something went wrong!!");
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      Navigator.pop(context);
      CustomSnackBar.mySnackBar(context, "Something went wrong!!");
      print('Error: $error');
    }
  }
   showRejectSuccessDialog(context){
     showDialog(
       context: context,
       builder: (BuildContext context) {
         Future.delayed(Duration(seconds: 1),
                 () {
               Navigator.pop(context);
               Navigator.pop(context);
             });

         return CupertinoAlertDialog(
           title: Row(
             children: [
               Container(
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   borderRadius:
                   BorderRadius.circular(
                       30),
                   color: Colors.red
                       .withOpacity(0.1),
                 ),
                 child: Icon(
                   Icons.close,
                   color: Colors.red,
                 ),
               ),
               SizedBox(
                 width: 3,
               ),
               Flexible(
                 child: Text(
                   "Request Rejected Successfully.",
                   style: TextStyle(
                       fontSize: 14,
                       color: Colors.red),
                 ),
               ),
             ],
           ), // show pop-up
         );
       },
     );

   }
   showApprovedSuccessDialog(context){
     showDialog(
       context: context,
       builder: (BuildContext context) {
         Future.delayed(Duration(seconds: 1),
                 () {
               Navigator.pop(context);
               Navigator.pop(context);
             });

         return CupertinoAlertDialog(
           title: Row(
             children: [
               Container(
                 padding: EdgeInsets.all(9),
                 decoration: BoxDecoration(
                   borderRadius:
                   BorderRadius.circular(
                       30),
                   color: AppColor.green
                       .withOpacity(0.7),
                 ),
                 child: Icon(
                   Icons.done,
                   color: Colors.white,
                 ),
               ),
               SizedBox(
                 width: 3,
               ),
               Flexible(
                 child: Text(
                   "Request Approved Successfully.",
                   style: TextStyle(
                       fontSize: 13,
                       color: AppColor.green),
                 ),
               ),
             ],
           ), // show pop-up
         );
       },
     );

   }

   showLoader(context){
    showDialog(context: context,
        builder: (_){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: Get.height,
          width: Get.width,
          child: CupertinoActivityIndicator(
            color: AppColor.green,
            radius: 20,
          ),
        ),
      );
        });

   }


}