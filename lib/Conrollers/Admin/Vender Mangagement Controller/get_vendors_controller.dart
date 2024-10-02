



import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;


import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Get%20Vendors%20Model/get_vendors_model.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/vendor_management_screen.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';

import '../../../API Integration/app_base_controller.dart';
import '../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../Models/Vendor Management Model/Get Vendor Bank Details Model/get_vendor_bank_details_model.dart';
import '../../../Screens/Admin/User Management Screen/user_management_screen.dart';
import '../../../Utils/Components/custom_sanckbar.dart';
import '../../../Utils/Components/dataStroage_database.dart';
import '../../../Utils/colors/app_colors.dart';

class GetVendorsController extends AppBaseController {
  final BuildContext context; // Receive context in the constructor

  GetVendorsController({required this.context}); // Constructor
  bool isLoading = false;


  @override
  Future<void> onInit() async {
    super.onInit();
      await getVendorsApi(context, "1", "10", "", "1");
    if(getVendorsModel != null){
      declareAllVendorVisibilityController();
      if (getVendorsModel?.pagination?.totalItems != null &&
          (getVendorsModel!.pagination!.totalItems! >
              allVendorVisibilityController!.allVendorVisibleList.length)) {
        allVendorVisibilityController?.allVendorVisibleList = List.generate(getVendorsModel?.pagination?.totalItems??1, (index) => false).obs;
        // log("allVendorVisibleList added length ${allVendorVisibilityController.allVendorVisibleList.length}");
      }
    }
  }
   VendorManagementController? allVendorVisibilityController;
  declareAllVendorVisibilityController(){
     allVendorVisibilityController = Get.put(VendorManagementController(
         allVendorVisibleList: List.generate(getVendorsModel?.pagination?.totalItems??1, (index) => false).obs,
     ));
     log("allVendorVisibleList length ${allVendorVisibilityController!.allVendorVisibleList.length}");
  }


  /// get all vendors Api
  GetVendorsModel? getVendorsModel;
  Future<GetVendorsModel?> getVendorsApi(BuildContext context,page,limit,searchText,String?status) async {
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
        '${Endpoints.baseUrl}${Endpoints.getVendors}?page=${page}&limit=${limit}&searchText=${searchText}&status=${status}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GetVendorsModel.fromJson(result);
          getVendorsModel = finalResult;
          update();
        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");

        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }
 // Kepa Waste Track
  // => 06/05/24

 // Waste Management Agency
 // 1. get revenue/get-revenue-sharing-for-all api
  //2.revenue/get-revenue-sharing api
  //3. revenue/get-revenue-shared-listing api
 // 4. search api
 // 5. qr scanner implementation

 // Nylon Company
  //1. nylonproduction/add-nylonproductionagency
  //2. nylonproduction/delete-nylonproductionagency

 // Eco Blue
  //1.get Vendor Api
  /// delete vendor Api
  Future<void> deleteVendorsApi(String roleId) async {
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
        '${Endpoints.baseUrl}${Endpoints.deleteVendor}?id=${roleId}',
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
              Future.delayed(Duration(milliseconds:0), () {
                getVendorsApi(context, "1", "10", "", "1").then(
                        (value){
                          Navigator.pop(context);
                        });

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

      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }



}