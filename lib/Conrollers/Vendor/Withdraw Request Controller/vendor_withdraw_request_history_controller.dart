


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_count_model.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_list_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class VendorWithdrawRequestHistoryController extends GetxController{



  /// get api for withdraw request count
  GetVendorWithdrawRequestHistoryCountModel? getVendorWithdrawRequestHistoryCountModel;
  Future<GetVendorWithdrawRequestHistoryCountModel?> getVendorWithdrawRequestHistoryCountApi(BuildContext context) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    debugPrint("api called");
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
        '${Endpoints.baseUrl}${Endpoints.withdrawRequestHistoryCount}',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorWithdrawRequestHistoryCountModel = GetVendorWithdrawRequestHistoryCountModel.fromJson(result);
        if(!(getVendorWithdrawRequestHistoryCountModel?.status??false) || result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${getVendorWithdrawRequestHistoryCountModel!.message}");
        }
        else{
          debugPrint("data fetched!!!");
          //areOptionVisibleList.value = List.generate(getVendorWithdrawPendingRequestModel?..length??0, (index) => false);
          // debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorWithdrawRequestHistoryCountModel;
  }

  /// get api for withdraw request list
  GetVendorWithdrawRequestHistoryListModel? getVendorWithdrawRequestHistoryListModel;
  Future<GetVendorWithdrawRequestHistoryListModel?> getVendorWithdrawRequestHistoryListApi(BuildContext context,page,limit,searchText) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
    debugPrint("api called");
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
        '${Endpoints.baseUrl}${Endpoints.vendorWithdrawRequestHistoryList}?page=1$page&limit=&$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      debugPrint("api response code == ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorWithdrawRequestHistoryListModel = GetVendorWithdrawRequestHistoryListModel.fromJson(result);
        if(!(getVendorWithdrawRequestHistoryListModel?.status??false) || result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${getVendorWithdrawRequestHistoryListModel!.message}");
        }
        else{
          debugPrint("data list fetched!!!");
          // areOptionCheckedList.value = List.generate(getVendorWithdrawRequestHistoryListModel?.data.length??0, (index) => false);
          // debugPrint("length of visible list ${areOptionVisibleList.length}");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorWithdrawRequestHistoryListModel;
  }
  showLoader(context){
    showDialog(context: context,
        builder: (_){
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: Get.height,
              width: Get.width,
              child: CupertinoActivityIndicator(
                color: AppColor.green,
                radius: 20,
              ),
            ),
          );
        });

  }
  // get download url
  Future<void> getWithdrawRequestDownloadUrlApi(context ,id ) async {
    showLoader(context);
    // showDownloadingProcess();
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
    var response = await dio.get(
      '${Endpoints.baseUrl}${Endpoints.vendorWithdrawRequestDownloadReceipt}?id=$id',
      options: Options(
        headers: headers,
      ),
    );
    debugPrint("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      Navigator.pop(context);
      var responseData = response.data;
      debugPrint("response of getDownload url : $responseData");
      var status = responseData['status'];
      var message = responseData['message'];
      if (status == true) {
        String fileType = ".pdf";
        String url = responseData['data']["url"];
        await _downloadFile(url,"${id}_Withdraw_Receipt_PDF$fileType",context);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     Future.delayed(Duration(milliseconds: 1000), () {
        //       // Navigator.pop(context);
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
        CustomSnackBar.mySnackBar(context, "${message}");
      }
    } else {
      print('Failed with status code: ${response.statusCode}');
      // Show failure message here
    }

  }

  ValueNotifier<double> progress = ValueNotifier(0);
  showDownloadingProcess(context){
    showDialog(
        context: context,
        builder:(_){
          return ValueListenableBuilder(
              valueListenable: progress,
              builder: (_,progressValue,child) {
                if(progress.value == 100){
                  Future.delayed(Duration(seconds: 1),(){
                    Navigator.pop(context);
                    progress.value = 0;
                  });
                }
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: AppColor.greenLight,
                        minHeight: 4,
                        valueColor:AlwaysStoppedAnimation<Color>(AppColor.green),
                      ),
                      const SizedBox(height: 6,),
                      Text(
                          progressValue < 100?
                          "Downloading... ${progressValue.toStringAsFixed(0)}%":
                          "Downloaded"
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  Future<void> _downloadFile(String url, String filename,context) async {
    showDownloadingProcess(context);
    String finalFilename = await getFilePath(filename);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    await dio.download(
        url,
        finalFilename,
        onReceiveProgress: (rcv, total) async {
          await Future.delayed(Duration(milliseconds: 300));
          progress.value = (rcv / total) * 100;
          // if (progress.value == 100) {
          //  debugPrint("download success of $finalFilename}");
          // } else if (progress.value < 100) {
          //
          // }
        },
        deleteOnError:true
    ).then(
            (val){

        }
    );
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }



}