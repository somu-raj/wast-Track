import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/Models/Notification%20Model/get_notification_model.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../Conrollers/Notifications/notification_controller.dart';
import '../../../Utils/images/images.dart';

class NotificationScreen extends StatefulWidget {
final GetNotificationModel?  notification;
final bool? isFromProfile;
   NotificationScreen({super.key, this.notification,this.isFromProfile});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {



  void initState() {
    DateTime now = DateTime.now();
    formattedTime = DateFormat.Hms().format(now);
    print("Current time: $formattedTime");

    super.initState();
  }
  String? formattedTime;
  getNotificationTime(DateTime dateTime){
    DateTime currentDateTime = DateTime.now();
    if(dateTime.day == currentDateTime.day){
      if(dateTime.hour == currentDateTime.hour ){
       if(dateTime.minute == currentDateTime.minute ){
          return "now";
       }
       return "${currentDateTime.minute-dateTime.minute} minutes ago";
      }
      return "${dateTime.hour}:${dateTime.minute}";

    }
    else if( (currentDateTime.day -1) == dateTime.day){
      return 'yesterday';
    }
    else{
      return DateFormat("dd/MM/YYYY").format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: NotificationController(context:context),
       builder: (controller) =>
       Scaffold(

        appBar: widget.isFromProfile ?? false ? AppBar(
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
        ):AppBar(backgroundColor: Colors.transparent,elevation: 0,toolbarHeight: 0.0),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Notifications",
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                  fontFamily: AppFont.poppinsBold),
            ),

             


            Flexible(
              child:controller.getNotificationModel?.data == null ? myShimmer(): controller.getNotificationModel?.data.length == 0 ?Center(child: Text("Notification not found !!")): ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: controller.getNotificationModel?.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var notification =  controller.getNotificationModel?.data[index];

                    //debugPrint(DateTime.parse(notification?.createdAt.toString() ?? "" ).hour.toString());
                    String apiTime =  notification?.createdAt.toString() ?? "" ;
                    String notificationDateTime =getNotificationTime(DateTime.parse(notification?.createdAt.toString() ?? "" ));
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColor.lightPink.withOpacity(0.4)),
                            child: const Text(
                              "S A",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 15,
                                  fontFamily: AppFont.poppinsBold),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                     Text(
                                      "${notification?.title}",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 12,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                       Text(
                                         notificationDateTime,
                                      style: TextStyle(
                                          color: AppColor.grey1,
                                          fontSize: 9,
                                          fontFamily: AppFont.poppinsSemiBold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                 Text(
                                  "${notification?.message}....",

                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 11,
                                      fontFamily: AppFont.poppinsMedium),
                                   
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
