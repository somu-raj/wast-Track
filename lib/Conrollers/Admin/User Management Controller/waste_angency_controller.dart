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
import '../../../Models/User Management Model/Waste Management Agency/get_agency_model.dart';
import '../../../Models/User Management Model/Waste Management Staff/get_staff_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class WasteManagementAgencyController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  WasteManagementAgencyController({required this.context}); // Constructor
  bool isLoading = false;
    String? subAdmin;
  @override
  Future<void> onInit() async {
    super.onInit();
    getWasteAgencyApi(context);
    getWasteStaffApi(context);
  }

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();

  /// Agency Api Implementation

 /// addWasteAgencyApi
  Future<void> addWasteAgencyApi(String email, password, firstName, lastName, phoneNumber, context) async {
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

    var url = '${Endpoints.baseUrl}${Endpoints.addWasteAgency}';
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
          getWasteAgencyApi(context);
          isLoading = false;
          update();
          firstName == null;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pop(context);
                Navigator.pop(context);
                update();
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

  /// getWasteAgencyApi
  GetWasteAgencyModel? wasteModel;
  Future<GetWasteAgencyModel?> getWasteAgencyApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.getWasteAgency}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetWasteAgencyModel.fromJson(result);
        wasteModel = finalResult;
        getRevenueShareListApi(context, "1", '10','',wasteModel?.data?.revenueModelId);
        print("this is surendra ${wasteModel?.data?.revenueModelId}");
        firstNameController.text = wasteModel!.data!.firstName.toString();
        lastNameController.text = wasteModel!.data!.lastName.toString();
        emailController.text = wasteModel!.data!.email.toString();
        mobileController.text = wasteModel!.data!.phoneNumber.toString();
        update();
       // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
        update();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  /// updateWasteAgencyApi
  Future<void> updateWasteAgencyApi(String email, password, firstName, lastName, phoneNumber, roleId) async {
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
      '${Endpoints.baseUrl}${Endpoints.updateWasteAgency}?id=${roleId}',
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
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserManagementScreen(selectedIndex: 3,isTrue: true,)));
              getWasteAgencyApi(context);
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

  /// deleteWasteAgencyApi
  Future<void> deleteWasteAgencyApi(String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteWasteAgency}?id=${roleId}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var responseData = response.data;
        var status = responseData['status'];
        var message = responseData['message'];
        if (status == true) {
          myShimmer();
          getWasteAgencyApi(context);
          // update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserManagementScreen()));
                //getWasteAgencyApi(context);
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

  /// deleteWasteAgencyApi
  Future<void> updateProfilePicApi(String wasteAgencyId,imageFilePath) async {
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
      "wasteAgencyId": wasteAgencyId,
    };

    FormData formData = FormData.fromMap(params);
    formData.files.add(
        MapEntry(
      'profileImage',
      await MultipartFile.fromFile(imageFilePath),
    ));
    try {
      Response response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.updateProfilePicWasteAgency}',
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
                getWasteAgencyApi(context);
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



  /// Staff Api Implementation

  /// add Waste Staff Api
  Future<void> addWasteStaffApi(String email, password, firstName, lastName, phoneNumber, vendorId, context) async {
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
      "vendorId":vendorId.toString(),
    };
    var url = '${Endpoints.baseUrl}${Endpoints.addWasteStaff}';
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
          getWasteAgencyApi(context);
          isLoading = false;
          update();
          firstName == null;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pop(context);
                Navigator.pop(context);
                update();
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

  /// get Waste Staff Api
  GetWasteStaffModel? staffModel;
  Future<GetWasteStaffModel?> getWasteStaffApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.getWasteStaff}?page=1&limit=10&searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetWasteStaffModel.fromJson(result);
        staffModel = finalResult;
        print("this is ios iso s${finalResult}${staffModel?.data.first.vendorCode}");
        update();
        //CustomSnackBar.mySnackBar(context, "${finalResult.message}");
        update();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

 /// delete Waste Staff Api
  Future<void> deleteWasteStaffApi(String vendorId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteWasteStaff}?id=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var responseData = response.data;
        var status = responseData['status'];
        var message = responseData['message'];
        if (status == true) {
          myShimmer();
         // getWasteStaffApi(context);
          // update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 1000), () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserManagementScreen()));
                //getWasteAgencyApi(context);
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

  /// update Waste Staff Api
  Future<void> updateWasteStaffApi(String email, password, firstName, lastName, phoneNumber,roleId, vendorId,context) async {
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "vendorId":vendorId,
      "firstName":firstName.toString(),
      "lastName": lastName.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "phoneNumber": phoneNumber.toString()
    });
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateWasteStaff}?id=${roleId}',
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
      if (status) {
        isLoading = false;
        update();
        CustomSnackBar.mySnackBar(context, "${message}");
        Navigator.pop(context);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     Future.delayed(Duration(milliseconds: 500), () {
        //       print("ddsfsdfdfdgd");
        //       Navigator.pop(context,);
        //       Navigator.pop(context,);
        //       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserManagementScreen(selectedIndex: 3,isTrue: true,)));
        //       //getWasteAgencyApi(context);
        //       myShimmer();
        //     });
        //     return CupertinoAlertDialog(
        //       title: Row(
        //         children: [
        //           Container(
        //             padding: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(30),
        //               color: AppColor.green,
        //             ),
        //             child: Icon(
        //               Icons.done,
        //               color: Colors.white,
        //             ),
        //           ),
        //           Flexible(
        //             child: Text(
        //               "${message}",
        //               style: TextStyle(fontSize: 15, color: AppColor.green),
        //             ),
        //           ),
        //         ],
        //       ), // show pop-up
        //     );
        //   },
        // );
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
