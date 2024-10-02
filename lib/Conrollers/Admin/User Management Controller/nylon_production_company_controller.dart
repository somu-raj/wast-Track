import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/Revenue Container Model/get_revenue_shareing_list_model.dart';
import '../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../Models/User Management Model/Nylon Company/get_nylon_production_company_model.dart';
import '../../../Models/User Management Model/State Goverment Agency/get_state_model.dart';
import '../../../Models/User Management Model/Waste Management Agency/get_agency_model.dart';
import '../../../Models/User Management Model/Waste Management Staff/get_staff_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class NylonProductionCompanyController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  NylonProductionCompanyController({required this.context}); // Constructor
  bool isLoading = false;
    String? subAdmin;
  @override
  Future<void> onInit() async {
    super.onInit();
    getNylonProductionCompanyApi(context);

  }


  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var companyNameController = TextEditingController();
  var companyAddressController = TextEditingController();

  /// add Nylon Production Company Api
  Future<void> addNylonProductionCompanyApi(String email, password, firstName, lastName, phoneNumber, cName,cAddress, context) async {
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
      "companyName": cName.toString(),
      "companyAddress": cAddress.toString(),
    };
    var url = '${Endpoints.baseUrl}${Endpoints.addNylonProduction}';
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
          getNylonProductionCompanyApi(context);
          isLoading = false;
          update();
          firstName == null;
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
          isLoading = false;
          update();
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        }
      } else {
        isLoading = false;
        update();
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

  ///get Nylon Production Company Api
  GetNylonProductionModel? nylonModel;
  Future<GetNylonProductionModel?> getNylonProductionCompanyApi(BuildContext context) async {
    var userToken = await SharedPref().getToken();
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
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getNylonProduction}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetNylonProductionModel.fromJson(result);
        nylonModel = finalResult;
        getRevenueShareListApi(context, "1", '10','',nylonModel?.data?.revenueModelId);
        if(finalResult.status??false){
          firstNameController.text = nylonModel!.data!.firstName.toString();
          lastNameController.text = nylonModel!.data!.lastName.toString();
          emailController.text = nylonModel!.data!.email.toString();
          mobileController.text = nylonModel!.data!.phoneNumber.toString();
          companyNameController.text = nylonModel!.data!.companyName.toString();
          companyAddressController.text = nylonModel!.data!.companyAddress.toString();

          update();
          //CustomSnackBar.mySnackBar(context, "${nylonModel?.message}");
        }else{
          CustomSnackBar.mySnackBar(context, "${nylonModel?.message}");
        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  ///update Nylon Production Company Api
  Future<void> updateNylonProductionCompanyApi(String email, password, firstName, lastName, phoneNumber,cAddress,cName, roleId) async {
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "email": email.toString(),
      "firstName":firstName.toString(),
      "lastName":lastName,
      "password": password.toString(),
      "phoneNumber":phoneNumber.toString(),
      "companyName":cName.toString(),
      "companyAddress":cAddress.toString()
    });
    print(data);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateNylonProduction}?id=${roleId}',
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
        isLoading = false;
        update();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pop(context,);
              Navigator.pop(context,);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserManagementScreen(selectedIndex: 5,isTrue: true,)));
              getNylonProductionCompanyApi(context);
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
      }
      else {
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

  ///delete Nylon Production Company Api
  Future<void> deleteNylonProductionCompanyApi(String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteNylonProduction}?id=${roleId}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var responseData = response.data;
        var status = responseData['status'];
        var message = responseData['message'];
        if (status == true) {
          getNylonProductionCompanyApi(context);

          // update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.pop(context,);
                Navigator.pop(context,);
                getNylonProductionCompanyApi(context);
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

  ///update Profile Pic Api
  Future<void> updateProfilePicNylonApi(String nylonId,imageFilePath) async {
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
    debugPrint("$imageFilePath _imagePath");

    Map<String, dynamic> params = {
      "nylonProductionId":nylonId,
    };

    FormData formData = FormData.fromMap(params);
    formData.files.add(
        MapEntry(
      'profileImage',
      await MultipartFile.fromFile(imageFilePath),
    ));
    try {
      Response response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.updateProfileNylonProduction}',
        data: formData,
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
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserManagementScreen()));
                getNylonProductionCompanyApi(context);
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

  /// get Revenue Share List Api
  GetRevenueShareListModel? getRevenueShareListModel;
  Future<GetRevenueShareListModel?> getRevenueShareListApi(context,page,limit,searchText,revenueModelId) async {
    var userToken = await SharedPref().getToken();
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
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.revenueShareList}?page=$page&limit=$limit&searchText=$searchText&revenueModelId=$revenueModelId',
        options: Options(
          headers: headers,
        ),
      );
       debugPrint("this response${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetRevenueShareListModel.fromJson(result);
        getRevenueShareListModel = finalResult;
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

}
