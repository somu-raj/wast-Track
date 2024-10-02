import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Get%20Nylon%20Model/get_nylon_model.dart';
import 'package:waste_track/Models/Vendor/Order%20Management%20Model/get_nylon_buy_model.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import '../../../Models/Vendor/Order Management Model/get_vendor_order_count_model.dart';
import '../../../Models/Vendor/Order Management Model/get_vendor_order_details_model.dart';
import '../../../Models/Vendor/Order Management Model/get_vendor_orders_model.dart';
import '../../../Screens/Vendor/Vendor Order Management/vendor_order_management.dart';
import '../../../Utils/colors/app_colors.dart';

class OrderManagementController extends GetxController {
  RxBool isPayOnPickupVisible = false.obs;
  RxBool isButtonEnabled = false.obs;
  RxBool waiting = true.obs;
  RxInt quantity =  0.obs;
  RxInt availableQuantity =  0.obs;
  bool isLoading = false;
  void ButtonVisibility() {
    isButtonEnabled.value = true;
  }
  void decreaseQuantity(){
    if(quantity.value>1){
      quantity.value--;
    }
  }
  void increaseQuantity(){
    if(availableQuantity > quantity.value){
      quantity.value++;
    }
  }
  void PayOnPickupVisibility() {
    isPayOnPickupVisible.value = true;
  }

  /// get price and quantity of Nylon
  GetNylonModel? getNylonModel;
  Future<GetNylonModel?> getNylonApi(BuildContext context) async {
    waiting.value = true;
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
        '${Endpoints.baseUrl}${Endpoints.nylonGeneration}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getNylonModel = GetNylonModel.fromJson(result);
        if(!(getNylonModel?.status??false)&&(getNylonModel?.isTokenExpired??true)){
          CustomSnackBar.mySnackBar(
              context, "${getNylonModel!.message}");
        }
        else{
          waiting.value = false;
          availableQuantity.value = getNylonModel?.data?.availableQty??0;
          debugPrint("available quantity ==>${availableQuantity.value}");
          debugPrint("nylon price and quantity fetched successfully!!!");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getNylonModel;
  }

  /// get Buy Nylon Details
  GetNylonBuyDetailsModel? getBuyNylonDetailsModel;
  Future<GetNylonBuyDetailsModel?> getNylonDetailsApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.getBuyNylonDetails}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getBuyNylonDetailsModel = GetNylonBuyDetailsModel.fromJson(result);
        if(!(getBuyNylonDetailsModel?.status??false)&&(getBuyNylonDetailsModel?.isTokenExpired??true)){
          CustomSnackBar.mySnackBar(
              context, "${getBuyNylonDetailsModel!.message}");
        }
        else{
          waiting.value = false;
          debugPrint("nylon buy details fetched successfully!!!");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getBuyNylonDetailsModel;
  }

  /// get Vendor Order Counts
  GetVendorOrderCountModel? getVendorOrderCountModel;
  Future<GetVendorOrderCountModel?> getVendorOrderCountsApi(BuildContext context) async {
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
        '${Endpoints.baseUrl}${Endpoints.getVendorOrderCount}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorOrderCountModel = GetVendorOrderCountModel.fromJson(result);
        if(getVendorOrderCountModel?.status == true){
          CustomSnackBar.mySnackBar(
              context, "${getVendorOrderCountModel!.message}");
        }
        else{
          waiting.value = false;
          //debugPrint("nylon buy details fetched successfully!!!");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorOrderCountModel;
  }

  /// get Vendor Orders Api
  GetVendorOrdersModel? getVendorOrdersModel;
  Future<GetVendorOrdersModel?> getVendorOrdersApi(context,page,limit,searchText) async {
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
        '${Endpoints.baseUrl}${Endpoints.getVendorOrders}',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        dynamic result = response.data;
        getVendorOrdersModel = GetVendorOrdersModel.fromJson(result);
        update();
        if(getVendorOrdersModel?.status == true){
          CustomSnackBar.mySnackBar(
              context, "${getVendorOrdersModel!.message}");
          debugPrint("this sis ${getVendorOrdersModel?.data.length}");
          debugPrint("this sis ${result}");
        }
        else{
          waiting.value = false;
         // debugPrint("nylon buy details fetched successfully!!!");
        }
        update();
        //  CustomSnackBar.mySnackBar(context, "${getVendorAllStaffModel!.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorOrdersModel;
  }

  /// get Vendor Orders Details
   GetVendorOrderDetailsModel? getVendorOrderDetailsModel;
   getVendorOrdersDetailsApi(context,vendorId) async {
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
      '${Endpoints.baseUrl}${Endpoints.getVendorOrdersDetails}?id=${vendorId}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );
     print(response);
    if (response.statusCode == 200) {
      var result = json.encode(response.data);
      var finalResult = GetVendorOrderDetailsModel.fromJson(json.decode(result));
      update();
      getVendorOrderDetailsModel = finalResult;
      print(finalResult);
    }
    else {
      print(response.statusMessage);
    }
  }


 /// order Place
  Future<void> placeOrderApi(int? quantity,int ? paymentStatus, context) async {
    isLoading = true;
    update();
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var requestData = {
      'qty':quantity,
      'payment_status':paymentStatus,
    };
    print(requestData);
    var url = '${Endpoints.baseUrl}${Endpoints.placeOrder}';
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
      debugPrint("this Is StatusCode ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        if (result['status'] == true) {

          //getEcoBlueSubAdminApi(context,'1','10','');
          isLoading = false;
          //update();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 1), () {
                this.quantity.value = 0;
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
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "Order placed successfully",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.green),
                      ),
                    ),
                  ],
                ), // show pop-up
              );
            },
          );
          update();
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


  /// cancel order
  cancelOrderApi(context,String orderId) async {
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
      '${Endpoints.baseUrl}${Endpoints.cancelOrder}?id=${orderId}',
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
        CustomSnackBar.mySnackBar(context, finalResult['message'].toString());
        Navigator.pop(context);
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

 /// download invoice
  generateInvoiceApi(context,String orderId) async {
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
       print("before");
        String fileType = ".pdf";
        String url = finalResult['data']["url"];
       // Navigator.pop(context);
        print(url);
       print("after");
        await _downloadFile(url,"${DateTime.now().millisecondsSinceEpoch}_Invoice_PDF$fileType",context);
        //CustomSnackBar.mySnackBar(context, finalResult['message'].toString());
      //  Navigator.pop(context);
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


  /// order status
  Future<void> orderConfirmApi(orderId,status, context) async {
     print(status);
    isLoading = true;
    update();

    var userToken = await SharedPref().getToken();
    var token = "$userToken";
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var requestData = {
      "id":orderId.toString(),
      "order_status":status == 0 ?"2":status==2? "3":""
    };

    print("order_status${requestData}");
    var url = '${Endpoints.baseUrl}${Endpoints.orderStatus}';
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
         print("Response data: $result"); // Add this line for debugging

         if (result['status']??false) {
           print("Status: ${result['status']}"); // Add this line for debugging
           isLoading = false;
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
           isLoading = false;
           update();
           CustomSnackBar.mySnackBar(context, result['message'].toString());
         }
       } else {

         isLoading = false;
         update();
         debugPrint("Failed with status code: ${response.statusCode}");
         debugPrint("Response data: ${response.data}");
         throw Exception("Something went Wrong!!");
       }
     } catch (e) {
       isLoading = false;
       update();
       debugPrint("Error: $e");
       throw Exception("Something went Wrong!!");
     }
  }



  /// download function
 // ValueNotifier<double>? progress; // Add a nullable type here

  showDownloadingProcess(context){
    showDialog(
        context: context,
        builder:(_){
          return ValueListenableBuilder(
              valueListenable: progress!,
              builder: (_,progressValue,child) { // Add a null check here as well
                if(progress!.value == 100){ // Null check added here
                  Future.delayed(Duration(seconds: 1),(){
                    progress!.value = 0; // Null check added here
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

  // Future<void> _downloadFile(String url, String filename,context) async {
  //   showDownloadingProcess(context);
  //   String finalFilename = await getFilePath(filename);
  //   var dio = Dio();
  //   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
  //   HttpClient()
  //     ..badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //   await dio.download(
  //       url,
  //       finalFilename,
  //       onReceiveProgress: (rcv, total) async {
  //
  //         await Future.delayed(Duration(milliseconds: 300));
  //         //
  //         // print(
  //         //     'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
  //         // double currentProgress = (rcv / total) * 100;
  //         progress?.value = (rcv / total) * 100;
  //
  //         // if (progress.value == 100) {
  //         //  debugPrint("download success of $finalFilename}");
  //         // } else if (progress.value < 100) {
  //         //
  //         // }
  //       },
  //       deleteOnError:true
  //   ).then(
  //           (val){
  //
  //       }
  //   );
  // }
  //
  // Future<String> getFilePath(uniqueFileName) async {
  //   String path = '';
  //   Directory dir = Platform.isAndroid
  //       ? Directory('/storage/emulated/0/Download')
  //       : await getApplicationDocumentsDirectory();
  //   path = '${dir.path}/$uniqueFileName';
  //   return path;
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<double>? progress; // Nullable type

  Future<void> _downloadFile(String url, String filename, BuildContext context) async {
    print(url);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading Invoice...'),
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
