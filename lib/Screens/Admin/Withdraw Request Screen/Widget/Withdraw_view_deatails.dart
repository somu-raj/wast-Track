

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_track/Conrollers/Admin/Admin%20Withdraw%20Request%20Controller/admin_withdraw_request_controller.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Models/Admin Withdraw Request Model/single _withdraw_request_details_model.dart';

class WithdrawViewDetails extends StatefulWidget {
  const WithdrawViewDetails({super.key, this.id});
  final String? id;
  @override
  State<WithdrawViewDetails> createState() => _WithdrawViewDetailsState();
}

class _WithdrawViewDetailsState extends State<WithdrawViewDetails> {
  final AdminWithdrawRequestController adminWithdrawRequestController = AdminWithdrawRequestController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callSingleWithdrawRequestApi();
  }

  callSingleWithdrawRequestApi()async{
    debugPrint("request id ==>${widget.id}");
  await adminWithdrawRequestController.getSingleWithdrawRequestApi(context, widget.id??"");
   setState(() {});
  }
  showConfirmRejectDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: [
              Text(
                "Do you want to Reject this Request?",
                style: TextStyle(
                    fontSize: 15, color: AppColor.black),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColor.green,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontFamily: AppFont.poppinsLight,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? reason = await showTextFormField();
                      if(reason == null || reason.isEmpty){
                        Navigator.pop(context);
                        CustomSnackBar.mySnackBar(context, "Please specify reason for rejection");
                        return;
                      }
                      await adminWithdrawRequestController.updateWithdrawRequestStatusApi(context,id: widget.id??'',reason: reason,status: 2).then((value)async{
                        adminWithdrawRequestController.getAdminSingleWithdrawRequestModel = null;
                        setState(() {});
                        await adminWithdrawRequestController.getSingleWithdrawRequestApi(context, widget.id);
                        setState(() {});
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                          top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColor.green,
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              fontFamily: AppFont.poppinsLight,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ), // show pop-up
        );
      },
    );
  }
  showConfirmApproveDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: [
              Text(
                "Do you want to Approve this Request?",
                style: TextStyle(
                    fontSize: 15, color: AppColor.black),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColor.green,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontFamily: AppFont.poppinsLight,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     adminWithdrawRequestController.updateWithdrawRequestStatusApi(context,id: widget.id??'',reason: '',status: 1).then((value)async{
                       adminWithdrawRequestController.getAdminSingleWithdrawRequestModel = null;
                       setState(() {});
                       await adminWithdrawRequestController.getSingleWithdrawRequestApi(context, widget.id);
                       setState(() {});
                     });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                          top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColor.green,
                      ),
                      child: Center(
                        child: Text(
                          'Approve',
                          style: TextStyle(
                              fontFamily: AppFont.poppinsLight,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ), // show pop-up
        );
      },
    );
  }
  ///show TextFormField for enter rejection reason
  Future<String?> showTextFormField() async {
    String? result = await showDialog
      (context: context,
        builder: (_){
          final TextEditingController rejectReasonTextFormFieldController =
          TextEditingController();
          return AlertDialog(
            content: Column(
              mainAxisSize:  MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please specify a reason for rejection",style: TextStyle(fontSize: 16),),
                const SizedBox(height: 8,),
                CustomTextField(
                  controller: rejectReasonTextFormFieldController,
                  hintText: "Type here...",
                  maxLines: 3,

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
                    Navigator.pop(context,rejectReasonTextFormFieldController.text);
                  },
                  // style: TextButton.styleFrom(
                  //   foregroundColor: AppColor.green
                  // ),
                  child: Text("Ok",
                    style: TextStyle(fontSize: 18),
                  )),
              SizedBox(width: 10,height: 40,)
            ],
          );
        });
    return result;
  }
  @override
  Widget build(BuildContext context) {
    Data? data = adminWithdrawRequestController.getAdminSingleWithdrawRequestModel?.data;
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

      adminWithdrawRequestController.getAdminSingleWithdrawRequestModel ==null?
          myShimmer():
          data == null?
              Center(
                child: Text("Something Went Wrong!!"),
              ):
      Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
           data.status == 0?
           Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showConfirmRejectDialog();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 7, right: 15, left: 15, bottom: 7),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.redLight.withOpacity(0.3)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.cancel,
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Reject',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: AppFont.poppinsSemiBold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                   showConfirmApproveDialog();
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.greenMedium1.withOpacity(0.5)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.check_circle,
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Approve',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: AppFont.poppinsSemiBold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ):
           Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   data.status == 1?
                   Container(
                     padding: EdgeInsets.all(7),
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.green),
                         borderRadius: BorderRadius.circular(10),
                         color: AppColor.greenMedium1.withOpacity(0.5)),
                     child: Row(
                       children: [
                         SvgPicture.asset(
                           AppImages.check_circle,
                           height: 25,
                         ),
                         SizedBox(
                           width: 10,
                         ),
                         Text(
                           'Approved',
                           style: TextStyle(
                               color: Colors.green,
                               fontFamily: AppFont.poppinsSemiBold),
                         )
                       ],
                     ),
                   ):
                   data.status == 2?
                   Container(
                     padding:
                     EdgeInsets.only(top: 7, right: 15, left: 15, bottom: 7),
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.red),
                         borderRadius: BorderRadius.circular(10),
                         color: AppColor.redLight.withOpacity(0.3)),
                     child: Row(
                       children: [
                         SvgPicture.asset(
                           AppImages.cancel,
                           height: 25,
                         ),
                         SizedBox(
                           width: 10,
                         ),
                         Text(
                           'Rejected',
                           style: TextStyle(
                               color: Colors.red,
                               fontFamily: AppFont.poppinsSemiBold),
                         )
                       ],
                     ),
                   ):
                   data.status == 3?
                   Container(
                     padding: EdgeInsets.all(7),
                     decoration: BoxDecoration(
                         border: Border.all(color: AppColor.purpleDark),
                         borderRadius: BorderRadius.circular(10),
                         color: AppColor.purpleLight.withOpacity(0.2)),
                     child: Row(
                       children: [
                         SvgPicture.asset(
                           AppImages.request_com,
                           height: 25,
                         ),
                         SizedBox(
                           width: 10,
                         ),
                         Text(
                           'Completed',
                           style: TextStyle(
                               color: AppColor.purpleDark,
                               fontFamily: AppFont.poppinsSemiBold),
                         )
                       ],
                     ),
                   ):
                       SizedBox()
                 ],
               ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
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
                                  "#${data.requestId??"--"}",
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
                                  "${data.requestedDate??"--"}",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsLight),
                                ),
                              ],
                            ),
                            data.status == 1?Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Approval Date:",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                    Text(
                                      "${data.approvalDate??""}",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                            data.status == 2?Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rejection Date:",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                    Text(
                                      "2 Sept 2023, 11:45AM",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                            SizedBox(
                              height: 10,
                            ),
                            const SizedBox.shrink(),
                            data.status ==0?Row(
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
                                      color: AppColor.orange,
                                      size: 20,
                                    ),
                                    Text(
                                      "Pending",
                                      style: TextStyle(
                                          color: AppColor.orange,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                            data.status ==1?Row(
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
                                      color: AppColor.green,
                                      size: 20,
                                    ),
                                    Text(
                                      "Approve",
                                      style: TextStyle(
                                          color: AppColor.green,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                            data.status ==2?Row(
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
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Text(
                                      "Rejected",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                            data.status ==3?Row(
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
                                      color: AppColor.purpleDark,
                                      size: 20,
                                    ),
                                    Text(
                                      "Completed",
                                      style: TextStyle(
                                          color: AppColor.purpleDark,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                              ],
                            ):const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Vendor Details",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsSemiBold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      " Vendor Code :",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                    Text(
                                      " ${data.vendorCode??""}",
                                      style: TextStyle(
                                          color: AppColor.green,
                                          fontSize: 14,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " ${data.vendorCompanyName??""}",
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
                                  " ${data.vendorFirstName??""} ${data.vendorLastName??""}",
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
                                Icon(Icons.email_outlined,
                                    color: AppColor.green),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Text(
                                  " ${data.vendorEmail??""}",
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
                                Icon(Icons.call_end_outlined,
                                    color: AppColor.green),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Text(
                                  "+234 ${data.vendorPhoneNumber??""}",
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
                                  " ${data.vendorCompanyAddress??""}",
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
                            Text("Serial Details",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsSemiBold,
                                    fontSize: 14)),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView(
                                children:
                                List<Widget>.generate(data.serialNumbers.length,
                                        (index){
                                  if(data.serialNumbers.isEmpty){
                                    return Center(
                                      child: Text("No Serial Number Found!!"),
                                    );
                                  }
                                  SerialNumber? serialNumberData = data.serialNumbers[index];
                                  debugPrint("price per bag ==> ${serialNumberData.pricePerBag}");
                                  return Column(
                                           children: [
                                             // Row(
                                             //   mainAxisAlignment:
                                             //   MainAxisAlignment.spaceBetween,
                                             //   children: [
                                             //     Text(serialNumberData?.serialNumber??'',
                                             //         style: TextStyle(
                                             //             fontFamily:
                                             //             'AppFont.poppinsRegular',
                                             //             fontSize: 13)),
                                             //     Text(serialNumberData?.collectedDate??'',
                                             //         style: TextStyle(
                                             //             fontFamily:
                                             //             'AppFont.poppinsRegular',
                                             //             fontSize: 13)),
                                             //   ],
                                             // ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Serial Number",
                                                     style: TextStyle(
                                                         color: AppColor.black, fontSize: 13)),
                                                 Text("${serialNumberData.serialNumber??''}",
                                                     style: TextStyle(
                                                         fontFamily: AppFont.poppinsRegular,
                                                         fontSize: 13)),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Collected On",
                                                     style: TextStyle(
                                                         color: AppColor.black, fontSize: 13)),
                                                 Text("${serialNumberData.collectedDate??''}",
                                                     style: TextStyle(
                                                         fontFamily: AppFont.poppinsRegular,
                                                         fontSize: 13)),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Price/ Bag",
                                                     style: TextStyle(
                                                         color: AppColor.black, fontSize: 13)),
                                                 Text("₦${serialNumberData.pricePerBag??''}",
                                                     style: TextStyle(
                                                         fontFamily: AppFont.poppinsSemiBold,
                                                         fontSize: 13)),
                                               ],
                                             ),
                                             // SizedBox(
                                             //   height: 5,
                                             // ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text("Revenue Share",
                                                     style: TextStyle(
                                                         fontFamily: AppFont.poppinsRegular,
                                                         fontSize: 13)),
                                                 Text("₦${serialNumberData.revenuePrice??''}",
                                                     style: TextStyle(
                                                         fontFamily: AppFont.poppinsSemiBold,
                                                         fontSize: 13)),
                                               ],
                                             ),
                                             Divider(
                                               color: AppColor.grey,
                                               thickness: 1,
                                             ),
                                           ],
                                         );
                                        })
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 15)),
                                Text("₦${data.requestedAmount}",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 15)),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
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
                                Text("Potential Earning",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsRegular,
                                        fontSize: 13)),
                                Text("₦${data.requestedAmount}",
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
                                Text("Available for Withdrawal",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 14)),
                                Text("₦${data.requestedAmount}",
                                    style: TextStyle(
                                        fontFamily: AppFont.poppinsBold,
                                        fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
