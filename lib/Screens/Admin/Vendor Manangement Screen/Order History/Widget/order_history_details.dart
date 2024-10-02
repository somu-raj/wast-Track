import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Conrollers/Vendor/Order Management Controller/order_management_controller.dart';
import 'invoice_genrated.dart';

class OrderHistoryDetails extends StatefulWidget {
  String? orderId;
   OrderHistoryDetails({super.key,this.orderId});

  @override
  State<OrderHistoryDetails> createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {

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


  // String formatDate(String dateString) {
  //   if (dateString.isEmpty) {
  //     return 'Date Not Available'; // or any other default value you prefer
  //   }
  //   try {
  //     DateTime dateTime = DateTime.parse(dateString);
  //     String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  //     return formattedDate;
  //   } catch (e) {
  //     print('Error parsing date: $e');
  //     return 'Invalid Date';
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    // print("this is sis${widget.orderId}");
    // String timestamp = "${controller.getVendorOrderDetailsModel?.data?.createdAt}";
    // DateTime dateTime = DateTime.parse(timestamp);
    // String time = DateFormat.Hms().format(dateTime);
    // print('Time: $time');
    //
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
      body:controller.getVendorOrderDetailsModel == null ? myShimmer(): controller.getVendorOrderDetailsModel!.data == null ?Text("No Order Details !!"): Padding(
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
                  GestureDetector(
                    onTap: (){
                      if(controller.getVendorOrderDetailsModel?.data?.orderStatusText == 'Completed'){
                        return;
                      }
                      controller.orderConfirmApi(widget.orderId ?? "",controller.getVendorOrderDetailsModel?.data?.orderStatus,context).then((value){
                        controller.getVendorOrdersDetailsApi(context,widget.orderId);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.greenLight.withOpacity(0.5)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.order_approve,
                            height: 15,
                          ),
                          SizedBox(width: 7),
                          controller.isLoading ? CupertinoActivityIndicator(): Text(
                            controller.getVendorOrderDetailsModel?.data?.orderStatusText == 'Completed' ? "Completed" :
                            controller.getVendorOrderDetailsModel?.data?.orderStatusText == 'Confirmed' ? "Complete Order" :
                            'Confirm Order',
                            style:
                            TextStyle(color: AppColor.green, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryInvoiceGenerated(orderId: widget.orderId,)));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(Duration(seconds: 1), () {
                            // Navigator.pushNamed(context, AppScreen.orderHistoryInvoiceGenScreen);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryInvoiceGenerated(orderId: widget.orderId,)));
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
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.green),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.receipt_long,
                            height: 15,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Generate Invoice',
                            style: TextStyle(color: Colors.white, fontSize: 14),
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
                      Text("Order Info",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Id :",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsLight,
                                  fontSize: 13)),
                          Text("#${controller.getVendorOrderDetailsModel?.data?.orderId}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date & Time",
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Method",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("${controller.getVendorOrderDetailsModel?.data?.paymentMethod}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invoice Number",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Text("#${controller.getVendorOrderDetailsModel?.data?.invoiceNo}",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Status",
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 14,
                                color: controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Pending" ? AppColor.orange : controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Cancelled" ?AppColor.redLight :controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Confirmed" ?AppColor.green : AppColor.green,
                              ),
                              Text("${controller.getVendorOrderDetailsModel?.data?.orderStatusText}",
                                  style: TextStyle(
                                      color: controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Pending" ? AppColor.orange : controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Cancelled" ?AppColor.redLight :controller.getVendorOrderDetailsModel?.data?.orderStatusText == "Confirmed" ?AppColor.green : AppColor.green ,
                                      fontFamily: AppFont.poppinsRegular,
                                      fontSize: 13)),
                            ],
                          ),
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
                height: 15,
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
                      Text("Product Details",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.dust,
                            height: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nylon Bags",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsRegular,
                                      fontSize: 13)),
                              SizedBox(
                                height: 5,
                              ),
                              Text("₦${controller.getVendorOrderDetailsModel?.data?.subTotal}",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsRegular,
                                      fontSize: 13)),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Ordered Quantities: ${controller.getVendorOrderDetailsModel?.data?.qty}",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsRegular,
                                      fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                      Text("Payment Details",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                      SizedBox(
                        height: 10,
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
                                  fontFamily: AppFont.poppinsRegular,
                                  fontSize: 13)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                        height: 15,
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
                height: 15,
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
                      Text(
                        " Billing Details",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 14,
                            fontFamily: AppFont.poppinsBold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyName}",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsSemiBold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            color: AppColor.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            " ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.firstName}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsMedium),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.email_outlined, color: AppColor.green),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            " ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.email}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsMedium),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call_end_outlined, color: AppColor.green),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            "+234 ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.phoneNumber}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsMedium),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: AppColor.green),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            " ${controller.getVendorOrderDetailsModel?.data?.vendorInfo?.companyAddress}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsMedium),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("Revenue Shared",
                          style: TextStyle(
                              fontFamily: AppFont.poppinsBold, fontSize: 15)),
                    ),

                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      padding: EdgeInsets.all(15.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.getVendorOrderDetailsModel?.data?.orderSharing.length,
                          itemBuilder: (context,i){
                        var orderSharingList = controller.getVendorOrderDetailsModel?.data?.orderSharing[i];
                        return  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text("${orderSharingList!.companyName}(${orderSharingList.sharingPercentage}%)",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsRegular,
                                          fontSize: 12)),
                                ),
                                Flexible(
                                  child: Text("₦${orderSharingList.sharingAmount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsRegular,
                                          fontSize: 12,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                          ],
                        );
                      })
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
