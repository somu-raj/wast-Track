import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/Conrollers/home_widget_controller.dart';
import 'package:waste_track/Models/Home%20Container%20Model/home_conntainer_model.dart';
import 'package:waste_track/Screens/Vendor%20Staff/scanner_view.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../Qr Scanner/scanner_button.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
    required this.widgetList,
    this.serialNumberChanged
  });

  final List<Widget> widgetList;
  final Function(String)? serialNumberChanged;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeWidgetController homeWidgetController = HomeWidgetController();
  String userType = "1";
  List<ContainerItemModel> containerItems = [];

  @override
  void initState() {
    getUserType();
    super.initState();
  }


  getUserType() async {
    userType = await SharedPref().getUserType();
    setState(() {
      if (userType == "1") {
        containerItems = [
          ContainerItemModel(
              name: 'User Management Model',
              imageUrl: 'assets/images/user.png',
              color: AppColor.blueLight),
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Vendor Management',
              imageUrl: 'assets/images/vendor.png',
              color: AppColor.yellowLight),
          ContainerItemModel(
              name: 'Revenue',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          ContainerItemModel(
              name: 'Withdraw Request',
              imageUrl: 'assets/images/withdraw.png',
              color: AppColor.seaGreenLight),
          ContainerItemModel(
              name: 'Invoices',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/waste.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "2") {
        containerItems = [
          ContainerItemModel(
              name: 'User Management Model',
              imageUrl: 'assets/images/user.png',
              color: AppColor.blueLight),
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Revenue',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          ContainerItemModel(
              name: 'Invoices',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/waste.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "3") {
        containerItems = [
          ContainerItemModel(
              name: 'User Management Model',
              imageUrl: 'assets/images/user.png',
              color: AppColor.blueLight),
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Revenue',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          ContainerItemModel(
              name: 'Invoices',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/waste.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "4") {
        containerItems = [
          ContainerItemModel(
              name: 'Staff Management',
              imageUrl: 'assets/images/user.png',
              color: AppColor.blueLight),
          ContainerItemModel(
              name: 'Order Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Waste Management',
              imageUrl: 'assets/images/vendor_waste.png',
              color: AppColor.yellowLight),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Withdraw Request',
              imageUrl: 'assets/images/withdraw.png',
              color: AppColor.seaGreenLight),
          ContainerItemModel(
              name: 'Revenue Generated',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          ContainerItemModel(
              name: 'Assigned Areas',
              imageUrl: 'assets/images/vendor_assigned.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "5") {
        containerItems = [
          ContainerItemModel(
              name: 'Waste Collected',
              imageUrl: 'assets/images/vendor_waste.png',
              color: AppColor.yellowLight),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "6") {
        containerItems = [
          ContainerItemModel(
              name: 'Staff Management',
              imageUrl: 'assets/images/user.png',
              color: AppColor.blueLight),
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleDark),
          ContainerItemModel(
              name: 'Revenue Generated',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "7") {
        containerItems = [
          ContainerItemModel(
              name: 'Waste Collected',
              imageUrl: 'assets/images/was_delete.png',
              color: AppColor.maroon),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/was_cal.png',
          //     color: AppColor.blueLight),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
      else if (userType == "8") {
        containerItems = [
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Revenue Generated',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleDark),
        ];
      }
      else if (userType == "10") {
        containerItems = [
          ContainerItemModel(
              name: 'Revenue Generated',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }

      else {
        containerItems = [
          ContainerItemModel(
              name: 'Nylon Management',
              imageUrl: 'assets/images/nylon.png',
              color: AppColor.pinkLight),
          ContainerItemModel(
              name: 'Revenue Generated',
              imageUrl: 'assets/images/revenue.png',
              color: AppColor.redLight),
          // ContainerItemModel(
          //     name: 'Sales Report',
          //     imageUrl: 'assets/images/invocies.png',
          //     color: AppColor.purpleLight),
          ContainerItemModel(
              name: 'Waste Collection',
              imageUrl: 'assets/images/invocies.png',
              color: AppColor.purpleDark),
          // ContainerItemModel(
          //     name: 'Calendar',
          //     imageUrl: 'assets/images/calendar.png',
          //     color: AppColor.purple),
          // ContainerItemModel(
          //     name: 'Ticketing',
          //     imageUrl: 'assets/images/ticketing.png',
          //     color: AppColor.greenMedium),
        ];
      }
    });
  }
  String? serialNumber;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return //show loader while verifying...
      Obx(
              (){
            return
              homeWidgetController.isLoading.value?
              Center(
                child: CupertinoActivityIndicator(
                  color: AppColor.green,
                ),
              ):
              Column(
                children: [

                  /// vendor staff waste management scanning serial number

                    if (userType == "5" || userType == "7")

                      ScannerButton(onChange: (loading,message,status){
                        if(loading){
                          homeWidgetController.toggleLoader();
                        }
                        else{
                          homeWidgetController.toggleLoader();
                          showVerifyDialog(message, status);
                        }
                      }),
                  SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 140.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 4.0),
                        itemCount: containerItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => widget.widgetList[index]),
                              );
                            },
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              clipBehavior: Clip.hardEdge,
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: containerItems[index].color,
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Image.asset(
                                          containerItems[index].imageUrl,
                                          height: 60,
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 14, right: 12),
                                          child: Text(
                                            containerItems[index].name,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
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
                ],
              );
          }
      );
  }


  // show dialog verified
  showVerifyDialog(String message,bool status){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
          if(status) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => widget.widgetList.first),
            );
          }
        });

        return CupertinoAlertDialog(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: status?AppColor.green:AppColor.redLight,
                ),
                child: Icon(
                  status? Icons.done:Icons.warning_amber,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10,),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15,
                      color: status?AppColor.green:AppColor.redDark),
                ),
              ),
            ],
          ), // show pop-up
        );
      },
    );
  }
}



