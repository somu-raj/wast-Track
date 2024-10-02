import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Withdraw%20Request/Pending%20Request/Pending_request.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Withdraw%20Request/Withdrawal%20History/withdrawal_history.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class VendorWithdrawRequest extends StatefulWidget {
  const VendorWithdrawRequest({super.key});

  @override
  State<VendorWithdrawRequest> createState() => _VendorWithdrawRequestState();
}

class _VendorWithdrawRequestState extends State<VendorWithdrawRequest> {
  List<Widget> containerWidgets = [
    WithdrawPendingRequest(),
    WithdrawalHistory(),
  ];
  List<String> containerName = [
    'Pending Request',
    'Withdrawal History',
  ];
  List<String> containerImage = [
    'assets/images/data_table.png',
    'assets/images/update.png',
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
          height: 100,
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
                          padding: EdgeInsets.all(13),
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
                            height: 20,
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
        Expanded(
            child: selectedWidgetIndex < containerWidgets.length
                ? containerWidgets[selectedWidgetIndex]
                : SizedBox())
      ]),
    );
  }
}
