import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/All%20Vendor%20Saff/all_vendor_staff.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/all_vendor_areas_alloted.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/all_vendor_purchase_history.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/all_vendor_sales_history.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Models/Vendor Management Model/Get Vendors Model/get_vendors_model.dart';

class AllVendorDetails extends StatefulWidget {
  final VendorsData? singleList;
  final bool? subAdmin;
  const AllVendorDetails({super.key,this.singleList,this.subAdmin});

  @override
  State<AllVendorDetails> createState() => _AllVendorDetailsState();
}

class _AllVendorDetailsState extends State<AllVendorDetails> {
  List<Widget> containerWidgets = [];
  List<String> containerName = [
    'Area Alloted',
    'Purchase History',
    // 'Sales History',
    'Vendor Staff List',
  ];
  int selectedWidgetIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerWidgets = [
      AllVendorAreasAlloted(vendorId:widget.singleList?.id,isBool: widget.subAdmin),
      AllVendorPurchaseHistory(vendorId:widget.singleList?.id),
      // AllVendorSalesHistory(),
      AllVendorStaff(),
    ];
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
        padding: EdgeInsets.all(10),
        child: Column(children: [
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
                    "${widget.singleList?.vendorCode}",
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 14,
                        fontFamily: AppFont.poppinsBold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.singleList?.companyName}",
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
                        "${widget.singleList?.firstName}",
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
                        "${widget.singleList?.email}",
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
                        "+234 ${widget.singleList?.phoneNumber}",
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
                      Icon(Icons.location_on_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                       Text(
                        "${widget.singleList?.companyAddress}",
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
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(AppImages.browser),
                      const SizedBox(
                        width: 10,
                      ),
                       Text(
                        "${widget.singleList?.website}",
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
            height: 5,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: containerWidgets.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            top: 7, left: 10, right: 10, bottom: 2),
                        decoration: selectedWidgetIndex == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColor.grey)
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.transparent),
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWidgetIndex = index;
                            });
                          },
                          child: Text(
                            containerName[index],
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.poppinsLight,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  color: AppColor.green,
                ),
                SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: selectedWidgetIndex < containerWidgets.length
                      ? containerWidgets[selectedWidgetIndex]
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
