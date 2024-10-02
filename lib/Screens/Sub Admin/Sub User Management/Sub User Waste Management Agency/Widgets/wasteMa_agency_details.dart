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

import '../../../../../Conrollers/Admin/User Management Controller/waste_angency_controller.dart';

class SubUserWasteMaAgencyDetails extends StatefulWidget {
  const SubUserWasteMaAgencyDetails({super.key});

  @override
  State<SubUserWasteMaAgencyDetails> createState() =>
      _SubUserWasteMaAgencyDetailsState();
}

class _SubUserWasteMaAgencyDetailsState
    extends State<SubUserWasteMaAgencyDetails> {
  bool isButtonSelected = false;
  final wasteManagementController = Get.put(WasteManagementAgeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: WasteManagementAgencyController(context: context),
      builder: (controller)=> Scaffold(
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
                    // GestureDetector(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.vertical(
                    //           top: Radius.circular(25.0),
                    //         ),
                    //       ),
                    //       backgroundColor: Colors.white,
                    //       builder: (BuildContext context) {
                    //         return Wrap(
                    //           children: [
                    //             Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(20.0),
                    //                         child: Row(
                    //                           children: [
                    //                             SvgPicture.asset(
                    //                               AppImages.union,
                    //                               height: 15,
                    //                             ),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             const Text(
                    //                               "Filter By",
                    //                               style: TextStyle(
                    //                                   fontFamily: AppFont
                    //                                       .poppinsSemiBold),
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Order Id'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Divider(
                    //                         color: Colors.black.withOpacity(0.59),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Vendor Code'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Divider(
                    //                         color: Colors.black.withOpacity(0.59),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Company Name'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Divider(
                    //                         color: Colors.black.withOpacity(0.59),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Order Date'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Divider(
                    //                         color: Colors.black.withOpacity(0.59),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Order Amount'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Divider(
                    //                         color: Colors.black.withOpacity(0.59),
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 20,
                    //                             right: 20,
                    //                             top: 10,
                    //                             bottom: 10),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.spaceBetween,
                    //                           children: [
                    //                             Text('Revenue Earned'),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             CustomRadioButton(
                    //                               isSelected: isButtonSelected,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   isButtonSelected = value;
                    //                                 });
                    //                               },
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       const SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                     ])
                    //               ],
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: Container(
                    //       padding: EdgeInsets.all(6),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         border: Border.all(color: AppColor.green),
                    //         borderRadius: BorderRadius.circular(7),
                    //       ),
                    //       child: Icon(
                    //         Icons.filter_alt_outlined,
                    //         color: AppColor.green,
                    //       )),
                    // )
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
                          controller.wasteModel?.data?.imageName == null ? Container(
                            padding: const EdgeInsets.all(2),
                            // clipBehavior: Clip.hardEdge,
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(42),
                                child: Image.asset(AppImages.profileImg)),
                          ):Container(
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            padding: const EdgeInsets.all(2),
                            clipBehavior: Clip.hardEdge,
                            height: 70,
                            width: 70,
                            child: Image.network('${controller.wasteModel?.data?.imageBaseUrl}${controller.wasteModel?.data?.imageName}',
                                fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            "${controller.wasteModel?.data?.roleInfo?.roleName}",
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
                           Text(
                            "${controller.wasteModel?.data?.firstName}",
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
                           Text(
                            "${controller.wasteModel?.data?.email}",
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
                    itemCount: controller.getRevenueShareListModel?.data.length,
                    itemBuilder: (context, index) {
                      var  revenueList = controller.getRevenueShareListModel?.data[index];
                      return Obx(
                        () {
                          return Column(
                            children: [
                              Visibility(
                                visible: wasteManagementController
                                    .isContainerVisible.isTrue,
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
                                                      "Order ID",
                                                      style: TextStyle(
                                                          color: AppColor.black,
                                                          fontSize: 13,
                                                          fontFamily: AppFont
                                                              .poppinsLight),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child:  Text(
                                                      "#${revenueList?.orderId}",
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
                                                      "Revenue Earned",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: AppFont
                                                              .poppinsSemiBold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: const Text(
                                                      "₦3,790.00",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: AppFont
                                                              .poppinsSemiBold),
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
                                            wasteManagementController
                                                .ContainerVisible();
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
                                visible: wasteManagementController
                                    .isContainerVisible.isFalse,
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
                                                      "Order ID",
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
                                                      "#123456789",
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
                                                      "Vendor Code",
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
                                                      "123456",
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
                                                      "Company Name",
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
                                                      "Enumeral Waste Solutions",
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
                                                      "Order Date",
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
                                                      "Order Amount",
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
                                                      "₦37,900.00",
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
                                                      "Revenue Earned",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: AppFont
                                                              .poppinsSemiBold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: const Text(
                                                      "₦3,790.00",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: AppFont
                                                              .poppinsSemiBold),
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
                                            wasteManagementController
                                                .ContainerHide();
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
      ),
    );
  }
}
