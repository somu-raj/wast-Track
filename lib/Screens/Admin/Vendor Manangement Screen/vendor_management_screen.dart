import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Add%20Vendor/add_vendor.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/all_vendor.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Areas/areas.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Order%20History/order_history.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Vendor%20Request/vendor_request.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class VendorManagementScreen extends StatefulWidget {
  const VendorManagementScreen({super.key});

  @override
  State<VendorManagementScreen> createState() => _VendorManagementScreenState();
}

class _VendorManagementScreenState extends State<VendorManagementScreen> {
  List<Widget> containerWidgets = [
    AddVendor(),
    Areas(),
    AllVendor(),
    VendorRequest(),
    OrderHistory(),
  ];
  List<String> containerName = [
    'Add Vendor',
    'Areas',
    'All Vendors',
    'Vendor Request',
    'Order History',
  ];
  List<String> containerImage = [
    'assets/images/vendor_person.png',
    'assets/images/vendor_map.png',
    'assets/images/vendor_groups.png',
    'assets/images/vendor_chat_bubble.png',
    'assets/images/vendor_deployed_code_history.png',
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
      body: Column(children: [
        Container(
          height: 120,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWidgetIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedWidgetIndex == index
                                  ? AppColor.green
                                  : Colors.green.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(40),
                            color: selectedWidgetIndex == index
                                ? AppColor.green.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                          ),
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                              child: Image.asset(
                            containerImage[index],
                            color: selectedWidgetIndex == index
                                ? Colors.green
                                : Colors.grey,
                            height: 19,
                          )),
                        ),
                        Text(
                          containerName[index],
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedWidgetIndex == index
                                ? Colors.green
                                : Colors.grey,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
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
        Flexible(
            child: selectedWidgetIndex < containerWidgets.length
                ? containerWidgets[selectedWidgetIndex]
                : SizedBox())
      ]),
    );
  }
}
