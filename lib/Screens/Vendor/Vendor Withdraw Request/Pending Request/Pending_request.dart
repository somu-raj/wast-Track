import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Vendor/Withdraw%20Request%20Controller/vendor_withdraw_request_controller.dart';
import 'package:waste_track/Models/Withdraw%20Container%20Model/withdraw_container_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class WithdrawPendingRequest extends StatefulWidget {
  const WithdrawPendingRequest({super.key});

  @override
  State<WithdrawPendingRequest> createState() => _WithdrawPendingRequestState();
}

class _WithdrawPendingRequestState extends State<WithdrawPendingRequest> {
  final VendorWithdrawRequestController vendorWithdrawRequestController = VendorWithdrawRequestController();
  final TextEditingController withdrawAmountController= TextEditingController();

   List<WithdrawItemModel> containerItems = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callWithdrawApis();
  }
  callWithdrawApis()async{
    await vendorWithdrawRequestController.getVendorWithdrawPendingRequestApi(context);
    await vendorWithdrawRequestController.getVendorCollectionListApi(context);
    containerItems = [
      WithdrawItemModel(
          name: 'Total Amount', imageUrl: AppImages.amount_to, number: "₦${vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel?.data?.totalAmount??"0"}"),
      WithdrawItemModel(
          name: 'Amount Withdrawn',
          imageUrl: AppImages.amount_with,
          number: "₦${vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel?.data?.withdrawnAmount??"0"}"),
      WithdrawItemModel(
          name: 'Amount Pending', imageUrl: AppImages.amount_pen, number: "₦${vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel?.data?.pendingAmount??"0"}"),
      WithdrawItemModel(
          name: 'Amount Available',
          imageUrl: AppImages.availble_amo,
          number: "₦${vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel?.data?.availableAmount??"0"}"),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    withdrawAmountController.dispose();
  }
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return
      vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel == null
      && vendorWithdrawRequestController.getVendorCollectionListModel == null?
      myShimmer():
      Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: [
            Container(
              height: 150,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child:
                vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel == null?
                Center(child: CupertinoActivityIndicator(),):
                ListView.builder(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      containerItems[index].number,
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 17,
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
                                height: 12,
                              ),
                              Text(
                                containerItems[index].name,
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
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
            ),
            SizedBox(
              height: 12,
            ),
            vendorWithdrawRequestController.getVendorCollectionListModel!.data.isEmpty ?
            Center(child: Text("No Collected Nylon Found!!"),):
           ListView(children:[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Card(
                 elevation: 1,
                 margin: EdgeInsets.zero,
                 shape: ContinuousRectangleBorder(
                     borderRadius: BorderRadius.circular(20)),
                 clipBehavior: Clip.hardEdge,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(
                         height: 10,
                       ),
                       const Text(
                         "Enter Withdrawal Amount",
                         style: TextStyle(
                             color: AppColor.black,
                             fontSize: 13,
                             fontFamily: AppFont.poppinsSemiBold),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Expanded(
                               flex: 2,
                               child: Obx((){
                                 withdrawAmountController.text = vendorWithdrawRequestController.withdrawnAmount.toString();
                                 return
                                   CustomSearchTextField(
                                     controller: withdrawAmountController,
                                     readOnly: true,
                                     hintStyle: TextStyle(
                                       fontSize: 15,
                                       fontFamily: AppFont.poppinsBold,
                                     ),
                                     prefixIcon: Padding(
                                       padding:
                                       const EdgeInsets.only(top: 6, left: 10),
                                       child: Text(
                                         '₦',
                                         style: TextStyle(fontSize: 20),
                                       ),
                                     ),
                                   );
                               })),
                           SizedBox(
                             width: 5,
                           ),
                           Expanded(
                             child: GestureDetector(
                               onTap: (){
                                 if(withdrawAmountController.text != '0'){
                                   setState(() {
                                     isLoading = true;
                                   });
                                   vendorWithdrawRequestController.vendorWithdrawRequestApi(context).then((value){
                                     vendorWithdrawRequestController.getVendorWithdrawPendingRequestModel = null;
                                     vendorWithdrawRequestController.getVendorCollectionListModel= null;
                                     isLoading = false;
                                     callWithdrawApis();
                                   },
                                       onError: (error){
                                         debugPrint(error.toString());
                                         CustomSnackBar.mySnackBar(context, "Something went wrong please try again !!");
                                         setState(() {
                                           isLoading = false;
                                         });
                                       });
                                 }else{
                                   CustomSnackBar.mySnackBar(context, "Please Select nylon for withdraw");
                                 }
                               },
                               child: Container(
                                 padding: EdgeInsets.all(12),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: AppColor.green),
                                 child: Center(
                                   child:isLoading?
                                   CupertinoActivityIndicator():
                                   const Text(
                                     "Send Request",
                                     style: TextStyle(
                                         color: AppColor.white,
                                         fontSize: 11,
                                         fontFamily: AppFont.poppinsLight),
                                   ),
                                 ),
                               ),
                             ),
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
             ),
             Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Select the serials for which you want to receive a withdrawal.",
                style: TextStyle(
                    color: AppColor.green.withOpacity(0.8),
                    fontSize: 13,
                    fontFamily: AppFont.poppinsLight),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    vendorWithdrawRequestController.toggleSelectAll();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done_all,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Select All",
                          style: TextStyle(
                              color: AppColor.white,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsLight),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child:
              ListView.builder(
                itemCount: vendorWithdrawRequestController.getVendorCollectionListModel?.data.length??0 ,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print('index=>${index}');
                  var data = vendorWithdrawRequestController.getVendorCollectionListModel?.data[index];

                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Checkbox(
                            value: vendorWithdrawRequestController
                                .areOptionCheckedList[index],
                            onChanged: (value) {
                              vendorWithdrawRequestController.toggleCheckBox(
                                  index);
                            },
                          );

                        }),
                        Flexible(
                          child: Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                                          "Serial Number",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          data?.serialNumber??"",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
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
                                          "Collected on",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          data?.collectedDate??"",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
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
                                          "Price/Bag",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          "₦${data?.pricePerBag??"0"}",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
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
                                          "Revenue Share",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          "₦${data?.revenuePrice??"0"}",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),])
          ],
        ),
      ),
    );
  }
}
