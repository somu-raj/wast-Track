import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Conrollers/Vendor/Order Management Controller/order_management_controller.dart';

class OrderHistoryInvoiceGenerated extends StatefulWidget {
  String? orderId;
   OrderHistoryInvoiceGenerated({super.key,this.orderId});

  @override
  State<OrderHistoryInvoiceGenerated> createState() =>
      _OrderHistoryInvoiceGeneratedState();
}

class _OrderHistoryInvoiceGeneratedState extends State<OrderHistoryInvoiceGenerated> {


  bool isButtonSelected = false;

  final controller = Get.put(OrderManagementController());
  bool isLoadingMoreData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetVendorDetailsApi();

  }

  callGetVendorDetailsApi()async{
    await controller.getVendorOrdersDetailsApi(context,widget.orderId);
    setState(() {});
  }

/// format date and time
//   String formatDate(String dateString) {
//     try {
//       DateTime dateTime = DateTime.parse(dateString);
//       String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
//       return formattedDate;
//     } catch (e) {
//       print('Error parsing date: $e');
//       return 'Invalid Date';
//     }
//   }
  @override
  Widget build(BuildContext context) {
    print("this is sis${widget.orderId}");
    /// time convert
    // String timestamp = "${controller.getVendorOrderDetailsModel?.data?.createdAt ?? ""}";
    // DateTime dateTime = DateTime.parse(timestamp);
    // String time = DateFormat.Hms().format(dateTime);

    /// date convert
    // String apiDateString = "${controller.getVendorOrderDetailsModel?.data?.createdAt ?? ""}";
    // String formattedDate = formatDate(apiDateString);
    // print('Formatted Date: $formattedDate');
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
      body:
     // controller.getVendorOrderDetailsModel?.data == null ?  Center(child: Text("No invoice data !!")):
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Invoice Number: ',
                          style: TextStyle(
                              color: AppColor.black.withOpacity(0.5),
                              fontFamily: AppFont.poppinsMedium)),
                      Text(" ${controller.getVendorOrderDetailsModel?.data?.invoiceNo}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsSemiBold,
                              fontSize: 14)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                     controller.generateInvoiceApi(context,controller.getVendorOrderDetailsModel?.data?.id ?? "");

                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.green),
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Download',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
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
                          Text("${controller.getVendorOrderDetailsModel?.data?.referenceNo}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.createdAt}",
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
                      Text("Kepa Waste Track",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Company Address, ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyAddress} ",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("(+234) ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.phoneNumber}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.email}",
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
                      Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyName}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Company Address, ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyAddress} ",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("(+234) ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.phoneNumber}",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsRegular,
                              fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.email}",
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
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.qtyPrice}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.qty}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.subTotal}",
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
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.subTotal}",
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
                          Text("Vendor Commissions (${controller.getVendorOrderDetailsModel?.data?.revisionCommissionPercentage}%)",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.revisionCommissionAmount}",
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
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.total}",
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
              Text("Bank name: ABC Bank limited",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("SWIFT/IBAN: NZ0201230012",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("Account number: 12-1234-123456-12",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsRegular, fontSize: 13)),
              SizedBox(
                height: 5,
              ),
              Text("Please use INV-057 as a reference number",
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
