

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import 'scanner_view.dart';

class ScannerButton extends StatefulWidget {
  const ScannerButton({super.key, required this.onChange,this.loginScreen});
  final Function(bool,String,bool) onChange;
  final bool? loginScreen;

  @override
  State<ScannerButton> createState() => _ScannerButtonState();
}

class _ScannerButtonState extends State<ScannerButton> {
  String? serialNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanner()));
        // if (!context.mounted) return;
        // if(result != null){
        //   serialNumber = result;
        //   widget.onChange(true,"",false);
        //   //widget.serialNumberChanged!(value);
        //   debugPrint("serial number ===> '$serialNumber'");
        //   getVerifySerialNumberApi(serialNumber).then(
        //           (value) {
        //         widget.onChange(false,value["message"]??"something went wrong please try again!!",value["status"]??false);
        //       },
        //       onError: (error){
        //             widget.onChange(false,"something went wrong please try again!!",false);
        //       });
        // }
        // else{
        //   // serialNumber = null;
        //   // CustomSnackBar.mySnackBar(context, "Serial Number Not Found!!");
        // }
        if(serialNumber != null){
          serialNumber = null;
        }
        showConfirmDialogForScanning();
      },
      child: Container(
        padding: EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.green,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'Upload Collected Nylon',
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppFont.poppinsSemiBold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// get verify serial number in case of vendor staff
  Future<dynamic> getVerifySerialNumberApi(serialNumber) async {
    debugPrint("get verify api called serial number ==> $serialNumber");
    String  userToken = await SharedPref().getToken();
    String userType = await SharedPref().getUserType();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    dynamic result;
    String endPoint = userType == "5"? Endpoints.verifyVendorStaffSerialNumber :Endpoints.verifyWasteMStaffSerialNumber;
    debugPrint("end point of verify serial number ===> $endPoint");
    String url = '${Endpoints.baseUrl}$endPoint?serialNumber=$serialNumber';
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
         result = response.data;
        // showVerifyDialog(result["message"], result["status"]);
        // CustomSnackBar.mySnackBar(context, "${result["message"]}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {

      print('Error: $error');
    }
    return result;
  }

  ///show dialog for confirm for qr scan or serial number enter manually
  showConfirmDialogForScanning(){
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text("Select an Option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>QRScanner()));
                    if (!context.mounted) return;
                    if(result != null){
                      serialNumber = result;
                      widget.onChange(true,"",false);
                      //widget.serialNumberChanged!(value);
                      debugPrint("serial number ===> '$serialNumber'");
                      getVerifySerialNumberApi(serialNumber).then(
                              (value) {
                            widget.onChange(false,value["message"]??"something went wrong please try again!!",value["status"]??false);
                          },
                          onError: (error){
                            widget.onChange(false,"something went wrong please try again!!",false);
                          });
                    }
                    else{
                      // serialNumber = null;
                      // CustomSnackBar.mySnackBar(context, "Serial Number Not Found!!");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Scan Serial QR Code',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFont.poppinsSemiBold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              showTextFormField().then(
                      (value) {
                        if (!context.mounted) return;
                        if(value != null && value.isNotEmpty){
                          serialNumber = value;
                          widget.onChange(true,"",false);
                          //widget.serialNumberChanged!(value);
                          debugPrint("serial number ===> '$serialNumber'");
                          getVerifySerialNumberApi(serialNumber).then(
                                  (value) {
                                widget.onChange(false,value["message"]??"something went wrong please try again!!",value["status"]??false);
                              },
                              onError: (error){
                                widget.onChange(false,"something went wrong please try again!!",false);
                              });
                        }
                        else{
                          // serialNumber = null;
                          // CustomSnackBar.mySnackBar(context, "Serial Number Not Found!!");
                        }
                      }
              );
              // if(result != null){
              //   serialNumber = result;
              //   widget.onChange(true,"",false);
              //   //widget.serialNumberChanged!(value);
              //   debugPrint("serial number ===> '$serialNumber'");
              //   getVerifySerialNumberApi(serialNumber).then(
              //           (value) {
              //         widget.onChange(false,value["message"]??"something went wrong please try again!!",value["status"]??false);
              //       },
              //       onError: (error){
              //         widget.onChange(false,"something went wrong please try again!!",false);
              //       });
              // }
              // else{
              //   // serialNumber = null;
              //   // CustomSnackBar.mySnackBar(context, "Serial Number Not Found!!");
              // }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Enter Serial Manually',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppFont.poppinsSemiBold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
              ],
            ),
          );
        });
  }

  ///show TextFormField for enter serial number manually
  Future<String?> showTextFormField() async {
    String? result = await showDialog
      (context: context,
        builder: (_){
        final TextEditingController serialTextFormFieldController = TextEditingController();
        return AlertDialog(
          content: Column(
            mainAxisSize:  MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Enter Serial Number",style: TextStyle(fontSize: 16),),
              const SizedBox(height: 8,),
              CustomTextField(
                controller: serialTextFormFieldController,
                hintText: "Enter Serial Number",
                hintStyle: TextStyle(
                    color: AppColor.grey1,
                    fontSize: 13,
                    fontFamily: AppFont
                        .poppinsRegular),
              ),
            ],
          ),
          actions: [
               GestureDetector(
                   onTap: (){
                    Navigator.pop(context,serialTextFormFieldController.text);
                },
                   // style: TextButton.styleFrom(
                   //   foregroundColor: AppColor.green
                   // ),
                child: Text("Ok",
                  style: TextStyle(fontSize: 16),
                )),
               SizedBox(width: 10,height: 40,)
          ],
        );
        });
    debugPrint("serial entered manually ===> $result");
    return result;
  }
}

