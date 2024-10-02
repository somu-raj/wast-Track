import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/Models/Calendar/calendar_model.dart';

class CalenderViewLayout extends StatefulWidget {
  DateTime? date;
  String? nextPickUp;
  List<String> beforePickUp;
  List<String> pickedUp;
  List<String> upcomingPickUp;
  CalenderViewLayout(
      {super.key,
      required this.date,
      required this.pickedUp,
      required this.beforePickUp,
      required this.nextPickUp,
      required this.upcomingPickUp});

  @override
  State<CalenderViewLayout> createState() => _CalenderViewLayoutState();
}

class _CalenderViewLayoutState extends State<CalenderViewLayout> {
  String? _chosenValue;

  List<String> selectMonth = [];

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["S", "M", "T", "W", "T", "F", "S"];

  List<String> sundayData = ["S"];
  List<String> mondayData = ["M"];
  List<String> thuesdayData = ["T"];
  List<String> wednesdayData = ["W"];
  List<String> thuresdayData = ["T"];
  List<String> fridayData = ["F"];
  List<String> saturdayData = ["S"];

  List<CalenderModel> dateData = [];

  void generateCurrentMonthDates() {
    var currentDateData = widget.date!;
    final now = DateTime(
        currentDateData.year, currentDateData.month, currentDateData.day);

    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 1);

    final List<String> datesWithDays = [];

    selectMonth.add(
        "${DateFormat('MMM').format(DateTime(currentDateData.year, currentDateData.month, currentDateData.day))} ${DateTime(currentDateData.year, currentDateData.month, currentDateData.day).year}");
    selectMonth.add(
        "${DateFormat('MMM').format(DateTime(currentDateData.year, currentDateData.month + 1, currentDateData.day))} ${DateTime(currentDateData.year, currentDateData.month + 1, currentDateData.day).year}");
    selectMonth.add(
        "${DateFormat('MMM').format(DateTime(currentDateData.year, currentDateData.month + 2, currentDateData.day))} ${DateTime(currentDateData.year, currentDateData.month + 2, currentDateData.day).year}");

    setState(() {
      _chosenValue =
          "${DateFormat('MMM').format(DateTime(currentDateData.year, currentDateData.month, currentDateData.day))} ${DateTime(currentDateData.year, currentDateData.month, currentDateData.day).year}";
    });

    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth);
        day = day.add(Duration(days: 1))) {
      final formattedDate = DateFormat('d').format(day);
      final dayOfWeek = DateFormat('EEE').format(day);
      datesWithDays.add('$formattedDate ($dayOfWeek)');

      bool isEmpty = true;

      dateData.add(CalenderModel(dateVal: formattedDate, day: dayOfWeek[0]));
      if (dayOfWeek == "Sun") {
        sundayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) sundayData.add("");
      }
      if (dayOfWeek == "Mon") {
        mondayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) mondayData.add("");
      }
      if (dayOfWeek == "Tue") {
        thuesdayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) thuesdayData.add("");
      }
      if (dayOfWeek == "Wed") {
        wednesdayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) wednesdayData.add("");
      }
      if (dayOfWeek == "Thu") {
        thuresdayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) thuresdayData.add("");
      }
      if (dayOfWeek == "Fri") {
        fridayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) fridayData.add("");
      }
      if (dayOfWeek == "Sat") {
        saturdayData.add(formattedDate);
        isEmpty = false;
      } else {
        if (int.parse(formattedDate) < 2 && isEmpty) saturdayData.add("");
      }
    }
  }

  @override
  void initState() {
    generateCurrentMonthDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Calender",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          //<-- SEE HERE
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.calendar_today,
                                size: 16,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isDense: true,
                                items: selectMonth
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: _chosenValue,
                                onChanged: (value) {
                                  print("selected value => $value");
                                  setState(() {
                                    _chosenValue = value!;

                                    sundayData.clear();
                                    sundayData.add("S");

                                    mondayData.clear();
                                    mondayData.add("M");

                                    thuesdayData.clear();
                                    thuesdayData.add("T");

                                    wednesdayData.clear();
                                    wednesdayData.add("W");

                                    thuresdayData.clear();
                                    thuresdayData.add("T");

                                    fridayData.clear();
                                    fridayData.add("F");

                                    saturdayData.clear();
                                    saturdayData.add("S");

                                    final selectMonthIndex =
                                        listOfMonths.indexWhere((element) =>
                                                element ==
                                                value!.split(" ")[0]) +
                                            1;
                                    var currentDateData = widget.date!;
                                    final now = DateTime(
                                        int.parse(value!.split(" ")[1]),
                                        selectMonthIndex,
                                        currentDateData.day);
                                    //   var currentDateData =  DateTime.now();
                                    // final now = DateTime(currentDateData.year, currentDateData.month, currentDateData.day);

                                    final firstDayOfMonth =
                                        DateTime(now.year, now.month, 1);
                                    final lastDayOfMonth =
                                        DateTime(now.year, now.month + 1, 1);

                                    for (var day = firstDayOfMonth;
                                        day.isBefore(lastDayOfMonth);
                                        day = day.add(Duration(days: 1))) {
                                      final formattedDate =
                                          DateFormat('d').format(day);
                                      final dayOfWeek =
                                          DateFormat('EEE').format(day);

                                      bool isEmpty = true;

                                      dateData.add(CalenderModel(
                                          dateVal: formattedDate,
                                          day: dayOfWeek[0]));
                                      if (dayOfWeek == "Sun") {
                                        sundayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) sundayData.add("");
                                      }
                                      if (dayOfWeek == "Mon") {
                                        mondayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) mondayData.add("");
                                      }
                                      if (dayOfWeek == "Tue") {
                                        thuesdayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) thuesdayData.add("");
                                      }
                                      if (dayOfWeek == "Wed") {
                                        wednesdayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) wednesdayData.add("");
                                      }
                                      if (dayOfWeek == "Thu") {
                                        thuresdayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) thuresdayData.add("");
                                      }
                                      if (dayOfWeek == "Fri") {
                                        fridayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) fridayData.add("");
                                      }
                                      if (dayOfWeek == "Sat") {
                                        saturdayData.add(formattedDate);
                                        isEmpty = false;
                                      } else {
                                        if (int.parse(formattedDate) < 2 &&
                                            isEmpty) saturdayData.add("");
                                      }
                                    }
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  // height: 50,
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  iconSize: 20,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.black,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  width: 150,
                                  offset: const Offset(-25, -8),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < sundayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height:
                                  RegExp(r'^[0-9]+$').hasMatch(sundayData[i]) &&
                                          int.parse(sundayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              width:
                                  RegExp(r'^[0-9]+$').hasMatch(sundayData[i]) &&
                                          int.parse(sundayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      sundayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                sundayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < mondayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height:
                                  RegExp(r'^[0-9]+$').hasMatch(mondayData[i]) &&
                                          int.parse(mondayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              width:
                                  RegExp(r'^[0-9]+$').hasMatch(mondayData[i]) &&
                                          int.parse(mondayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      mondayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                mondayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < thuesdayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height: RegExp(r'^[0-9]+$')
                                          .hasMatch(thuesdayData[i]) &&
                                      int.parse(thuesdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              width: RegExp(r'^[0-9]+$')
                                          .hasMatch(thuesdayData[i]) &&
                                      int.parse(thuesdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      thuesdayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                thuesdayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < wednesdayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height: RegExp(r'^[0-9]+$')
                                          .hasMatch(wednesdayData[i]) &&
                                      int.parse(wednesdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              width: RegExp(r'^[0-9]+$')
                                          .hasMatch(wednesdayData[i]) &&
                                      int.parse(wednesdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      wednesdayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                wednesdayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < thuresdayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height: RegExp(r'^[0-9]+$')
                                          .hasMatch(thuresdayData[i]) &&
                                      int.parse(thuresdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              width: RegExp(r'^[0-9]+$')
                                          .hasMatch(thuresdayData[i]) &&
                                      int.parse(thuresdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      thuresdayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                thuresdayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < fridayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height:
                                  RegExp(r'^[0-9]+$').hasMatch(fridayData[i]) &&
                                          int.parse(fridayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              width:
                                  RegExp(r'^[0-9]+$').hasMatch(fridayData[i]) &&
                                          int.parse(fridayData[i]) ==
                                              int.parse(widget.nextPickUp ?? "")
                                      ? 35
                                      : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      fridayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                fridayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < saturdayData.length; i++)
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(2.0),
                              height: RegExp(r'^[0-9]+$')
                                          .hasMatch(saturdayData[i]) &&
                                      int.parse(saturdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              width: RegExp(r'^[0-9]+$')
                                          .hasMatch(saturdayData[i]) &&
                                      int.parse(saturdayData[i]) ==
                                          int.parse(widget.nextPickUp ?? "")
                                  ? 35
                                  : 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: setColorData(
                                      saturdayData[i],
                                      widget.beforePickUp,
                                      widget.pickedUp,
                                      widget.upcomingPickUp,
                                      widget.nextPickUp!)),
                              child: Center(
                                  child: Text(
                                saturdayData[i],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: i > 0
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  // bool ischeckBeforePickUp(List<String> beforePickAry, String valueData){
  //   return beforePickAry.contains(valueData);
  // }

  // bool ischeckPickUp(List<String> pickedUpAry, String valueData){
  //   return pickedUpAry.contains(valueData);
  // }

  // bool ischeckUpcomingPickUp(List<String> upcomingPickAry, String valueData){
  //   return upcomingPickAry.contains(valueData);
  // }

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
