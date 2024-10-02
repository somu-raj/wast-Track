import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/user_management_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  bool isButtonSelected = false;
  final vendorVisibilityController = Get.put(VendorVisibilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.green,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppScreen.ecoBlueSubAdminAddScreen,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Row(
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Text('Vendor Code'),
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
                                            Text('Company Name'),
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
                                            Text('Company Address'),
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
                                            Text('Company Email'),
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
                                            Text('Contact Name'),
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
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    print('index=>${index}');
                    return Obx(() {
                      return Stack(clipBehavior: Clip.none, children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 13,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
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
                                          "Vendor Code",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "12345",
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
                                          "Company Name",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "Enumeral Waste Solutions",
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
                                          "Company Address",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "abc street, xyz city",
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
                                          "Company Email",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "vendor@gmail.com",
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
                                          "Contact Name",
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
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 300,
                          top: -8,
                          child: GestureDetector(
                            onTap: () {
                              vendorVisibilityController.toggleVisibility(index);
                            },
                            child: Image.asset(
                              AppImages.opestion,
                              height: 50,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 197,
                          top: -8,
                          child: Visibility(
                            visible: vendorVisibilityController
                                .areOptionVisibleList[index],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppScreen.vendorDetailsScreen);
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
                          left: 232,
                          top: -8,
                          child: Visibility(
                            visible: vendorVisibilityController
                                .areOptionVisibleList[index],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppScreen.vendorEditScreen);
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
                          left: 265,
                          top: -8,
                          child: Visibility(
                            visible: vendorVisibilityController
                                .areOptionVisibleList[index],
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
      ),
    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
