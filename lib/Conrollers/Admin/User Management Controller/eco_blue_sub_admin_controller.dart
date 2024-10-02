import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../Models/Vendor Staff/Vendor Staff Waste Collected Model/get_waste_collected_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';
import 'eco-blue_controller.dart';

// int? page; // Track current page
// int? totalItem ; // Number of items to fetch per page
class EcoBlueSubAdminController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  EcoBlueSubAdminController({required this.context}); // Constructor
  bool isLoading = false;
    String? subAdmin;
  @override
  Future<void> onInit() async {
    super.onInit();
   await getEcoBlueSubAdminApi(context,'1',"10",'');
    declareEcoBlueController();
  }
  late final EcoAdminSubAdminVisibilityController subAdminVisibilityController;
  declareEcoBlueController()  {
    subAdminVisibilityController =   Get.put(
        EcoAdminSubAdminVisibilityController(
        List.generate(ecoModel?.pagination?.totalItems ?? 1, (index) => false).obs
    )
    );
  }


  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();

 /// Eco-blue addSubAdminApi
  Future<void> addEcoBlueSubAdminApi(String email, password, firstName, lastName, phoneNumber, context) async {
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
    };
    var url = '${Endpoints.baseUrl}${Endpoints.ecoBlueSubAdmin}';
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
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        if (result['status'] == true) {
          myShimmer();
          getEcoBlueSubAdminApi(context,'1','10','');
          isLoading = false;
          update();
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

  /// Eco-blue getSubAdminApi
  GetEcoBlueAdminUpdateDataModel? ecoModel;
  Future<GetEcoBlueAdminUpdateDataModel?> getEcoBlueSubAdminApi(BuildContext context,page,limit,searchText) async {
    // debugPrint("page ${ecoModel!.pagination!.currentPage}");
    var userToken = await SharedPref().getToken();
    // debugPrint("page");
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getEcoBlueSubAdmin}?page=${page}&limit=${limit}&searchText=${searchText}',
        options: Options(
          headers: headers,
        ),
      );
      // debugPrint("response ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status'] == true){
          var finalResult = GetEcoBlueAdminUpdateDataModel.fromJson(result);
          ecoModel = finalResult;
          update();
          CustomSnackBar.mySnackBar(context, "${result['message']}");

        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");
         // CustomSnackBar.mySnackBar(context, "Session expired. Please log in again  ");
        }
       // myShimmer();

      //
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  /// Eco-blue updateSubAdminApi
  Future<void> updateEcoBlueSubAdminListApi(String email, password, firstName, lastName, phoneNumber, roleId) async {
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "firstName":firstName.toString(),
      "lastName": lastName.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phoneNumber": phoneNumber.toString()
    });
    print(data);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateEcoBlueSubAdmin}?id=${roleId}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

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
              Navigator.pop(context);
              Navigator.pop(context);
              getEcoBlueSubAdminApi(context,'0','10','');
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
        );
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

  //Eco-blue deleteSubAdminApi
  Future<void> deleteEcoBlueSubAdminApi( String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteEcoBlueSubAdmin}?id=${roleId}',
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
              Future.delayed(Duration(milliseconds: 900), () {
                Navigator.pop(context);
                getEcoBlueSubAdminApi(context,'0','10','');
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

  /// get waste collection Api

  GetWasteCollectionListModel? getWasteVerifyCollectionListModel;
  Future<GetWasteCollectionListModel?> getWasteCollectionApi(context,page,limit,searchText,status,vendorId) async {
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
        '${Endpoints.baseUrl}${Endpoints.getWasteCollectionListApi}?page=$page&limit=$limit&searchText=$searchText&isPending=${status}&requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetWasteCollectionListModel.fromJson(result);
        getWasteVerifyCollectionListModel = finalResult;
        }
        update();
        // CustomSnackBar.mySnackBar(context, "${finalResult.message}");

    } catch (error) {
      print('Error: $error');
    }
    return getWasteVerifyCollectionListModel;
  }

}
