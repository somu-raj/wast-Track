import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Enforcement%20Team/sub_user_enforcement_team.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Nylon%20Production%20Company/sub_user_nylonPro_company.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20State%20Management%20Agency/sub_user_stateMa_agency.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/sub_user_vendor.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Waste%20Management%20Agency/sub_user_wasteMa_agency.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import 'Eco Blue Sub Admin User Enforcement Team/eco_blue_sub_admin_user_enforcement_team.dart';
import 'Eco Blue Sub Admin User Nylon Production Company/eco_blue_sub_admin_user_nylonPro_company.dart';
import 'Eco Blue Sub Admin User State Management Agency/eco_blue_sub_user_admin_stateMa_agency.dart';
import 'Eco Blue Sub Admin User Vendor/eco_blue_sub_admin_user_vendor.dart';
import 'Eco Blue Sub Admin User Waste Management Agency/eco_blue_sub_admin_user_wasteMa_agency.dart';

class EcoBlueSubAdminUserManagement extends StatefulWidget {
  const EcoBlueSubAdminUserManagement({super.key});

  @override
  State<EcoBlueSubAdminUserManagement> createState() => _EcoBlueSubAdminUserManagementState();
}

class _EcoBlueSubAdminUserManagementState extends State<EcoBlueSubAdminUserManagement> {
  List<Widget> containerWidgets = [
    EcoBlueSubUserVendor(),
    EcoBlueSubUserWasteMaAgency(),
    EcoBlueSubUserNylonProCompany(),
    EcoBlueSubUserStateMaAgency(),
    EcoBlueSubUserEnforcementTeam(),
  ];
  List<String> containerName = [
    'Vendor',
    'Waste Management Agency',
    'Nylon Production Company',
    'State Government Agency',
    'Enforcement Team',
  ];
  List<String> containerImage = [
    'assets/images/us_vendor.png',
    'assets/images/us_waste.png',
    'assets/images/us_nylon.png',
    'assets/images/us_state.png',
    'assets/images/us_enforcement.png',
  ];
  int selectedWidgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              itemCount: containerWidgets.length,
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
                          padding: EdgeInsets.all(15),
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
                              height: 18,
                            ),
                          ),
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
