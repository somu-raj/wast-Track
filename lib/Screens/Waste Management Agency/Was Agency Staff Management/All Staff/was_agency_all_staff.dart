import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Waste%20Management%20Agency%20Controller/Staff%20Management%20Controller/was_agency_sraff_contorller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class WasAgencyAllStaff extends StatefulWidget {
  const WasAgencyAllStaff({super.key});

  @override
  State<WasAgencyAllStaff> createState() => _WasAgencyAllStaffState();
}

class _WasAgencyAllStaffState extends State<WasAgencyAllStaff> {
  final controller = Get.put(WasAgencyStaffManagementController());
  bool isButtonSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7, left: 15),
            child: Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    hintText: 'Search  here...',
                    hintStyle: TextStyle(
                        fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColor.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppImages.union,
                                              height: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              "Filter By",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFont.poppinsSemiBold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Name'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.59),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Email'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.59),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Date Added'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ])
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: AppColor.green,
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Text(
              "Waste Management Staff Details ",
              style: TextStyle(
                  fontFamily: AppFont.poppinsBold,
                  color: AppColor.green,
                  fontSize: 17),
            ),
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
                  print('index=>${index}');
                  return Obx(() {
                    return Stack(clipBehavior: Clip.none, children: [
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        margin: const EdgeInsets.only(bottom: 3),
                        child: Card(
                          elevation: 1,
                          margin: EdgeInsets.zero,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: const Text(
                                        "Name",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        "Lorem ipsum",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: const Text(
                                        "Email",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        "VendorStaff@gmail.com",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Divider(
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: const Text(
                                        "Contact Number",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        "+234 90-123-4000",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Divider(
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: const Text(
                                        "Date Added",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        "19 Sept 2023",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 12,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 320,
                        top: -8,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleVisibility(index);
                          },
                          child: Image.asset(
                            AppImages.opestion,
                            height: 50,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 215,
                        top: -8,
                        child: Visibility(
                          visible: controller.areOptionVisibleList[index],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  AppScreen.wasAgencyAllStaffDetailsScreen);
                            },
                            child: Container(
                              child: Image.asset(
                                AppImages.eye,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 250,
                        top: -8,
                        child: Visibility(
                          visible: controller.areOptionVisibleList[index],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  AppScreen.editAllWasAgencyStaffDetailsScreen);
                            },
                            child: Container(
                              child: Image.asset(
                                AppImages.edit,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 285,
                        top: -8,
                        child: Visibility(
                          visible: controller.areOptionVisibleList[index],
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to Delete this User?",
                                          style: TextStyle(
                                              fontSize: 15,
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
                                                      BorderRadius.circular(7),
                                                  color: AppColor.green,
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          AppFont.poppinsLight,
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
                                                                EdgeInsets.all(
                                                                    10),
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " User Deleted Successfully",
                                                              style: TextStyle(
                                                                  fontSize: 15,
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
                                                      BorderRadius.circular(7),
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
                              child: Image.asset(
                                AppImages.delete,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
