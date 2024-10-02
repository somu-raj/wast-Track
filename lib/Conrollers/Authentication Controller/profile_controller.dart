import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Conrollers/Authentication%20Controller/authentication_controller.dart';

import '../../API Integration/app_base_controller.dart';
import '../../App Routes/app_routes.dart';
import '../../Models/Auth/profile_response_model.dart';
import '../../Models/Vendor Management Model/Get Vendor Bank Details Model/get_vendor_bank_details_model.dart';
import '../../Screens/Dashboard/Profile Screen/profile_screen.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
import '../../Utils/colors/app_colors.dart';

class ProfileController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  ProfileController({required this.context}); // Constructor

  bool isHidden = true;
  var phone = '';
  String login = 'Email';
  int num = 0;
  File? image;
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    getProfileApi(context);
    getVendorBankDetailsApi(context);

  }
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var designationController = TextEditingController();

  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var accountHolderNameController = TextEditingController();
  void updateLoginType(String value) {
    if (value == 'Email') {
      num = 0;
    } else {
      num = 1;
    }
    login = value;
    update();
  }
  ///UpdateProfile
  Future<void> updateProfileApi(String name, email, lastName, context, File imageFile) async {
    isLoading = true;
    update();

    var userToken = await SharedPref().getToken();

    var token = "${userToken}";
    print("this is userToken${token}");
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var formData = FormData.fromMap({
      "firstName": name.toString(),
      "lastName": lastName.toString(),
      "email": email.toString(),
    });
    if (imageFile.path.isEmpty) {

    }else{
      formData.files.add(
        MapEntry(
          "profileImage",
          await MultipartFile.fromFile(imageFile.path,),
        ),
      );
    }

    print("Request data: $formData");

    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    try {
      final response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.update}',
        options: Options(headers: headers),
        data: formData,
      );
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        if (result['status'] == true) {
          isLoading = false;
          update(); // Update the state to reflect the loading state
          getProfileApi(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 900), () {
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
        } else {
          // Set isLoading to false when API call fails
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
      // Set isLoading to false when API call throws an error
      isLoading = false;
      update(); // Update the state to reflect the loading state
      print("Error: $e");
      throw Exception("Something went Wrong!!");
    }
  }

  /// Get Profile Api
  ProfileResponseModel? model;
  Future<ProfileResponseModel?> getProfileApi(BuildContext context) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    update();
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
        '${Endpoints.baseUrl}${Endpoints.profile}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = ProfileResponseModel.fromJson(result);
         if(finalResult.status ==  true){
           model = finalResult;
           firstNameController.text = model!.data!.firstName.toString();
           lastNameController.text = model!.data!.lastName.toString();
           emailController.text = model!.data!.email.toString();
           designationController.text = model!.data!.roleInfo!.roleName.toString();
           update();

         }else{
           CustomSnackBar.mySnackBar(context, "Session expired. Please log in again");

         }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }


  /// get  vendor bank details  Api

  GetVendorBankDetailsModel? modelBankDetails;
  getVendorBankDetailsApi(BuildContext context) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    update();
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
        '${Endpoints.baseUrl}${Endpoints.getVendorBankDetails}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetVendorBankDetailsModel.fromJson(result);
         if(finalResult.status == true){
          modelBankDetails = finalResult;
          update();
          bankNameController.text = modelBankDetails!.data!.bankName.toString();
          accountNumberController.text = modelBankDetails!.data!.accountNumber.toString();
          accountHolderNameController.text = modelBankDetails!.data!.accountHolderName.toString();
          update();
         // CustomSnackBar.mySnackBar(context, result['message']);
          //  CustomSnackBar.mySnackBar(context, "");

        }else{
        //  CustomSnackBar.mySnackBar(context, result['message']);

        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return modelBankDetails;
  }
  /// get  update  bank details  Api
  updateBankDetails(bankName,accountNumber,accountHolderName) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    update();
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "bankName":bankName,
      "accountNumber":accountNumber,
      "accountHolderName":accountHolderName
    });
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.updateVendorBankDetails}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var result  = json.encode(response.data);
      var finalResponce = jsonDecode(result);
      if(finalResponce['status']== true){
        isLoading = false;
        update();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(milliseconds: 900), () {
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
                      "${finalResponce['message'].toString()}",
                      style: TextStyle(fontSize: 15, color: AppColor.green),
                    ),
                  ),
                ],
              ), // show pop-up
            );
          },
        );
      }else{
        CustomSnackBar.mySnackBar(context, finalResponce['message']);
       update();
        isLoading = false;
        update();
      }

    }
    else {
      print(response.statusMessage);
      isLoading = false;
      update();
    }
  }

}
