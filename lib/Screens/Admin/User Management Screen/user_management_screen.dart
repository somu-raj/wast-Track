import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Enforcement%20Team/enforcement_team.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Nylon%20Production%20Company/nylon_production_company.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/State%20Management%20Agency/state_management_agency.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Sub%20Admin/sub_admin.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/vendor.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Waste%20Management%20Agency/waste_management_agency.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../App Routes/app_routes.dart';
import 'Ecoblue Sub Admin/ecoblue_sub_admin.dart';

class UserManagementScreen extends StatefulWidget {
   int? selectedIndex;
   bool? isTrue;
   UserManagementScreen({super.key,this.selectedIndex,this.isTrue});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Widget> containerWidgets = [
    EcoBlueSubAdmin(),
    SubAdmin(),
    //Vendor(),
    WasteManagementAgency(),
    NylonProductionCompany(),
    StateManagementAgency(),
    EnforcementTeam(),
  ];
  List<String> containerName = [
    'Ecoblue-Sub-Admin',
    'Sub-Admin',
    //'Vendor',
    'Waste Management Agency',
    'Nylon Production Company',
    'State Government Agency',
    'Enforcement Team',
  ];
  List<String> containerImage = [
    'assets/images/us_subAdmin.png',
    'assets/images/us_subAdmin.png',
   // 'assets/images/us_vendor.png',
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
      body: Column(
          children: [
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
                        if(widget.isTrue ==true){
                          widget.selectedIndex = index;
                        }else{
                          selectedWidgetIndex = index;
                        }

                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.isTrue == true ? (widget.selectedIndex == index ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1)) : (selectedWidgetIndex == index ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.4)),
                            ),
                            borderRadius: BorderRadius.circular(40),
                            color: widget.isTrue == true ? (widget.selectedIndex == index ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1)) : (selectedWidgetIndex == index ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1)),
                          ),
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Image.asset(
                              containerImage[index],
                              color: widget.isTrue == true ? (widget.selectedIndex == index ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.6)) : (selectedWidgetIndex == index ? AppColor.green : Colors.grey.withOpacity(0.6)),
                              height: 18,
                            ),
                          ),
                        ),

                        Text(
                          containerName[index],
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                            widget.isTrue == true ? (widget.selectedIndex == index ? AppColor.green : Colors.grey.withOpacity(0.1)) : (selectedWidgetIndex == index ? AppColor.green : Colors.grey.withOpacity(0.6)),
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
        Expanded(
          child: widget.isTrue == true
              ? (widget.selectedIndex! < containerWidgets.length
              ? containerWidgets[widget.selectedIndex ?? 0]
              : SizedBox())
              : (selectedWidgetIndex < containerWidgets.length
              ? containerWidgets[selectedWidgetIndex]
              : SizedBox()),
        ),

      ]),

    );
  }
}
