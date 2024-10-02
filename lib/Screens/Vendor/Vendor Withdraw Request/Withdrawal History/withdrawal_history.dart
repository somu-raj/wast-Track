import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Vendor/Withdraw%20Request%20Controller/vendor_withdraw_request_history_controller.dart';
import 'package:waste_track/Models/Vendor/Vendor%20Withdraw%20Request%20Model/vendor_withdraw_request_history_list_model.dart';
import 'package:waste_track/Models/Withdraw%20Container%20Model/withdraw_container_model.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Withdraw%20Request/Withdrawal%20History/Widget/withdrawal_history_details.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class WithdrawalHistory extends StatefulWidget {
  const WithdrawalHistory({super.key});

  @override
  State<WithdrawalHistory> createState() => _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends State<WithdrawalHistory> {
  final VendorWithdrawRequestHistoryController vendorWithdrawRequestHistoryController = VendorWithdrawRequestHistoryController();
  bool isButtonSelected = false;
  List<WithdrawItemModel> containerItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callWithdrawHistoryApis();
  }
  callWithdrawHistoryApis() async {
    await vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountApi(context);
    await vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListApi(context,"1","","");
    containerItems = [
      WithdrawItemModel(
          name: 'Withdrawals Pending  ',
          imageUrl: AppImages.with_pending,
          number: "${vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountModel?.data?.pendingReqCount??'0'}"),
      WithdrawItemModel(
          name: 'Withdrawals Confirmed',
          imageUrl: AppImages.request_can,
          number: "${vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountModel?.data?.approveReqCount??'0'}"),
      WithdrawItemModel(
          name: 'Total Requests',
          imageUrl: AppImages.request_com,
          number: "${vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountModel?.data?.totalReqCount??'0'}"),
      WithdrawItemModel(
          name: 'Withdrawals Cancelled',
          imageUrl: AppImages.request_app,
          number: "${vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountModel?.data?.rejectReqCount??'0'}"),

      // Add more items with colors as needed
    ];
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return
      vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryCountModel == null
          && vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListModel== null?
      myShimmer():
      Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    onChanged: (val){
                      vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListApi(context, "1", "", val).then((value){
                        setState(() {

                        });
                      });
                    },
                    hintText: 'Search here...',
                    hintStyle: TextStyle(
                        fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColor.green,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     showModalBottomSheet(
                //       context: context,
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(25.0),
                //         ),
                //       ),
                //       backgroundColor: Colors.white,
                //       builder: (BuildContext context) {
                //         return Wrap(
                //           children: [
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: const EdgeInsets.all(20.0),
                //                         child: Row(
                //                           children: [
                //                             SvgPicture.asset(
                //                               AppImages.union,
                //                               height: 15,
                //                             ),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             const Text(
                //                               "Filter By",
                //                               style: TextStyle(
                //                                   fontFamily:
                //                                       AppFont.poppinsSemiBold),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                             left: 20,
                //                             right: 20,
                //                             top: 10,
                //                             bottom: 10),
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text('Request ID'),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             CustomRadioButton(
                //                               isSelected: isButtonSelected,
                //                               onChanged: (value) {
                //                                 setState(() {
                //                                   isButtonSelected = value;
                //                                 });
                //                               },
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       Divider(
                //                         color: Colors.black.withOpacity(0.59),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                             left: 20,
                //                             right: 20,
                //                             top: 10,
                //                             bottom: 10),
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text('Amount'),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             CustomRadioButton(
                //                               isSelected: isButtonSelected,
                //                               onChanged: (value) {
                //                                 setState(() {
                //                                   isButtonSelected = value;
                //                                 });
                //                               },
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       Divider(
                //                         color: Colors.black.withOpacity(0.59),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.only(
                //                             left: 20,
                //                             right: 20,
                //                             top: 10,
                //                             bottom: 10),
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text('Request Date'),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             CustomRadioButton(
                //                               isSelected: isButtonSelected,
                //                               onChanged: (value) {
                //                                 setState(() {
                //                                   isButtonSelected = value;
                //                                 });
                //                               },
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                     ])
                //               ],
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   child: Container(
                //       padding: EdgeInsets.all(6),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         border:
                //             Border.all(color: AppColor.green.withOpacity(0.6)),
                //         borderRadius: BorderRadius.circular(7),
                //       ),
                //       child: Icon(
                //         Icons.filter_alt_outlined,
                //         color: AppColor.green,
                //       )),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: containerItems.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Card(
                    elevation: 1,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  containerItems[index].number,
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsBold,
                                      fontSize: 25,
                                      color: AppColor.black),
                                ),
                              ),
                              Center(
                                  child: SvgPicture.asset(
                                containerItems[index].imageUrl,
                                height: 45,
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            containerItems[index].name,
                            style: TextStyle(
                                fontFamily: AppFont.poppinsMedium,
                                fontSize: 11,
                                color: AppColor.grey1),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListModel == null ||
          vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListModel!.data.isEmpty?
              Center(
                child: Text("No Withdraw History Found!!"),
              ):
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                itemCount: vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListModel?.data.length??0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  GetVendorWithdrawRequestHistoryListData? data = vendorWithdrawRequestHistoryController.getVendorWithdrawRequestHistoryListModel!.data[index];
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 15, right: 10, left: 10),
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Request ID",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "#${data.requestId??"12345"}",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: AppColor.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Amount",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "₦${data.requestedAmount??""}",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Divider(
                                      color: AppColor.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Request Date",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            data.requestedDate??"",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Divider(
                                      color: AppColor.black,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child:  Text(
                                            "${data.status == 1 ?'Approve': data.status ==2?"Reject":'Approve/Reject'} Date",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            data.approvalDate??"--",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppFont.poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Divider(
                                      color: AppColor.black,
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     Expanded(
                                    //       child: const Text(
                                    //         "Total Amount",
                                    //         style: TextStyle(
                                    //             color: AppColor.black,
                                    //             fontSize: 13,
                                    //             fontFamily:
                                    //                 AppFont.poppinsLight),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: const Text(
                                    //         "₦15,000.00",
                                    //         style: TextStyle(
                                    //             color: AppColor.black,
                                    //             fontSize: 12,
                                    //             fontFamily:
                                    //                 AppFont.poppinsLight),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>WithdrawalHistoryDetails(data: data,)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColor.green,
                                    fontSize: 11,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: AppColor.green,
                                  size: 11,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 30,
                        top: 7,
                        child: Container(
                          //status  0 = pending, 1=approved, 2=rejected, 3=completed
                          padding: EdgeInsets.only(
                              top: 4, left: 11, right: 11, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: data.status==0?
                              AppColor.orange.withOpacity(0.3)
                                  :data.status==1?
                              AppColor.green.withOpacity(0.3)
                                  :data.status==2?
                              AppColor.redLight.withOpacity(0.3)
                                  :
                              AppColor.purpleLight.withOpacity(0.3)
                          ),
                          child: Text(

                            '${data.statusText??''}',
                            style:
                                TextStyle(
                                    fontSize: 11,
                                    color: data.status==0?
                                    AppColor.orange
                                        :data.status==1?
                                    AppColor.green
                                        :data.status==2?
                                    Colors.red
                                        :
                                    AppColor.purpleDark
                                ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
