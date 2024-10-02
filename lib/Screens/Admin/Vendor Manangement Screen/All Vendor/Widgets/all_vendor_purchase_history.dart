import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Conrollers/Area Alloted Controller/area_alloted_contoller.dart';
import 'all_vendor_viewDetails.dart';

class AllVendorPurchaseHistory extends StatefulWidget {
  final vendorId;
  const AllVendorPurchaseHistory({super.key,this.vendorId});

  @override
  State<AllVendorPurchaseHistory> createState() =>
      _AllVendorPurchaseHistoryState();
}

class _AllVendorPurchaseHistoryState extends State<AllVendorPurchaseHistory> {
  bool isButtonSelected = false;
  void initState() {
    // TODO: implement initState

    super.initState();
    callNylonListApi();

  }
  AreaAllotedController allotedController=AreaAllotedController();
  callNylonListApi()async{
    await allotedController.getOrderListApi(context, "", "", "",widget.vendorId);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: CustomSearchTextField(
                  onChanged: (v){
                    allotedController.getOrderListApi(context, "", "",v,widget.vendorId);
                  },
                  hintText: 'Search  here...',
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
             /* GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.union,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Filter By",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFont.poppinsSemiBold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Order Id'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomRadioButton(
                                            isSelected: isButtonSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isButtonSelected = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.59),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Order Date'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomRadioButton(
                                            isSelected: isButtonSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isButtonSelected = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.59),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Pickup Date'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomRadioButton(
                                            isSelected: isButtonSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isButtonSelected = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.59),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Quantity'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomRadioButton(
                                            isSelected: isButtonSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isButtonSelected = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ])
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColor.green),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: AppColor.green,
                  ),
                ),
              )*/
            ],
          ),
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child:allotedController.getOrderModel?.data == null ?myShimmer(): allotedController.getOrderModel?.data.length == 0 ?Text("No purchase history !!"): ListView.builder(
                itemCount:allotedController.getOrderModel?.data.length ,
                itemBuilder: (context, index) {
                  var orderList = allotedController.getOrderModel?.data[index];
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin: const EdgeInsets.only(bottom: 3),
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
                                        "Order ID",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "#${orderList?.orderId}",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
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
                                        "Amount Paid",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "₦${orderList?.total}",
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
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>AllVendorViewDetails(vendorId:orderList?.id,orderDate: orderList?.createdAt,orderId: orderList?.orderId,qty: orderList?.qty,totalAmount: orderList?.total,)));
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
                      SizedBox(
                        height: 7,
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
