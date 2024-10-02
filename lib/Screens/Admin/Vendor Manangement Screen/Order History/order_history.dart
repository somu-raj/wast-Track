import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Vendor%20Order%20History%20Model/vendor_order_history_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Vendor/Order Management Controller/order_management_controller.dart';
import 'Widget/order_history_details.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool isButtonSelected = false;
  final List<OrderHistoryItemModel> containerItems = [
    OrderHistoryItemModel(
        name: 'Order Pending', imageUrl: AppImages.order_pen, number: "50"),
    OrderHistoryItemModel(
        name: 'Order Completed', imageUrl: AppImages.request_com, number: "10"),
    OrderHistoryItemModel(
        name: 'Order Confirmed', imageUrl: AppImages.order_com, number: "35"),
    OrderHistoryItemModel(
        name: 'Order Cancelled', imageUrl: AppImages.request_app, number: "5"),
    OrderHistoryItemModel(
        name: 'Order Refunded', imageUrl: AppImages.order_ref, number: "5"),

    // Add more items with colors as needed
  ];

    final controller1 = Get.put(OrderHistoryVisibilityController());

  final controller = Get.put(OrderManagementController());
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMoreData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetVendorCountApi();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }

  callGetVendorCountApi()async{
    await controller.getVendorOrderCountsApi(context);
    await controller.getVendorOrdersApi(context,"1","10","");
    setState(() {});
  }

  Future<void> _fetchData() async {
    int currentDataLength = controller.getVendorOrdersModel?.data.length??0;

    if (!isLoadingMoreData && controller.getVendorOrdersModel?.data.length != controller.getVendorOrdersModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
      controller.getVendorOrdersApi(context, "1", '$limit','',).then(
              (value){
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      debugPrint("maxScrollExtent called!!");
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          Container(
            height: 120,
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.getVendorOrderCountModel?.data?.pendingOrderCount == null ? Text("0") : Flexible(
                                    child: Text(
                                      "${controller.getVendorOrderCountModel?.data?.pendingOrderCount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 20,
                                          color: AppColor.black),
                                    ),
                                  ),
                                  Center(
                                      child: SvgPicture.asset(
                                        AppImages.order_pen,
                                        height: 50,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Order Pending",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
                                    color: AppColor.grey1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.getVendorOrderCountModel?.data?.completedOrderCount == null ? Text("0") :  Flexible(
                                    child: Text(
                                      "${controller.getVendorOrderCountModel?.data?.completedOrderCount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 20,
                                          color: AppColor.black),
                                    ),
                                  ),
                                  Center(
                                      child: SvgPicture.asset(
                                        AppImages.request_com,
                                        height: 50,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Order Completed",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
                                    color: AppColor.grey1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.getVendorOrderCountModel?.data?.confirmedOrderCount == null ? Text("0") :   Flexible(
                                    child: Text(
                                      "${controller.getVendorOrderCountModel?.data?.confirmedOrderCount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 20,
                                          color: AppColor.black),
                                    ),
                                  ),
                                  Center(
                                      child: SvgPicture.asset(
                                        AppImages.order_com,
                                        height: 50,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Order Confirmed",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
                                    color: AppColor.grey1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.getVendorOrderCountModel?.data?.cancelledOrderCount == null ? Text("0") :   Flexible(
                                    child: Text(
                                      "${controller.getVendorOrderCountModel?.data?.cancelledOrderCount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 20,
                                          color: AppColor.black),
                                    ),
                                  ),
                                  Center(
                                      child: SvgPicture.asset(
                                        AppImages.request_can,
                                        height: 50,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Order Cancelled",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
                                    color: AppColor.grey1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.getVendorOrderCountModel?.data?.refundedOrderCount == null ? Text("0") :  Flexible(
                                    child: Text(
                                      "${controller.getVendorOrderCountModel?.data?.refundedOrderCount}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 20,
                                          color: AppColor.black),
                                    ),
                                  ),
                                  Center(
                                      child: SvgPicture.asset(
                                        AppImages.order_ref,
                                        height: 50,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Order Refunded",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 13,
                                    color: AppColor.grey1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                )
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2, left: 2),
            child: Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    hintText: 'Search here...',
                    onChanged: (v){
                      controller.getVendorOrdersApi(context, "1", "10",v);
                    },
                    hintStyle: TextStyle(
                        fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColor.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
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
                //                     crossAxisAlignment: CrossAxisAlignment.start,
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
                //                             Text('Order ID'),
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
                //                             Text('Order Date'),
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
                //                             Text('Vendor Code'),
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
                //                       const SizedBox(
                //                         height: 10,
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
                //                             Text('Payment Status'),
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
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child:controller.getVendorOrdersModel?.data == null ? myShimmer(): controller.getVendorOrdersModel?.data.length == 0 ?Text("No Order History Found!!") :ListView.builder(
                itemCount: controller.getVendorOrdersModel?.data.length,
                itemBuilder: (context, index) {
                  var orderHistory = controller.getVendorOrdersModel?.data[index];
                  return Column(
                    children: [
                         Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15),
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
                                            "Invoice ID",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "#${orderHistory?.orderId}",
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
                                            "Vendor Code",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${orderHistory?.vendorCode}",
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
                                            "Company Name",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${orderHistory?.companyName}",
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
                                            "Date & Time",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${orderHistory?.createdAt}",
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
                                            "Total Amount",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "₦${orderHistory?.total}",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 285,
                            top: -8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller1.toggleVisibility(index);
                                });
                              },
                              child: Container(
                                child: Image.asset(
                                  AppImages.opestion,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 219,
                            top: -8,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, AppScreen.orderHistoryDetailsScreen,arguments: orderHistory?.id);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryDetails(orderId: orderHistory?.id)));
                              },
                              child: Visibility(
                                visible: controller1.areOptionVisibleList[index],
                                child: Image.asset(
                                  AppImages.eye,
                                  height: 52,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 253,
                            top: -8,
                            child: GestureDetector(
                              onTap: () {
                                controller.generateInvoiceApi(context,orderHistory?.id ?? "");
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
                                //               borderRadius:
                                //                   BorderRadius.circular(30),
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
                                //               "Invoice Downloaded Successfully.",
                                //               style: TextStyle(
                                //                   fontSize: 13,
                                //                   color: AppColor.green),
                                //             ),
                                //           ),
                                //         ],
                                //       ), // show pop-up
                                //     );
                                //   },
                                // );
                              },
                              child: Visibility(
                                  visible: controller1.areOptionVisibleList[index],
                                  child: SvgPicture.asset(
                                    AppImages.downloaded,
                                    height: 50,
                                  )),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 4,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 4, left: 11, right: 11, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: orderHistory?.orderStatusText == "Pending" ? AppColor.orange.withOpacity(0.3) : orderHistory?.orderStatusText == "Cancelled" ?AppColor.redLight.withOpacity(0.3) :orderHistory?.orderStatusText == "Confirmed" ?AppColor.green.withOpacity(0.3) : AppColor.green.withOpacity(0.3)
                                  //AppColor.orange.withOpacity(0.3)
                              ),
                              child: Text(
                                '${orderHistory?.orderStatusText}',
                                style:
                                    TextStyle(fontSize: 11, color:orderHistory?.orderStatusText == "Pending" ? AppColor.orange : orderHistory?.orderStatusText == "Cancelled" ?AppColor.redLight :orderHistory?.orderStatusText == "Confirmed" ?AppColor.green : AppColor.green ) ,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13,),
                      if(index == (controller.getVendorOrdersModel?.data.length??0)-1  && isLoadingMoreData && (controller.getVendorOrdersModel?.data.length != controller.getVendorOrdersModel?.pagination?.totalItems))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color:AppColor.green),
                        )

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
