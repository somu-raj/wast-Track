


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/Nylon Generation Model/Get Nylon Model/get_nylon_model.dart';
import '../../../Models/Vendor Staff/Vendor Staff Waste Collected Model/get_vendor_staff_waste_collected_model.dart';
import '../../../Models/Vendor Staff/Vendor Staff Waste Collected Model/get_waste_collected_model.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/colors/app_colors.dart';


class WasteCollectedController extends AppBaseController {
  String? vendorId;
  final BuildContext context; // Receive context in the constructor

  WasteCollectedController({required this.context}); // Constructor
  bool isLoading = false;
  bool isGeneratedDetails = true;
  bool isLoadingQuantity = false;
  bool isPendingRequest = true;
  String? subAdmin;
  List<bool> wasteCollectedVisibilityList =[];
  List<bool> wasteCollectedVisibilityListForNotFound =[];
  @override
  Future<void> onInit() async {
    super.onInit();
    getVendorStaffCollectionApi(context,"0","10","");

    //await getWasteCollectionApi(context,"1","","","");
  }

  getWasteCollectedVisibilityList(){
    if(getWasteCollectionListModel != null){
      wasteCollectedVisibilityList = List.generate(getWasteCollectionListModel?.data.length??0, (index) => false);
      wasteCollectedVisibilityListForNotFound = List.generate(getWasteCollectionListModel?.data.length??0, (index) => false);
    }
  }


  /// get Vendor Staff Collection Api
  GetVendorStaffCollectionListModel? getVendorStaffCollectionListModel;
  Future<GetVendorStaffCollectionListModel?> getVendorStaffCollectionApi(context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getCollectionListApi}?page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetVendorStaffCollectionListModel.fromJson(result);
        getVendorStaffCollectionListModel = finalResult;
        update();
       // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorStaffCollectionListModel;
  }


  /// get waste collection Api
  GetWasteCollectionListModel? getWasteCollectionListModel;
  GetWasteCollectionListModel? getWasteVerifyCollectionListModel;
  Future<GetWasteCollectionListModel?> getWasteCollectionApi(context,page,limit,searchText,status) async {
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
        '${Endpoints.baseUrl}${Endpoints.getWasteCollectionListApi}?page=$page&limit=$limit&searchText=$searchText&isPending=$status',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        var finalResult = GetWasteCollectionListModel.fromJson(result);
        if(isPendingRequest){
          getWasteCollectionListModel = finalResult;
        }else{
          getWasteVerifyCollectionListModel = finalResult;
        }
        getWasteCollectedVisibilityList();
        update();
       // CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  /// update-collection-status
  Future<void> updateCollectionStatusApi(orderId,status,index, context) async {
    print(status);
    if(status==2){
      wasteCollectedVisibilityList[index] = true;
    }else{
      wasteCollectedVisibilityListForNotFound[index] = true;
    }
    update();

    var userToken = await SharedPref().getToken();
    var token = "$userToken";
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var requestData = {
      "id": orderId,
      "approval_status": status
    };

    print("this is parameter----${requestData}");
    var url = '${Endpoints.baseUrl}${Endpoints.updateCollectionApi}';
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(requestData),
      );
      debugPrint("this Is StatusCode ${response.statusCode}");

      if (response.statusCode == 200) {
        var result = response.data;
        //var finalResult = jsonDecode(result);
        print("Response data: $result"); // Add this line for debugging

        if (result['status']??false) {
          print("Status: ${result['status']}"); // Add this line for debugging
          if(status==2){
            wasteCollectedVisibilityList[index] = false;
          }else{
            wasteCollectedVisibilityListForNotFound[index] = false;
          }
          update();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 1), () {
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
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "${result['message']}",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.green),
                      ),
                    ),
                  ],
                ),
              ); // show pop-up
            },
          );
          update();
        } else {
          if(status==2){
            wasteCollectedVisibilityList[index] = false;
          }else{
            wasteCollectedVisibilityListForNotFound[index] = false;
          }
          update();
          CustomSnackBar.mySnackBar(context, result['message'].toString());
        }
      } else {
        if(status==2){
          wasteCollectedVisibilityList[index] = false;
        }else{
          wasteCollectedVisibilityListForNotFound[index] = false;
        }
        update();
        debugPrint("Failed with status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
        throw Exception("Something went Wrong!!");
      }
    } catch (e) {
      if(status==2){
        wasteCollectedVisibilityList[index] = false;
      }else{
        wasteCollectedVisibilityListForNotFound[index] = false;
      }
      update();
      debugPrint("Error: $e");
      throw Exception("Something went Wrong!!");
    }

  }

}