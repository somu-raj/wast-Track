



import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Area%20Search%20Model/area_search_model.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../Models/Vendor Management Model/Get Vendor Staff Model/get_vendor_staff_colleted_list_model.dart';
import '../../../Models/Vendor Management Model/Get Vendor Staff Model/get_vendor_staff_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class VendorStaffController extends AppBaseController {
  String? vendorId;
  final BuildContext context; // Receive context in the constructor

  VendorStaffController({required this.context}); // Constructor
  bool isLoading = false;
  String? subAdmin;
  @override
  Future<void> onInit() async {
    super.onInit();
    getVendorStaffApi(context,"1","10","");
  }

  /// addVendorStaffApi
  Future<void> addVendorStaffApi(String email, password, firstName, lastName, phoneNumber, context) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var requestData = {
      "firstName": firstName.toString(),
      "lastName": lastName.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phoneNumber": phoneNumber.toString(),
      "vendorId" : vendorId.toString()
    };
    var url = '${Endpoints.baseUrl}${Endpoints.addVendorStaff}';
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(requestData), // Encode the request data as JSON
      );
      debugPrint("this Is StatusCode ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['status'] == true) {
          myShimmer();
          isLoading = false;
          update();
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
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "${result['message']}",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.green),
                      ),
                    ),
                  ],
                ), // show pop-up
              );
            },
          );
          update();
        } else {
          isLoading = false;
          update(); // Update the state to reflect the loading state
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        }
      } else {
        isLoading = false;
        update(); // Update the state to reflect the loading state
        print("Failed with status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        throw Exception("Something went Wrong!!");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error: $e");
      throw Exception("Something went Wrong!!");
    }
  }

  /// getVendorStaffApi
  GeVendorStaffModel? geVendorStaffModel;
  Future<GeVendorStaffModel?> getVendorStaffApi(BuildContext context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getVendorStaff}?page=$page&limit=$limit&searchText=${searchText}',
        options: Options(
          headers: headers,
        ),
      );
      print("this is a re${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GeVendorStaffModel.fromJson(result);
          geVendorStaffModel = finalResult;
          update();
         CustomSnackBar.mySnackBar(context, "${finalResult.message}");
        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");

        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return geVendorStaffModel;
  }


  /// updateVendorStaffApi
  Future<void> updateVendorStaffApi(String email, password, firstName, lastName, phoneNumber,vendorID, roleId) async {
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
       "vendorId": vendorID.toString()

    });
    print(data);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateVendorStaff}?id=${roleId}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
  debugPrint("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = response.data;
      var status = responseData['status'];
      var message = responseData['message'];
      if (status == true) {
        isLoading = false;
        update();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(milliseconds: 1000), () {
              getVendorStaffApi(context, "1","10","");
               Navigator.pop(context);

              myShimmer();
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
        ).then((value){
          Navigator.pop(context);
        });
      } else {
        isLoading = false;
        update();
        CustomSnackBar.mySnackBar(context, "${message}");
      }
    } else {
      isLoading = false;
      update();
      print('Failed with status code: ${response.statusCode}');
      // Show failure message here
    }

  }

  /// deleteVendorStaffApi
  Future<void> deleteVendorStaffApi(String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteVendorStaff}?id=${roleId}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var responseData = response.data;
        var status = responseData['status'];
        var message = responseData['message'];
        if (status == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds:0), () {
                getVendorStaffApi(context, "1", "10", "").then(
                        (value){
                      Navigator.pop(context);
                    });

                // getEcoBlueSubAdminApi(context,'0','10','');
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
        } else {
          CustomSnackBar.mySnackBar(context, "${message}");
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        // Show failure message here
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }


//getVendorStaffCollectedListApi
  GetStaffCollectedListModel? getStaffCollectedListModel;
  Future<GetStaffCollectedListModel?> getVendorStaffCollectedListApi(BuildContext context,page,limit,searchText,vendorId) async {
    var userToken = await SharedPref().getToken();
    print("Ho rhi hai");
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
        '${Endpoints.baseUrl}${Endpoints.getVendorStaffCollected}?page=$page&limit=$limit&searchText=${searchText}&requestedVendorStaffId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print("this isis${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GetStaffCollectedListModel.fromJson(result);
          getStaffCollectedListModel = finalResult;
          update();
         // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");

        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getStaffCollectedListModel;
  }

}