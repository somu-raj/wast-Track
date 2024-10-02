



import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Get%20Vendors%20Model/get_vendors_model.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/vendor_management_screen.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/Vendor Management Model/Area Search Model/area_search_model.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class GetVendorRequestController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  GetVendorRequestController({required this.context}); // Constructor
  bool isLoading = false;
  bool isPendingRequest = true;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getVendorRequestApi(context, "1", "10", "", "0");
    // if(getVendorsModel != null){
    //   declareAllVendorVisibilityController();
    //   if (getVendorsModel?.pagination?.totalItems != null &&
    //       (getVendorsModel!.pagination!.totalItems! >
    //           allVendorVisibilityController.allVendorVisibleList.length)) {
    //     allVendorVisibilityController.allVendorVisibleList.add(false);
    //     // log("allVendorVisibleList added length ${allVendorVisibilityController.allVendorVisibleList.length}");
    //   }
    // }
  }




  ///get Vendor Request Api
  GetVendorsModel? getVendorRequestModel;
  GetVendorsModel? getVendorRequestRejectedModel;
  Future<GetVendorsModel?> getVendorRequestApi(BuildContext context,page,limit,searchText,String?status,{bool? isRejected}) async {
    debugPrint("status....$status");
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
        '${Endpoints.baseUrl}${Endpoints.getVendors}?page=${page}&limit=${limit}&searchText=${searchText}&status=${status}',
        options: Options(
          headers: headers,
        ),
      );
      print(dio.get);
      if (response.statusCode == 200) {

        var result = response.data;
        if(result['status']== true){
          var finalResult = GetVendorsModel.fromJson(result);
          if(isPendingRequest){
            getVendorRequestModel = finalResult;
          }
          else{
            getVendorRequestRejectedModel = finalResult;
          }

          isLoading = false;
         CustomSnackBar.mySnackBar(context, "${finalResult.message}");
           update();
        }else{
         CustomSnackBar.mySnackBar(context, "${result['message']}");

        };
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        isLoading = false;
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      isLoading = false;
      print('Error: $error');
    }
    return null;
  }

  //Eco-blue updateSubAdminApi


  ///deleteVendorsApi
  Future<void> deleteVendorsApi(String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteVendor}?id=${roleId}',
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
                getVendorRequestApi(context, "1", "10", "", "1").then(
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

  /// search Vendor
  GetAreaSearchModel? searchAreaModel;
  Future<GetAreaSearchModel?> getAreaSearchApi(BuildContext context,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.searchArea}?&searchText=${searchText}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GetAreaSearchModel.fromJson(result);
          searchAreaModel = finalResult;

          update();
        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");
        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return searchAreaModel;
  }

  /// assign to vendor


  Future<void> assignToVendor(String areaId, vendorId, context) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var requestData = {
      "areaId": areaId,
      "vendorId": vendorId.toString(),
    };
    var url = '${Endpoints.baseUrl}${Endpoints.assignVendorToArea}';
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    print("areaNAME===========>${requestData}");
    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(requestData), // Encode the request data as JSON
      );
      debugPrint("this Is StatusCode ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        if (result['status'] == true) {
          myShimmer();
          //getEcoBlueSubAdminApi(context,'1','10','');
          isLoading = false;
          //update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 1), () {
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
                        "Vendor approved successfully",
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
          // Set isLoading to false when API call fails
          isLoading = false;
          update(); // Update the state to reflect the loading state
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        }
      } else {
        // Set isLoading to false when API call fails
        isLoading = false;
        update(); // Update the state to reflect the loading state

        print("Failed with status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        throw Exception("Something went Wrong!!");
      }
    } catch (e) {
      // Set isLoading to false when API call throws an error
      isLoading = false;
      update(); // Update the state to reflect the loading state

      print("Error: $e");
      throw Exception("Something went Wrong!!");
    }
  }


}