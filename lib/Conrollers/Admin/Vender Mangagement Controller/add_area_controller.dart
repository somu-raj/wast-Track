



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
import 'package:waste_track/Models/Vendor%20Management%20Model/Area%20Search%20Model/area_search_model.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../Models/Vendor Management Model/Area Model/get_area_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class AddAreaController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  AddAreaController({required this.context}); // Constructor
  bool isLoading = false;
  bool isGeneratedArea = true;
  bool isPendingRequest = true;
  String? subAdmin;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getAreaApi(context ,"1","10","");
    if(getAreaModel != null){
      declareAreaVisibilityController();
      if (getAreaModel?.pagination?.totalItems != null &&
          (getAreaModel!.pagination!.totalItems! >
              allAreaStateController!.assignedVisibleList.length)) {
        allAreaStateController!.assignedVisibleList = List.generate(getAreaModel?.pagination?.totalItems??1, (index) => false).obs;
        allAreaStateController!.notAssVisibleList = List.generate(getAreaModel?.pagination?.totalItems??1, (index) => false).obs;
         log("allVendorVisibleList added length ${allAreaStateController!.assignedVisibleList.length}");
      }
    }
  }
   AllAreasStateController? allAreaStateController;
  declareAreaVisibilityController(){
    allAreaStateController = Get.put(AllAreasStateController(
        allVisibleList: List.generate(getAreaModel?.pagination?.totalItems??1, (index) => false).obs
    ));
   // log("allVendorVisibleList length ${areaVisibilityController.allVendorVisibleList.length}");
  }


  /// addAreaApi
  Future<void> addAreaApi(String areaName, uploadExcel, context) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var requestData = {
      "areaName": areaName.toString(),
      "csvFile": uploadExcel,
    };
    var url = '${Endpoints.baseUrl}${Endpoints.addArea}';
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
                        "Vendor Added Successfully",
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

  /// getAreaApi
  GetAreaModel? getAreaModel;
  Future<GetAreaModel?> getAreaApi( context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getArea}?page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GetAreaModel.fromJson(result);
          getAreaModel = finalResult;

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
    return getAreaModel;
  }

  /// update Area Api
  Future<void> updateAreaApi(String areaId, areaName,) async {
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "areaName":areaName,
      "areaId":areaId
    });
    print(data);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateArea}',
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
        isLoading = true;
        update();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(milliseconds: 500), () {
              // getVendorsApi(context, "1", "10", "", "1").then((val){
              Navigator.pop(context);
              // });
              // getEcoBlueSubAdminApi(context,'0','10','');
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

  ///deleteAreaApi
  Future<void> deleteAreaApi(String areaId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteArea}?areaId=${areaId}',
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
                getAreaApi(context, "1","10","").then(
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


}