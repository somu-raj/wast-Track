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
import '../../Screens/Dashboard/Profile Screen/profile_screen.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
import '../../Utils/colors/app_colors.dart';

class UpdatePasswordController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  UpdatePasswordController({required this.context}); // Constructor

  bool isHidden = true;
  var phone = '';
  String login = 'Email';
  int num = 0;
  File? image;
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();


    // Pass context to getProfileApi method
  }


  void togglePaaswordView() {
    isHidden = !isHidden;
  }

  void updateLoginType(String value) {
    if (value == 'Email') {
      num = 0;
    } else {
      num = 1;
    }
    login = value;
    update();
  }

  Future<void> updatePasswordApi(String currentPassword, newPassword, confPassword, context,) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
      'Content-Type': 'application/json', // Set content type to JSON
    };

    // Create a Map containing the request data
    var requestData = {
      "currentPassword": currentPassword.toString(),
      "newPassword": newPassword.toString(),
      "confirmPassword": confPassword.toString(),
    };
        print("confirmPassword------->${requestData}");
    var url = '${Endpoints.baseUrl}${Endpoints.update_Password}';

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
          // Set isLoading to false when API call succeeds
          isLoading = false;
          update(); // Update the state to reflect the loading state

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 900), () {
                Navigator.pushNamed(context, AppScreen.dashboard);
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
