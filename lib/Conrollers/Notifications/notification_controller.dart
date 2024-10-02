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
import '../../Models/Notification Model/get_notification_model.dart';
import '../../Models/Vendor Management Model/Get Vendor Bank Details Model/get_vendor_bank_details_model.dart';
import '../../Screens/Dashboard/Profile Screen/profile_screen.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
import '../../Utils/colors/app_colors.dart';

class NotificationController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  NotificationController({required this.context}); // Constructor

  bool isHidden = true;
  var phone = '';
  String login = 'Email';
  int num = 0;
  File? image;
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    getNotificationApi();

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
  /// get notification
  GetNotificationModel?getNotificationModel;
  getNotificationApi() async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    print("this is userToken${token}");
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = '''''';
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.notification}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
       var result = json.encode(response.data);
       var finalResult = GetNotificationModel.fromJson(json.decode(result));
       if(finalResult.status == true){
         update();
         getNotificationModel =  finalResult;
       }
    }
    else {
      print(response.statusMessage);
    }
  }

}
