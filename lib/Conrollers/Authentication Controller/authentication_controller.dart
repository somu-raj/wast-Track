
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retry/retry.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Auth/login_response_model.dart';
import '../../API Integration/app_base_controller.dart';
import '../../App Routes/app_routes.dart';
import '../../Models/Auth/profile_response_model.dart';
import '../../Models/Auth/register_response_model.dart';
import '../../Models/Auth/role_response_model.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
String? mobile,image,name,roleId;

class LoginController extends AppBaseController {
  bool isHidden = true;
  var phone = '';
  String login = 'Email';
  int num = 0;
  bool isLoading = false;
  String? tokenNew;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
     fetchData();
     roleApi();
   // getProfileApi();
    // TODO: implement initState
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

  List<Map<String, dynamic>> roles = []; // List to hold role data
  String selectedRole = ''; // Variable to store selected role

  Future<void> fetchData() async {
    try {
      var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      Response response = await dio.get('http://matchitsports.com:3000/api/roles');

      if (response.statusCode == 200) {
        List<dynamic> roleResponseModel = response.data['data'];
        roles = roleResponseModel.map((data) => data as Map<String, dynamic>).toList();
        print("this is a parameter---------->${roles}");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }


  ////////roleApi/////
  String? roleName;
  RoleList? roleList;
  RoleResponseModel? roleResponseModel;
  Future<void> roleApi() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  
    try {
      final response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.role}',
        options: Options(headers: headers),
      );
      print("Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = RoleResponseModel.fromJson(result);
        update();
        print(result);
        print('this is parameter=====>${finalResult}');

        if (finalResult.status == true) {
          //CustomSnackBar.mySnackBar(context, finalResult.message.toString());
        } else {
          //CustomSnackBar.mySnackBar(context, finalResult.message.toString());
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        throw Exception("Something went Wrong!!");
      }
    } catch (error) {
      print("Error: $error");
      // Handle error
    }
  }

 ////////LoginApi/////

  Future<void> loginApi(String email, String password,roleId,context)

  async {
    isLoading = true;
    update();
    var headers = {
      'Content-Type': 'application/json'
    };
    var data = {
      "email": "${email.toString()}",
      "password": "${password.toString()}",
    };
    print("this is a parameter-------->${data}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final response = await dio.request('${Endpoints.baseUrl}${Endpoints.login}',
        options: Options( method: "POST",
            headers: headers),
        data: data,
      );
    print("aaaaaaaaaaaa${response.statusCode}");
    if (response.statusCode == 200) {

      var result = response.data;
        var finalResult = LoginResponseModel.fromJson(result);
      if(finalResult.status == true){
        isLoading = false;
        update();
         roleId =  finalResult.data?.roleInfo?.id.toString();
        var newRoleID =  finalResult.data?.roleInfo?.roleId.toString();
         tokenNew =  finalResult.token.toString();
         SharedPref().setUserType(newRoleID!);

         SharedPref().setToken(tokenNew!);
         print("role id${roleId}");
         setLogin(roleId,mobile,image,name);
         Navigator.pushNamed(context, AppScreen.dashboard);

      }
      else{
        isLoading = false;
        update();
        CustomSnackBar.mySnackBar(context, finalResult.message.toString());
      }
    } else {
      isLoading = false;
      update();
      print("Failed with status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      throw Exception("Something went Wrong!!");
    }
  }
   setLogin(roleId,name,mobile,image) async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setBool("isLoggedIn", true);
   preferences.setString("user_id", roleId);
   print(roleId);
  }



  ////////registerApi/////
  Future<void> registerApi(String email,password,firstName,lastName,phoneNumber,companyName,companyAddress,context,) async {
    isLoading = true;
    update();
    var headers = {
      'Content-Type': 'application/json'
    };
    var data = {
      "firstName": "${firstName.toString()}",
      "lastName": "${lastName.toString()}",
      "email": "${email.toString()}",
      "phoneNumber": "${phoneNumber.toString()}",
      "companyName": "${companyName.toString()}",
      "companyAddress":"${companyAddress.toString()}",
      "password": "${password.toString()}"
    };
    print("this is a parameter----->${data}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final response = await retry(
          () => dio.post(
        '${Endpoints.baseUrl}${Endpoints.register}',
        options: Options(headers: headers),
        data: data,
      ),
     // retryIf: (e) => e is DioError && e.type == DioErrorType.connectionError,
    );
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      var result = response.data;
      var finalResult = RegisterResponseModel.fromJson(result);
      if(finalResult.status == true){
        CustomSnackBar.mySnackBar(context, finalResult.message.toString());
        isLoading = false;
        update();
        Navigator.pushNamed(context, AppScreen.login);

      }
      else{
        isLoading = false;
        update();
        CustomSnackBar.mySnackBar(context, finalResult.message.toString());
      }

    } else {
      isLoading = false;
      update();
      print("Failed with status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      throw Exception("Something went Wrong!!");
    }
  }


  ////////forgetPasswordApi/////
  Future<void> forgetPasswordApi(String email,roleId,context,) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var data = {
      "email": "${email.toString()}",
      "roleId": "${roleId.toString()}",
    };
    print("this is a parameter----->${data}");
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    final response = await retry(
          () => dio.post(
        '${Endpoints.baseUrl}${Endpoints.forgot}',
        options: Options(headers: headers),
        data: data,
      ),
      //retryIf: (e) => e is DioError && e.type == DioErrorType.connectionError,
    );
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      var result = response.data;
      print(result);
      if(result.status == true){
        CustomSnackBar.mySnackBar(context, result.message.toString());
      }
      else{
        CustomSnackBar.mySnackBar(context, result.message.toString());
      }
    } else {
      print("Failed with status code: ${response.statusCode}");
      print("Response data: ${response.data}");
      throw Exception("Something went Wrong!!");
    }
  }

  ////////updateProfileApi/////
  Future<void> updateProfileApi(String email,name,lastName,context, File imageFile) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
    };

    var formData = FormData.fromMap({
      "firstName": name.toString(),
      "lastName": lastName.toString(),
      "email": email.toString(),
      "profileImage": await MultipartFile.fromFile(imageFile.path, filename: "image.jpg"),
    });

    print("Request data: $formData");

    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    try {
      final response = await dio.post(
        '${Endpoints.baseUrl}${Endpoints.forgot}',
        options: Options(headers: headers),
        data: formData,
      );

      print("Response : ${response.statusCode}");

      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        if (result['status'] == true) {
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        } else {
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response data: ${response.data}");
        throw Exception("Something went Wrong!!");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Something went Wrong!!");
    }
  }


  ////////getProfileApi/////
   ProfileResponseModel? profileResponseModel;
   Future<ProfileResponseModel?> getProfileApi() async  {
    var headers = {
      'Authorization': "${tokenNew.toString()}"
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
        var finalResult = ProfileResponseModel.fromJson(json.decode(result));
        profileResponseModel = finalResult;
        update();
        print("this is a username-->${profileResponseModel!.data!.firstName}");

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

}
