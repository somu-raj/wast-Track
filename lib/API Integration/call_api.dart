import 'package:dio/dio.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';

import 'Dio Client/dio_client.dart';
import 'Dio Exception Handling/dio_exception_handling.dart';

class AppApi {
  final dioClient = DioClient();

  /// Login API
  Future loginAPI({required FormData body}) async {
    try {
      final response = await dioClient.post("${Endpoints.baseUrl}auth/login", data: body);
      print("login api response ${response}");
      return response;
    } on DioException catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Registration API
  Future registrationAPI({required FormData body}) async {
    try {
      final response = await dioClient.post("register", data: body);
      print("register api response ${response}");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Registration API
  Future sendToOtp({required FormData body}) async {
    try {
      final response = await dioClient.post("forgot-password", data: body);
      print("otp api response ${response}");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Verify OTP API
  Future verifyOtpApi({required FormData body}) async {
    try {
      final response = await dioClient.post("login/user-register-otp-verification", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Recover Password Store API
  Future recoverPasswordStore({required FormData body}) async {
    try {
      final response =
          await dioClient.post("recover/recover-password-store", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Recover Password Verification API
  Future recoverPasswordVerify({required FormData body}) async {
    try {
      final response = await dioClient
          .post("recover/recover-password-verification", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Dashboard API
  Future dashboardAPI() async {
    try {
      final response = await dioClient.get("dashboard");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// faq API
  Future faqAPI() async {
    try {
      final response = await dioClient.get("faq");
      // print("faq response ${response.data}");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Profile Update API
  Future profileUpdateApi({required FormData body}) async {
    try {
      final response = await dioClient.post("updateProfile", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Add Address API
  Future addAddressApi({required FormData body}) async {
    try {
      final response = await dioClient.post("saveaddress", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// show API
  Future showAddressApi() async {
    try {
      final response = await dioClient.get("showaddress");
      print("showAddress response ${response.data}");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Edit Address API
  Future editAddressApi({required FormData body}) async {
    try {
      final response = await dioClient.post("editaddress", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// Delete Address API
  Future deleteAddressApi({required FormData body}) async {
    try {
      final response = await dioClient.post("deleteaddress", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// All Category API
  Future allCategoryApi() async {
    try {
      final response = await dioClient.get("Categories");
      print("All Category response ${response.data}");
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }

  /// sub Category API
  Future subCategoryApi({required FormData body}) async {
    try {
      final response = await dioClient.post("subcategories", data: body);
      return response;
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error).toString();
      throw errorMessage;
    }
  }
}
