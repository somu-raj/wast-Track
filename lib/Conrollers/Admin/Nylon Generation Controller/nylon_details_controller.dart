


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/user_management_controller.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Nylon%20Details%20Model/nylon_batch_items_model.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Nylon%20Details%20Model/nylon_details_assigned_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/Nylon Generation Model/Nylon Details Model/nylon_details_generated_model.dart';
import '../../../Utils/Components/dataStroage_database.dart';

class NylonDetailsController extends AppBaseController {
  String? vendorId;
  final BuildContext context; // Receive context in the constructor

  NylonDetailsController({required this.context}); // Constructor
  bool isLoading = false;
  bool isGeneratedDetails = true;
  bool isDownloaded = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getNylonDetailsApi(context,"0","1","10","");
     declareNylonDetailsVisibilityController();
  }

 late final NylonManagementDetailsVisibilityController nylonDetailsVisibilityController;

  declareNylonDetailsVisibilityController(){
    RxList<bool>? list = List.generate(getNylonDetailsGeneratedModel?.pagination?.totalItems??1, (index) => false).obs;
    debugPrint("total items ${getNylonDetailsGeneratedModel?.pagination?.totalItems}");
     nylonDetailsVisibilityController = Get.put(
         NylonManagementDetailsVisibilityController(
            list
         ));
     // nylonDetailsVisibilityController.initializeSelectedList(list);
  }

  showLoader(){
    return showDialog(context: context,
        builder: (_){
      return CupertinoActivityIndicator(
        color: AppColor.trackCircle,
      );
        });
  }

  //getNylonDetailsApi
  GetNylonDetailsGeneratedModel? getNylonDetailsGeneratedModel;
  GetNylonDetailsAssignedModel? getNylonDetailsAssignedModel;
  Future<GetNylonDetailsGeneratedModel?> getNylonDetailsApi(BuildContext context,isAssigned,page,limit,searchText) async {
    debugPrint("status $isAssigned");
    String  userToken = await SharedPref().getToken();
    String token = userToken;
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
        '${Endpoints.baseUrl}${Endpoints.getNylonDetails}?is_assigned=$isAssigned&page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;

        if(isGeneratedDetails){
           // debugPrint("generated");
          getNylonDetailsGeneratedModel = GetNylonDetailsGeneratedModel.fromJson(result);
        }
        else{
          getNylonDetailsAssignedModel = GetNylonDetailsAssignedModel.fromJson(result);
        }


        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getNylonDetailsGeneratedModel;
  }

  //Get Delete Nylon Batch
  Future<void> getNylonBatchDeleteApi(batchId) async {
    showLoader();
    String  userToken = await SharedPref().getToken();
    String token = userToken;
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
        '${Endpoints.baseUrl}${Endpoints.getNylonBatchDelete}?batchId=$batchId',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        debugPrint("result ===> $result");
        Navigator.pop(context);
        if(result['status']){
          showDeleteSuccessDialog();
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        Navigator.pop(context);
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      Navigator.pop(context);
      print('Error: $error');
    }
  }
  //show delete success api
  showDeleteSuccessDialog(){
    return showDialog(
      context:
      context,
      builder:
          (BuildContext
      context) {
        Future.delayed(
            Duration(
                milliseconds: 800),
                () {
                  getNylonDetailsApi(context, "0", "1", "10", "").then(
                          (value) {
                        Navigator.pop(context);
                      });
                });

        return CupertinoAlertDialog(
          title: Row(
            children: [
              Container(
                padding:
                EdgeInsets.all(10),
                decoration:
                BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(30),
                  color:
                  AppColor.green,
                ),
                child:
                Icon(
                  Icons.done,
                  color:
                  Colors.white,
                ),
              ),
              Flexible(
                child:
                Text(
                  " User Deleted Successfully",
                  style:
                  TextStyle(fontSize: 15, color: AppColor.green),
                ),
              ),
            ],
          ), // show pop-up
        );
      },
    );
  }


  // get download url
  Future<void> getNylonBatchIdsDownloadUrlApi(batchIds) async {
     showLoader();
    // showDownloadingProcess();
    var userToken = await SharedPref().getToken();
    isLoading = true;
    update();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var data = json.encode({
      "batchIds":batchIds
    });
    print(data);
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var response = await dio.request(
      '${Endpoints.baseUrl}${Endpoints.getNylonBatchIdsDownloadUrl}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    debugPrint("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = response.data;
      debugPrint("response of getDownload url : $responseData");
      var status = responseData['status'];
      var message = responseData['message'];
      if (status == true) {
        String fileType = batchIds.length == 1?".pdf":"s.zip";
        String url = responseData['data']["url"];
        Navigator.pop(context);

        await _downloadFile(url,"${DateTime.now().millisecondsSinceEpoch}_Batch_PDF$fileType");
        isLoading = false;
        update();
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

  ValueNotifier<double> progress = ValueNotifier(0);
  showDownloadingProcess(){
    showDialog(
        context: context,
        builder:(_){
          return ValueListenableBuilder(
              valueListenable: progress,
              builder: (_,progressValue,child) {
                if(progress.value == 100){
                  Future.delayed(Duration(seconds: 1),(){
                    progress.value = 0;
                    Navigator.pop(context);
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
                          "Downloading....${progressValue.toStringAsFixed(0)}%":
                          "Downloaded"
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  Future<void> _downloadFile(String url, String filename) async {
     showDownloadingProcess();
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
        //
        // print(
        //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
        // double currentProgress = (rcv / total) * 100;
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

  GetNylonBatchItemsModel? getNylonBatchItemsModel;
  Future<GetNylonBatchItemsModel?> getNylonBatchItemsApi(BuildContext context,batchId) async {
    String  userToken = await SharedPref().getToken();
    String token = userToken;
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
        '${Endpoints.baseUrl}${Endpoints.getNylonBatchItemDetails}?batchId=$batchId',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        getNylonBatchItemsModel= GetNylonBatchItemsModel.fromJson(result);
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getNylonBatchItemsModel;
  }


}