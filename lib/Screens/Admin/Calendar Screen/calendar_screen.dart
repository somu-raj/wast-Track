import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Admin/Calendar%20Screen/calendar_view.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime today = DateTime.now();

  String getDateStatus(DateTime date) {
    final DateTime today = DateTime.now();
    final int dayOfWeek = date.weekday;

    if ((dayOfWeek == 3 || dayOfWeek == 6) && date.isBefore(today)) {
      // Past date
      return "past";
    } else if ((dayOfWeek == 3 || dayOfWeek == 6) &&
        date.difference(today).inDays == 1) {
      // Next Wednesday or Saturday
      return "next";
    } else if ((dayOfWeek == 3 || dayOfWeek == 6) &&
        date.difference(today).inDays > 0) {
      // Upcoming Wednesday or Saturday
      return "upcoming";
    }
    // Default: Not a relevant date
    return "normal";
  }

  TextStyle dateStyle = TextStyle();

  List<String> beforePickUp = [];
  List<String> PickUp = ["2", "6", "9", "13"];
  List<String> upcomingPickUp = ["20", "23", "27", "30"];

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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Pick Up',
                        style: TextStyle(
                            color: AppColor.black.withOpacity(0.7),
                            fontSize: 13,
                            fontFamily: AppFont.poppinsSemiBold),
                      ),
                      Text(
                        "12",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 35,
                            fontFamily: AppFont.poppinsBold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColor.purple,
                            size: 20,
                          ),
                          Text(
                            "Before Pick Up Reminder",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsSemiBold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColor.GreenMedium,
                            size: 20,
                          ),
                          Text(
                            "Next Pick Up",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsSemiBold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColor.redLight,
                            size: 20,
                          ),
                          Text(
                            "Picked Up",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsSemiBold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColor.SkyBlue,
                            size: 20,
                          ),
                          Text(
                            "Upcoming Pick Up",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsSemiBold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  CalenderViewLayout(
                      date: DateTime.now(),
                      beforePickUp: beforePickUp,
                      nextPickUp: "16",
                      pickedUp: PickUp,
                      upcomingPickUp: upcomingPickUp),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Upcoming Schedules",
                    style: TextStyle(
                      fontFamily: AppFont.poppinsBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Reminder Time Table",
                    style: TextStyle(
                      fontFamily: AppFont.poppinsSemiBold,
                      fontSize: 13,
                      color: AppColor.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    itemCount: 20,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "10:00 AM",
                            style: TextStyle(
                              fontFamily: AppFont.poppinsBold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: setColorData(
                                      today.toString(),
                                      beforePickUp,
                                      PickUp,
                                      upcomingPickUp,
                                      PickUp.toString())),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: AppColor.purple,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Friday",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsSemiBold,
                                            color: AppColor.black
                                                .withOpacity(0.5)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "10 Oct 2023",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsSemiBold,
                                            color: AppColor.black
                                                .withOpacity(0.5)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Color setColorData(
      String date,
      List<String> beforePickAry,
      List<String> pickedUpAry,
      List<String> upcomingPickAry,
      String nextPickedUp) {
    if (RegExp(r'^[0-9]+$').hasMatch(date)) {
      if (beforePickAry.contains(date)) {
        return Color(0xffDDB5FD);
      } else if (pickedUpAry.contains(date)) {
        return Color(0xffFF9898);
      } else if (upcomingPickAry.contains(date)) {
        return Color(0xffA5E8FF);
      } else if (date == nextPickedUp) {
        return Color(0xff97E7BF);
      } else {
        return Colors.white;
      }
    }
    return Colors.white;
  }
}
