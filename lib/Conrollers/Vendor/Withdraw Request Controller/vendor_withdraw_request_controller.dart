
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'hide Response;
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_get_collection_list_model.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_pending_request_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';

class  VendorWithdrawRequestController extends GetxController{


  RxBool  isLoading = false.obs;
  RxInt  withdrawnAmount = 0.obs ;
   RxList<bool> areOptionCheckedList =
      List.generate(10, (index) => false).obs;
  RxList checkedIds = [].obs;

   /* "serialIds":["6639ce850c77173ccbb18dd6","6639ce850c77173ccbb18dd5"]*/

  void toggleCheckBox(int index) {
    areOptionCheckedList[index] = !areOptionCheckedList[index];
    if(areOptionCheckedList[index]){
      withdrawnAmount.value += getVendorCollectionListModel?.data[index].revenuePrice??0;
      checkedIds.add(getVendorCollectionListModel?.data[index].id??"");
    }
    else{
      withdrawnAmount.value -= getVendorCollectionListModel?.data[index].revenuePrice??0;
      checkedIds.remove(getVendorCollectionListModel?.data[index].id??"");
    }
    debugPrint("checked ids ${checkedIds}");
  }
  void toggleSelectAll() {
    if(areOptionCheckedList.where((element) => element).length == areOptionCheckedList.length){
      withdrawnAmount.value = 0;
      checkedIds = [].obs;
      for(int i = 0; i<areOptionCheckedList.length;i++){
        areOptionCheckedList[i] = false;
      }
    }
    else{
      withdrawnAmount.value = 0;
      checkedIds = [].obs;
      for (int i = 0; i < areOptionCheckedList.length; i++) {
        areOptionCheckedList[i] = true;
        checkedIds.add(getVendorCollectionListModel?.data[i].id??"");
        withdrawnAmount.value += getVendorCollectionListModel?.data[i].revenuePrice??0;
      }
    }
    debugPrint("checked ids ${checkedIds}");
  }

  /// get api for withdraw pending request
  GetVendorWithdrawPendingRequestModel? getVendorWithdrawPendingRequestModel;
  Future<GetVendorWithdrawPendingRequestModel?> getVendorWithdrawPendingRequestApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.vendorGetWithdrawalAmount}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorWithdrawPendingRequestModel = GetVendorWithdrawPendingRequestModel.fromJson(result);
        if(!(getVendorWithdrawPendingRequestModel?.status??false)&&(getVendorWithdrawPendingRequestModel?.isTokenExpired??true)){
          CustomSnackBar.mySnackBar(
              context, "${getVendorWithdrawPendingRequestModel!.message}");
        }
        else{
          debugPrint("all vendor staff fetched!!!");
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
    return getVendorWithdrawPendingRequestModel;
  }

  /// get api for withdraw list
  GetVendorCollectionListModel? getVendorCollectionListModel;
  Future<GetVendorCollectionListModel?> getVendorCollectionListApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.vendorGetCollectionList}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorCollectionListModel = GetVendorCollectionListModel.fromJson(result);
        if(!(getVendorCollectionListModel?.status??false)&&(getVendorCollectionListModel?.isTokenExpired??true)){
          CustomSnackBar.mySnackBar(
              context, "${getVendorCollectionListModel!.message}");
        }
        else{
          debugPrint("all vendor staff fetched!!!");
          areOptionCheckedList.value = List.generate(getVendorCollectionListModel?.data.length??0, (index) => false);
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
    return getVendorCollectionListModel;
  }

  /// withdraw  request
  Future<void> vendorWithdrawRequestApi(BuildContext context) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    Object data = jsonEncode(
        {
          "serialIds": checkedIds
        }
    );
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.vendorWithdrawRequest}',
        options: Options(
          headers: headers,
        ),
        data: data
      );
      debugPrint("vendor request api response code == ${response.statusCode}");
      debugPrint("vendor request api data request  == ${response.requestOptions.data}");
      if (response.statusCode == 200) {
          dynamic result = response.data;
          debugPrint("response of withdraw request api ${response.data}");
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
          withdrawnAmount.value = 0;update();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }



}