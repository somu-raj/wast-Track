import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class AreaAlloted extends StatefulWidget {
  const AreaAlloted({super.key});

  @override
  State<AreaAlloted> createState() => _AreaAllotedState();
}

class _AreaAllotedState extends State<AreaAlloted> {
  String? dropdownValue; // Declare a variable to store the selected value

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.green,
                  ),
                  underline: Container(),
                  hint: Text(
                    'Select Area',
                    style: TextStyle(
                        color: AppColor.black.withOpacity(0.4), fontSize: 12),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "Enumeral1",
                      child: Text("Enumeral  Solutions Limited",
                          style:
                              TextStyle(color: AppColor.black, fontSize: 12)),
                    ),
                    DropdownMenuItem(
                      value: "Enumeral2",
                      child: Text(
                        "Enumeral  Solutions Limited",
                        style: TextStyle(color: AppColor.black, fontSize: 12),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Enumeral3",
                      child: Text("Enumeral  Solutions Limited",
                          style:
                              TextStyle(color: AppColor.black, fontSize: 12)),
                    ),
                    DropdownMenuItem(
                      value: "Enumeral4",
                      child: Text("Enumeral  Solutions Limited",
                          style:
                              TextStyle(color: AppColor.black, fontSize: 12)),
                    ),
                    DropdownMenuItem(
                      value: "Enumeral5",
                      child: Text("Enumeral  Solutions Limited",
                          style:
                              TextStyle(color: AppColor.black, fontSize: 12)),
                    ),
                    // Add more DropdownMenuItem widgets as needed
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.greenLight.withOpacity(0.5)),
                child: Text(
                  'Assign',
                  style: TextStyle(color: AppColor.green),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: const Text(
                                "Area:",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 12,
                                    fontFamily: AppFont.poppinsSemiBold),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: const Text(
                                "Lorem ipsum dolor sit amet. Nam ducimus repellendus At voluptatem",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 11,
                                    fontFamily: AppFont.poppinsLight),
                              ),
                            ),
                            Flexible(
                                child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Column(
                                        children: [
                                          Text(
                                            "Are you sure you want to Unassign this area?",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(9),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: AppColor.green,
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontFamily: AppFont
                                                            .poppinsLight,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      Future.delayed(
                                                          Duration(seconds: 1),
                                                          () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      });

                                                      return CupertinoAlertDialog(
                                                        title: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: AppColor
                                                                    .green,
                                                              ),
                                                              child: Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                "Area Unassigned Successfully.",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColor
                                                                        .green),
                                                              ),
                                                            ),
                                                          ],
                                                        ), // show pop-up
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 10,
                                                      top: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: AppColor.green,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'yes',
                                                      style: TextStyle(
                                                          fontFamily: AppFont
                                                              .poppinsLight,
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ), // show pop-up
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.redLight.withOpacity(0.5)),
                                child: Text(
                                  'Unassign',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 11),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
