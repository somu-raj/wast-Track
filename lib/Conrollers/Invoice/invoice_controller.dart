
import 'dart:convert';
import 'dart:core';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import '../../API Integration/app_base_controller.dart';
import '../../Models/Invoice/get_invoice_details_model.dart';
import '../../Models/Invoice/invoice_model.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
class OrderInvoiceController extends AppBaseController {
  bool isHidden = true;
  bool isLoading = false;
  BuildContext? context; // Receive context in the constructor
  OrderInvoiceController({required this.context});

  @override
  Future<void> onInit() async {
    super.onInit();
   await getOrderInvoiceApi(context,"1","10","");
  }
  /// get Order Invoice Api
  GetInvoiceModel? invoiceModel;
  Future<GetInvoiceModel?> getOrderInvoiceApi(context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getInvoiceList}?page=$page&limit=$limit&searchText=$searchText',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("this is a response${response.statusCode}");
        var result = response.data;
        var finalResult = GetInvoiceModel.fromJson(result);
        invoiceModel = finalResult;
        update();
        CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return invoiceModel;
  }

  // /// get Order Invoice Details Api
  // GetInvoiceDetailsModel? getInvoiceDetailsModel;
  // Future<GetInvoiceDetailsModel?> getOrderInvoiceDetailsApi(context,invoiceId) async {
  //
  //   var userToken = await SharedPref().getToken();
  //   var token = "${userToken}";
  //   var headers = {
  //     'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
  //   };
  //   var dio = Dio();
  //   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
  //   HttpClient()
  //     ..badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //   try {
  //     Response response = await dio.get(
  //       '${Endpoints.baseUrl}${Endpoints.getInvoiceDetailsList}?id=$invoiceId',
  //       options: Options(
  //         headers: headers,
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       print("this is a response${response.statusCode}");
  //       var result = response.data;
  //       var finalResult = GetInvoiceDetailsModel.fromJson(result);
  //
  //       getInvoiceDetailsModel = finalResult;
  //       update();
  //       CustomSnackBar.mySnackBar(context, "${finalResult.message}");
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  //   return getInvoiceDetailsModel;
  // }

  /// download order Invoice
  generateOrderInvoiceApi(context,String orderId) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
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
      '${Endpoints.baseUrl}${Endpoints.generateInvoiceOrder}?id=${orderId}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      var result = json.encode(response.data);
      var finalResult = jsonDecode(result);
      isLoading = false;
      update();
      if(finalResult['status'] == true){

        String fileType = ".pdf";
        String url = finalResult['data']["url"];
        // Navigator.pop(context);
        print(url);
        await _downloadFile(url,"${DateTime.now().millisecondsSinceEpoch}_Invoice_PDF$fileType",context);
      }else{
        CustomSnackBar.mySnackBar(context, finalResult['message'].toString());
        isLoading = false;
        update();
      }

    }
    else {
      isLoading = false;
      update();
      print(response.statusMessage);
    }

  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<double>? progress; // Nullable type

  Future<void> _downloadFile(String url, String filename, BuildContext context) async {
    print(url);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading Order Invoice...'),
      ),
    );
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
        ScaffoldMessenger.of(context).setState(() {
          progress?.value = (rcv / total) * 100; // Assuming progress is a stateful widget
        });
      },
      deleteOnError: true,
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
