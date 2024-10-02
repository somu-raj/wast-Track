import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Conrollers/Vendor/Withdraw%20Request%20Controller/vendor_withdraw_request_history_controller.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_list_model.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class WithdrawalHistoryDetails extends StatefulWidget {
  const WithdrawalHistoryDetails({super.key, this.data});
  final GetVendorWithdrawRequestHistoryListData? data;

  @override
  State<WithdrawalHistoryDetails> createState() =>
      _WithdrawalHistoryDetailsState();
}

class _WithdrawalHistoryDetailsState extends State<WithdrawalHistoryDetails> {
  final VendorWithdrawRequestHistoryController vendorWithdrawRequestHistoryController = VendorWithdrawRequestHistoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
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
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            widget.data?.status == 1? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row(
                //   children: [
                //     // Text('Unique ID: ',
                //     //     style: TextStyle(
                //     //         color: AppColor.black.withOpacity(0.5),
                //     //         fontFamily: AppFont.poppinsMedium)),
                //     Text(" #${widget.data?.requestId??""}",
                //         style: TextStyle(
                //             fontFamily: AppFont.poppinsSemiBold, fontSize: 14)),
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     Future.delayed(Duration(seconds: 1), () {
                    //       Navigator.pop(context);
                    //     });
                    //
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
                    //           SizedBox(
                    //             width: 3,
                    //           ),
                    //           Flexible(
                    //             child: Text(
                    //               "Receipt Download Successfully",
                    //               style: TextStyle(
                    //                   fontSize: 14, color: AppColor.green),
                    //             ),
                    //           ),
                    //         ],
                    //       ), // show pop-up
                    //     );
                    //   },
                    // );
                    vendorWithdrawRequestHistoryController.getWithdrawRequestDownloadUrlApi(context, widget.data?.id??"");
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
                          'Download Receipt',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ):
                const SizedBox.shrink(),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 1,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request Info",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                          fontFamily: AppFont.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " Request ID :",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                        Text(
                          "#${widget.data?.requestId??""}",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Request Date:",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                        Text(
                          "${widget.data?.requestedDate??""}",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.data?.status == 1  ||widget.data?.status ==2?10:0,
                    ),
                    widget.data?.status == 1  ||widget.data?.status ==2?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.data?.status == 1 ?'Approve': widget.data?.status ==2?"Reject":'Approve/Reject'} Date",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 14,
                              fontFamily: AppFont.poppinsLight),
                        ),
                        Text(
                          "${widget.data?.approvalDate??"--"}",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 14,
                              fontFamily: AppFont.poppinsLight),
                        ),
                      ],
                    ):
                        const SizedBox.shrink(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Rejection Date & Time:",
                    //       style: TextStyle(
                    //           color: AppColor.black,
                    //           fontSize: 14,
                    //           fontFamily: AppFont.poppinsLight),
                    //     ),
                    //     Text(
                    //       "2 Sept 2023, 11:45AM",
                    //       style: TextStyle(
                    //           color: AppColor.black,
                    //           fontSize: 14,
                    //           fontFamily: AppFont.poppinsLight),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status:",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: widget.data?.status==0?
                              AppColor.orange
                                  :widget.data?.status==1?
                              AppColor.green
                                  :widget.data?.status==2?
                              Colors.red
                                  :
                              AppColor.purpleDark,
                              size: 20,
                            ),
                            Text(
                              "${widget.data?.statusText??""}",
                              style: TextStyle(
                                  color: widget.data?.status==0?
                                  AppColor.orange
                                      :widget.data?.status==1?
                                  AppColor.green
                                      :widget.data?.status==2?
                                  Colors.red
                                      :
                                  AppColor.purpleDark,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsSemiBold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Status:",
                    //       style: TextStyle(
                    //           color: AppColor.black,
                    //           fontSize: 13,
                    //           fontFamily: AppFont.poppinsLight),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.circle,
                    //           color: AppColor.green,
                    //           size: 20,
                    //         ),
                    //         Text(
                    //           "Approve",
                    //           style: TextStyle(
                    //               color: AppColor.green,
                    //               fontSize: 13,
                    //               fontFamily: AppFont.poppinsSemiBold),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Status:",
                    //       style: TextStyle(
                    //           color: AppColor.black,
                    //           fontSize: 13,
                    //           fontFamily: AppFont.poppinsLight),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.circle,
                    //           color: Colors.red,
                    //           size: 20,
                    //         ),
                    //         Text(
                    //           "Rejected",
                    //           style: TextStyle(
                    //               color: Colors.red,
                    //               fontSize: 13,
                    //               fontFamily: AppFont.poppinsSemiBold),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Status:",
                    //       style: TextStyle(
                    //           color: AppColor.black,
                    //           fontSize: 13,
                    //           fontFamily: AppFont.poppinsLight),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Icon(
                    //           Icons.circle,
                    //           color: AppColor.purpleDark,
                    //           size: 20,
                    //         ),
                    //         Text(
                    //           "Completed",
                    //           style: TextStyle(
                    //               color: AppColor.purpleDark,
                    //               fontSize: 13,
                    //               fontFamily: AppFont.poppinsSemiBold),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Card(
            //   elevation: 1,
            //   shape: ContinuousRectangleBorder(
            //       borderRadius: BorderRadius.circular(15)),
            //   clipBehavior: Clip.hardEdge,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Account Details",
            //           style: TextStyle(
            //               color: AppColor.black,
            //               fontSize: 15,
            //               fontFamily: AppFont.poppinsBold),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text("Bank Name",
            //             style: TextStyle(
            //                 fontFamily: AppFont.poppinsRegular, fontSize: 13)),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text("Account Holder Name",
            //             style: TextStyle(
            //                 fontFamily: AppFont.poppinsRegular, fontSize: 13)),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text("Account Number",
            //             style: TextStyle(
            //                 fontFamily: AppFont.poppinsRegular, fontSize: 13)),
            //         SizedBox(
            //           height: 10,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Card(
            //   elevation: 1,
            //   shape: ContinuousRectangleBorder(
            //       borderRadius: BorderRadius.circular(15)),
            //   clipBehavior: Clip.hardEdge,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Payment Info",
            //           style: TextStyle(
            //               color: AppColor.black,
            //               fontSize: 15,
            //               fontFamily: AppFont.poppinsBold),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("Potential Earning",
            //                 style: TextStyle(
            //                     fontFamily: AppFont.poppinsRegular,
            //                     fontSize: 13)),
            //             Text("₦456.00",
            //                 style: TextStyle(
            //                     fontFamily: AppFont.poppinsSemiBold,
            //                     fontSize: 13)),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("Available for Withdrawal",
            //                 style: TextStyle(
            //                     fontFamily: AppFont.poppinsBold, fontSize: 14)),
            //             Text("₦456.0",
            //                 style: TextStyle(
            //                     fontFamily: AppFont.poppinsBold, fontSize: 14)),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Card(
              elevation: 1,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Info",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                          fontFamily: AppFont.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Request Amount",
                            style: TextStyle(
                                fontFamily: AppFont.poppinsRegular,
                                fontSize: 13)),
                        Text("₦${widget.data?.requestedAmount??''}",
                            style: TextStyle(
                                fontFamily: AppFont.poppinsSemiBold,
                                fontSize: 13)),
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
            widget.data?.status == 2?Card(
              elevation: 1,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rejection Reason:",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 15,
                          fontFamily: AppFont.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${widget.data?.rejectReason??'Technical Difficulties'}",
                        style: TextStyle(
                            fontFamily: AppFont.poppinsRegular, fontSize: 13)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ):
                const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
