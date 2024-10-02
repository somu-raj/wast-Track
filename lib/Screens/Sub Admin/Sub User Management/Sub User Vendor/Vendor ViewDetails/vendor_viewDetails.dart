import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/V%20Venor%20Staff%20List/v_vendor_staff_list.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/Vendor_sales_history.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/vendor_area_alloted.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/vendor_purchase_history.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class VendorViewDetails extends StatefulWidget {
  const VendorViewDetails({super.key});

  @override
  State<VendorViewDetails> createState() => _VendorViewDetailsState();
}

class _VendorViewDetailsState extends State<VendorViewDetails> {
  List<Widget> containerWidgets = [
    VendorAreaAlloted(),
    VendorPurchaseHistory(),
    VendorSalesHistory(),
    VVendorStaffList(),
  ];
  List<String> containerName = [
    'Area Alloted',
    'Purchase History',
    'Sales History',
    'Vendor Staff List',
  ];
  int selectedWidgetIndex = 0;
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
                    " 12345",
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 14,
                        fontFamily: AppFont.poppinsBold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    " Enumeral Waste Solutions Limited",
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
                      const Text(
                        " Lorem Ipsum",
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
                      const Text(
                        " vendor@gmail.com",
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
                      const Text(
                        "+234 90-461-4000",
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
                      const Text(
                        "abc colony, xyz area, pqr city",
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
                      const Text(
                        "website.com",
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
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
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
