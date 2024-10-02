import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Vendor/Staff%20%20Management%20Controller/staff_mangement_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class VendorAllStaffDetails extends StatefulWidget {
  const VendorAllStaffDetails({super.key});

  @override
  State<VendorAllStaffDetails> createState() => _VendorAllStaffDetailsState();
}

class _VendorAllStaffDetailsState extends State<VendorAllStaffDetails> {
  bool isButtonSelected = false;

  final vendorStaffController = Get.put(StaffManagementController());
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
        padding: EdgeInsets.all(15),
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
                                      left: 20, right: 20, top: 10, bottom: 10),
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
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Batch Number'),
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
                                      left: 20, right: 20, top: 10, bottom: 10),
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
                                      left: 20, right: 20, top: 10, bottom: 10),
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
                                      left: 20, right: 20, top: 10, bottom: 10),
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
                                )
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Vendor Staff Name",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsBold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
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
                          "vendorStaff@gmail.com",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsMedium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.call_end_outlined, color: AppColor.green),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "+234 90-461-4000",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsMedium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '    Waste Collected',
                style: TextStyle(
                    color: AppColor.green,
                    fontFamily: AppFont.poppinsBold,
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
                    return Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                                          "Waste Collected (Kg)",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "50",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
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
                                          "Pickup Date & Day",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "14 Sept 2023, Wednesday",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
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
                                          "Nylon Bags Quantity",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 12,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: const Text(
                                          "10",
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppScreen.wasteSerialDetailsScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12, top: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColor.green,
                                    fontSize: 11,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: AppColor.green,
                                  size: 11,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                      ],
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
