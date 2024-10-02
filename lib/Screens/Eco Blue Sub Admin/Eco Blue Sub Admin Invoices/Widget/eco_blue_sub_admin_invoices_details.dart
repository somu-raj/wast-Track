import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../../../Models/Invoice/get_invoice_details_model.dart';
import '../../../../Utils/Components/custom_sanckbar.dart';
import '../../../../Utils/Components/dataStroage_database.dart';
import '../../../../Utils/Components/myShimmer.dart';

class EcoBlueSubInvoiceDetails extends StatefulWidget {
  final invoiceId;
  const EcoBlueSubInvoiceDetails({super.key,this.invoiceId});

  @override
  State<EcoBlueSubInvoiceDetails> createState() => _EcoBlueSubInvoiceDetailsState();
}

class _EcoBlueSubInvoiceDetailsState extends State<EcoBlueSubInvoiceDetails> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderInvoiceDetailsApi(context,widget.invoiceId);
  }
  GetInvoiceDetailsModel? getInvoiceDetailsModel;
  getOrderInvoiceDetailsApi(context,invoiceId) async {

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
        '${Endpoints.baseUrl}${Endpoints.getInvoiceDetailsList}?id=$invoiceId',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print("this is a response${response.statusCode}");
        var result = response.data;
        var finalResult = GetInvoiceDetailsModel.fromJson(result);
        setState(() {
          getInvoiceDetailsModel = finalResult;
        });


        CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getInvoiceDetailsModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 7),
                Text(
                  'Kepa Waste Track',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFont.poppinsBold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child:getInvoiceDetailsModel == null ?myShimmer():getInvoiceDetailsModel!.data!.referenceNo!.isEmpty ?? false ?  Text("No order invoice details !!") :ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Invoice Number: ',
                      style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontFamily: AppFont.poppinsMedium)),
                  Text(" IN-${getInvoiceDetailsModel!.data!.invoiceNo}",
                      style: TextStyle(
                          fontFamily: AppFont.poppinsSemiBold, fontSize: 14)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Reference:",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("Invoice Date",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${getInvoiceDetailsModel!.data!.referenceNo}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("${getInvoiceDetailsModel!.data!.createdAt}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Invoice From::",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsSemiBold,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.companyInfo!.brandName}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.companyInfo!.companyAddress}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("(+234) ${getInvoiceDetailsModel!.data!.companyInfo!.companyPhoneNo}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.companyInfo!.companyEmail}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Invoice To::",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsSemiBold,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.vendorId!.companyName}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.vendorId!.companyAddress}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("(+234) ${getInvoiceDetailsModel!.data!.vendorId!.phoneNumber}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${getInvoiceDetailsModel!.data!.vendorId!.email}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: AppColor.grey,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ITEM DETAIL ",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("RATE",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("QTY",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("AMOUNT",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: AppColor.grey,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nylon Rollins ",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("₦${getInvoiceDetailsModel!.data!.qtyPrice}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("${getInvoiceDetailsModel!.data!.qty}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("₦${getInvoiceDetailsModel!.data!.subTotal}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("₦${getInvoiceDetailsModel!.data!.subTotal}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Vendor Commissions (${getInvoiceDetailsModel!.data!.revisionCommissionPercentage}%)",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("₦${getInvoiceDetailsModel!.data!.revisionCommissionAmount}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: AppColor.grey,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("₦${getInvoiceDetailsModel!.data!.total}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Thanks for the business.",
                  style: TextStyle(
                    fontFamily: AppFont.poppinsSemiBold,
                    fontSize: 13,
                  )),
              SizedBox(
                height: 12,
              ),
              Text("BANK DETAILS",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular,
                      fontSize: 13,
                      color: AppColor.green)),
              SizedBox(
                height: 5,
              ),
              Text("Bank Transfer",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("Bank name: ${getInvoiceDetailsModel!.data!.bankInfo!.bankName}",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("SWIFT/IBAN: ${getInvoiceDetailsModel!.data!.bankInfo!.iban}",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("Account number: ${getInvoiceDetailsModel!.data!.bankInfo!.accountNumber}",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("Please use ${getInvoiceDetailsModel!.data!.referenceNo} as a reference number",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
