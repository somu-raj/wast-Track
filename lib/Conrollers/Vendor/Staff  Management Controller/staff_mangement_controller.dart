import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/Models/Vendor/Staff%20Management%20model/getVendorAllStaffModel.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';

import '../../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../../Utils/colors/app_colors.dart';

class StaffManagementController extends GetxController {
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  }
  var isContainerVisible = true.obs;
  RxBool  isLoading = false.obs;
  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
  showLoader(context){
    return showDialog(context: context,
        builder: (_){
          return CupertinoActivityIndicator(
            color: AppColor.trackCircle,
          );
        });
  }

  ///add_staff_api
Future<void> addStaffApi(context,firstName,lastName,email,phoneNumber,password) async {
    showLoader(context);
    isLoading = true.obs;
    update();
  var userToken = await SharedPref().getToken();
  var token = "${userToken}";
  var headers = {
    'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
  };
  var data = json.encode({
    "vendorId":"",
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password
  });
  debugPrint('data==> $data');
  var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  var response = await dio.request(
    '${Endpoints.baseUrl}${Endpoints.addVendorStaff}',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
    data: data,
  );
  if (response.statusCode == 200) {
    Navigator.pop(context);
    var responseData = response.data;
    if(responseData["status"]){
      isLoading = false.obs;
      update();
     showSuccessDialog(context);
    }
    CustomSnackBar.mySnackBar(context, responseData["message"]);
  }
  else{
    isLoading = false.obs;
    update();
    CustomSnackBar.mySnackBar(context, "something went wrong!! Please login again");
  }
}
  ///add success dialog
showSuccessDialog(context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 1), () {
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
                "Staff Added Successfully",
                style: TextStyle(
                    fontSize: 15, color: AppColor.green),
              ),
            ),
          ],
        ), // show pop-up
      );
    },
  );
}


  ///get all vendor staff api
  GetVendorAllStaffModel? getVendorAllStaffModel;
  Future<GetVendorAllStaffModel?> getVendorAllStaffApi(BuildContext context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getVendorStaff}?page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
         dynamic result = response.data;
         getVendorAllStaffModel = GetVendorAllStaffModel.fromJson(result);
        if(!(getVendorAllStaffModel?.status??false)&&(getVendorAllStaffModel?.isTokenExpired??true)){
          CustomSnackBar.mySnackBar(
              context, "${getVendorAllStaffModel!.message}");
        }
        else{
          debugPrint("all vendor staff fetched!!!");
          areOptionVisibleList.value = List.generate(getVendorAllStaffModel?.vendorAllStaffData.length??0, (index) => false);
          debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorAllStaffModel;
  }

  ///update_staff_api
  Future<void> updateStaffApi(context,id,firstName,lastName,email,phoneNumber) async {
    showLoader(context);
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "vendorId":"",
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": ""
    });
    debugPrint('data==> $data');
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateVendorStaff}?id=$id',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    /*success response :{
    "status": true,
  "message": "Vendor staff has been added successfully"
}*/
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var responseData = response.data;
      if(responseData["status"]){
        showUpdateSuccess(context);
      }
      CustomSnackBar.mySnackBar(context, responseData["message"]);
    }
    else{
      CustomSnackBar.mySnackBar(context, "something went wrong!! Please login again");
    }
  }
  /// update success dialog
  showUpdateSuccess (context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
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
                  " Changes Saved Successfully",
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColor.green),
                ),
              ),
            ],
          ), // show pop-up
        );
      },

    );
  }

  ///delete staff api
//delete-vendor-staff?id=65eec9fec44c5dfba2059723
  Future<void> deleteStaffApi(context,id) async {
    showLoader(context);
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
        '${Endpoints.baseUrl}${Endpoints.deleteVendorStaff}?id=$id',
        options: Options(
          headers: headers,
        ),
      );
      /*response: {
    "status": true,
    "message": "Vendor staff deleted successfully."
        }*/
      if (response.statusCode == 200) {
        Navigator.pop(context);
        dynamic result = response.data;
           if(result['status']){
             showDeleteSuccess(context);
           }
           else{
             CustomSnackBar.mySnackBar(
                 context, "${result["message"]}");
           }
         update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
/// delete success dialog
showDeleteSuccess(context){
  showDialog(
    context: context,
    builder:
        (BuildContext context) {
      Future.delayed(
          Duration(seconds: 1),
              () {
            Navigator.pop(context);
            Navigator.pop(context);
          });

      return CupertinoAlertDialog(
        title: Row(
          children: [
            Container(
              padding:
              EdgeInsets
                  .all(10),
              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                    30),
                color: AppColor
                    .green,
              ),
              child: Icon(
                Icons.done,
                color: Colors
                    .white,
              ),
            ),
            Flexible(
              child: Text(
                " User Deleted Successfully",
                style: TextStyle(
                    fontSize:
                    15,
                    color: AppColor
                        .green),
              ),
            ),
          ],
        ), // show pop-up
      );
    },
  );
}
}
