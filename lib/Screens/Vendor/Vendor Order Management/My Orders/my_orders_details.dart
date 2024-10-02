import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Vendor%20Order%20History%20Model/vendor_order_history_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Vendor/Order Management Controller/order_management_controller.dart';
import '../../../Admin/Vendor Manangement Screen/Order History/Widget/invoice_genrated.dart';

class OrdersDetails extends StatefulWidget {
  String? vendorId;
   OrdersDetails({super.key,this.vendorId});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  bool isButtonSelected = false;

  final controller = Get.put(OrderManagementController());
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMoreData = false;
 late OrderManagementController orderManagementController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderManagementController = OrderManagementController();
    callGetVendorCountApi();

  }

  callGetVendorCountApi()async{
    print("Surendra ");
    await controller.getVendorOrdersDetailsApi(context,widget.vendorId);
    setState(() {});
  }

  // String formatDate(String dateString) {
  //   DateTime dateTime = DateTime.parse(dateString);
  //   String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  //   return formattedDate;
  // }
  @override
  Widget build(BuildContext context) {
    // String timestamp = "${controller.getVendorOrderDetailsModel?.data?.createdAt}";
    // DateTime dateTime = DateTime.parse(timestamp);
    // String time = DateFormat.Hms().format(dateTime);
    // print('Time: $time');


    // String apiDateString = "${controller.getVendorOrderDetailsModel?.data?.createdAt}";
    // String formattedDate =
    // formatDate(apiDateString);

    return GetBuilder(
      init:  orderManagementController,
       builder: (controller) =>
       Scaffold(
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
          padding: EdgeInsets.only(top: 7, left: 10,right: 10),
          child:
          controller.getVendorOrderDetailsModel == null ? myShimmer(): controller.getVendorOrderDetailsModel!.data == null ?Text("No Order Details !!")  :
          ListView(
            children: [
              Text("Order Details :",
                  style: TextStyle(
                      fontFamily: AppFont.poppinsBold, fontSize: 15)),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Info :",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Id :",
                              style: TextStyle(
                                   fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.orderId}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date & Time :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.createdAt}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Method :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.paymentMethod}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invoice NO :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.invoiceNo}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Status :",
                              style: TextStyle(
                                  fontSize: 15)),
                          controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Pending"? Text("${controller.getVendorOrderDetailsModel?.data?.orderStatusText}",
                              style: TextStyle(fontSize: 15,color: AppColor.yellowLight)): controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Cancelled"? Text("${controller.getVendorOrderDetailsModel?.data?.orderStatusText}",
                              style: TextStyle(fontSize: 15,color: AppColor.redLight)) :Text("${controller.getVendorOrderDetailsModel?.data?.orderStatusText}",
                              style: TextStyle(fontSize: 15,color: AppColor.redLight))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Status :",
                              style: TextStyle(
                                  fontSize: 15)),
                          controller.getVendorOrderDetailsModel?.data?.paymentStatusText == "Unpaid"? Text("${controller.getVendorOrderDetailsModel?.data?.paymentStatusText}",
                              style: TextStyle(fontSize: 15,color: AppColor.redLight)):Text("${controller.getVendorOrderDetailsModel?.data?.paymentStatusText}",
                              style: TextStyle(fontSize: 15,color: AppColor.green))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Info :",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product Name :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("Nylon Bags",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.qtyPrice}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Qty(In Rolls) :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.qty}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.subTotal}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
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
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total :",
                              style: TextStyle(
                                  fontSize: 15,color: AppColor.black,fontWeight: FontWeight.bold)),
                          Text("₦${controller.getVendorOrderDetailsModel?.data?.total}",
                              style: TextStyle(fontSize: 15,color: AppColor.black,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Billing Details :",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.firstName}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.email}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Phone No :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.phoneNumber}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Address :",
                              style: TextStyle(
                                  fontSize: 15)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyAddress}",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Company Name: ",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyName}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              controller.isLoading ? CupertinoActivityIndicator(): Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Pending"? Expanded(
                    child: InkWell(
                      onTap: (){
                        controller.cancelOrderApi(context,controller.getVendorOrderDetailsModel?.data?.id ?? "").then((value) {
                         controller.getVendorOrdersApi(context, "1", "10", "");
                        });
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: AppColor.redLight)
                         // color: AppColor.redLight
                        ),
                        child:  Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel_outlined,color: AppColor.redLight,),
                            SizedBox(width: 5,),
                            Text("Cancel Order",style: TextStyle(color: AppColor.redLight)),
                          ],
                        )),
                      ),
                    ),
                  ):SizedBox(),
                  SizedBox(width: 5,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(Duration(seconds: 1), () {
                              // Navigator.pushNamed(context, AppScreen.orderHistoryInvoiceGenScreen);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderHistoryInvoiceGenerated(orderId: controller.getVendorOrderDetailsModel?.data?.id,))).then((value){
                                controller.getVendorOrdersDetailsApi(context, controller.getVendorOrderDetailsModel?.data?.id);
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Invoice Generate Successfully",
                                      style: TextStyle(
                                          fontSize: 14, color: AppColor.green),
                                    ),
                                  ),
                                ],
                              ), // show pop-up
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.green
                        ),
                        child: Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.file_copy,color: AppColor.white,),
                                SizedBox(width: 5,),
                                Text("Generate Invoice",style: TextStyle(color: AppColor.white),),
                              ],
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
