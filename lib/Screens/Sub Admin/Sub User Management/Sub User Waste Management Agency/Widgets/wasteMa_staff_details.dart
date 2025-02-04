import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Sub%20Admin/Sub%20Use%20Management%20Controller/sub_user_management_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class SubUserWasteMaStaffDetails extends StatefulWidget {
  const SubUserWasteMaStaffDetails({super.key});

  @override
  State<SubUserWasteMaStaffDetails> createState() =>
      _SubUserWasteMaStaffDetailsState();
}

class _SubUserWasteMaStaffDetailsState
    extends State<SubUserWasteMaStaffDetails> {
  bool isButtonSelected = false;
  final wasteManagementStaffController =
      Get.put(WasteManagementAgeController());
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 7),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                    fontFamily: AppFont
                                                        .poppinsSemiBold),
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
                                              Text('Serial Number'),
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
                                              Text('Buyer Name'),
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
                                              Text('Contact Number'),
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
                                              Text('Collection Date'),
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
                                              Text('Status'),
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
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 1,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(2),
                          // clipBehavior: Clip.hardEdge,
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(42),
                              child: Image.asset(AppImages.profileImg)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Waste Management Staff",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsBold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          color: AppColor.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Lorem Ipsum",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsMedium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined, color: AppColor.green),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "wastemanagementstaff@gmail.com",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsMedium),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Obx(
                      () {
                        return Column(
                          children: [
                            Visibility(
                              visible: wasteManagementStaffController
                                  .isContainerStaffVisible.isTrue,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 20),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Card(
                                      elevation: 1,
                                      margin: EdgeInsets.zero,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                    "Serial Number",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "HXC8849287896",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Collection Date",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "14 Sept 2023, 12:45PM",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                    left: 25,
                                    top: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 4,
                                          left: 11,
                                          right: 11,
                                          bottom: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColor.greenMedium1),
                                      child: Text(
                                        'COLLECTED-ORIGINAL',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: AppColor.green),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 300,
                                    top: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3, color: AppColor.green)),
                                      child: GestureDetector(
                                        onTap: () {
                                          wasteManagementStaffController
                                              .ContainerStaffVisible();
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          size: 20,
                                          color: AppColor.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: wasteManagementStaffController
                                  .isContainerStaffVisible.isFalse,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 20),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Card(
                                      elevation: 1,
                                      margin: EdgeInsets.zero,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                    "Serial Number",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "HCX8849287896",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Buyer Name",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "Lorem ipsum",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Contact Number",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "+234 09-461-2000",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Collection Date",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "14 Sept 2023, 12:45PM",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Status",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "Verified",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                                    "Remark",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "Nylon was Original",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsLight),
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
                                    left: 25,
                                    top: 7,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 4,
                                          left: 11,
                                          right: 11,
                                          bottom: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColor.greenMedium1),
                                      child: Text(
                                        'COLLECTED-ORIGINAL',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: AppColor.green),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 300,
                                    top: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3, color: AppColor.green)),
                                      child: GestureDetector(
                                        onTap: () {
                                          wasteManagementStaffController
                                              .ContainerStaffHide();
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_up_sharp,
                                          size: 20,
                                          color: AppColor.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
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
