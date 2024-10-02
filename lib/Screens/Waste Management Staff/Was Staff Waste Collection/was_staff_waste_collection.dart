import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Vendor Staff/Vendor Staff Waste Collected/waste_collected_controller.dart';
import '../../../Utils/Components/myShimmer.dart';

class WasStaffWasteCollection extends StatefulWidget {
  const WasStaffWasteCollection({super.key});

  @override
  State<WasStaffWasteCollection> createState() =>
      _WasStaffWasteCollectionState();
}

class _WasStaffWasteCollectionState extends State<WasStaffWasteCollection>
    with SingleTickerProviderStateMixin {
  bool isButtonSelected = false;
  late TabController tabController;
  late WasteCollectedController wasteCollectedController;

  @override
  void initState() {
    super.initState();
    wasteCollectedController = WasteCollectedController(context: context);
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if(tabController.indexIsChanging){

          if(tabController.index == 1){
            wasteCollectedController.getWasteCollectionListModel = null;
            wasteCollectedController.isPendingRequest = false;
            wasteCollectedController.getWasteCollectionApi(context,"1","","","2");
          }
          else{
            wasteCollectedController.getWasteCollectionListModel = null;
            wasteCollectedController.isPendingRequest = true;
            wasteCollectedController.getWasteCollectionApi(context,"1","","","1");
          }
        }
      });

    wasteCollectedController.getWasteCollectionApi(context,"1","","","1");
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: wasteCollectedController,
      builder: (controller) =>
          Scaffold(
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
                        'Waste Track',
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
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSearchTextField(
                          onChanged: (value) async {
                            if(tabController.index == 1){
                              controller.getWasteCollectionListModel = null;
                              controller.getWasteCollectionApi(context,"1","",value,"2");
                            }
                            else{
                              controller.getWasteCollectionListModel = null;
                              controller.getWasteCollectionApi(context,"1","",value,"1");
                            }
                          },
                          hintText: 'Search here...',
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
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      //                                   fontFamily:
                      //                                       AppFont.poppinsSemiBold),
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
                      //                             Text('Serial Number'),
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
                      //                             Text('Batch Number'),
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
                      //                             Text('Buyer Name'),
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
                      //                             Text('Contact Number'),
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
                      //                             Text('Collection Date'),
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
                      //         border:
                      //             Border.all(color: AppColor.green.withOpacity(0.5)),
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
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: TabBar(
                              labelColor: AppColor.green,
                              labelStyle: TextStyle(fontSize: 15),
                              unselectedLabelColor: AppColor.grey1,
                              indicator: UnderlineTabIndicator(
                                borderSide:
                                BorderSide(color: AppColor.green, width: 2),
                                insets: EdgeInsets.symmetric(horizontal: 2),
                              ),
                              controller: tabController,
                              tabs: const [
                                Tab(text: 'Pending'),
                                Tab(text: 'Verified'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * .01,
                                ),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child:  controller.getWasteCollectionListModel == null ?
                                    myShimmer(): controller.getWasteCollectionListModel?.data.length == 0
                                        ? Center(child: Text("No pending collected waste found !!")) : ListView(
                                      controller: _scrollController,
                                      children: List.generate(
                                        controller.getWasteCollectionListModel!.data.length,
                                            (index) => Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              margin:
                                              const EdgeInsets.only(bottom: 5),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
                                                              "Serial Number",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
                                                                  fontSize: 13,
                                                                  fontFamily: AppFont
                                                                      .poppinsLight),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:  Text(
                                                              "${controller.getWasteCollectionListModel!.data[index].serialNumber}",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
                                                              "Batch Number",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
                                                                  fontSize: 13,
                                                                  fontFamily: AppFont
                                                                      .poppinsLight),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:  Text(
                                                              "${controller.getWasteCollectionListModel!.data[index].batchNumber}",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
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
                                                      // Divider(
                                                      //   color: AppColor.black,
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .spaceAround,
                                                      //   children: [
                                                      //     Expanded(
                                                      //       child: const Text(
                                                      //         "Buyer Name",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //                 AppColor.black,
                                                      //             fontSize: 13,
                                                      //             fontFamily: AppFont
                                                      //                 .poppinsLight),
                                                      //       ),
                                                      //     ),
                                                      //     Expanded(
                                                      //       flex: 1,
                                                      //       child: const Text(
                                                      //         "Enumeral Solutions Ltd.",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //                 AppColor.black,
                                                      //             fontSize: 12,
                                                      //             fontFamily: AppFont
                                                      //                 .poppinsLight),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 7,
                                                      // ),
                                                      // Divider(
                                                      //   color: AppColor.black,
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .spaceAround,
                                                      //   children: [
                                                      //     Expanded(
                                                      //       child: const Text(
                                                      //         "Contact Number",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //                 AppColor.black,
                                                      //             fontSize: 13,
                                                      //             fontFamily: AppFont
                                                      //                 .poppinsLight),
                                                      //       ),
                                                      //     ),
                                                      //     Expanded(
                                                      //       flex: 1,
                                                      //       child: const Text(
                                                      //         "+234 09-461-4000",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //                 AppColor.black,
                                                      //             fontSize: 12,
                                                      //             fontFamily: AppFont
                                                      //                 .poppinsLight),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 7,
                                                      // ),
                                                      Divider(
                                                        color: AppColor.black,
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
                                                              "Collection Date",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
                                                                  fontSize: 13,
                                                                  fontFamily: AppFont
                                                                      .poppinsLight),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:  Text(
                                                              "${controller.getWasteCollectionListModel!.data[index].collectedDate}",
                                                              style: TextStyle(
                                                                  color:
                                                                  AppColor.black,
                                                                  fontSize: 12,
                                                                  fontFamily: AppFont
                                                                      .poppinsLight),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Flexible(
                                                            child: InkWell(
                                                              onTap: (){
                                                                controller.updateCollectionStatusApi(controller.getWasteCollectionListModel!.data[index].id, 3,index, context).then((value) {
                                                                  controller.getWasteCollectionApi(context, "1", "", "","1");
                                                                });
                                                              },
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets.all(12),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        5),
                                                                    color: Colors.red
                                                                        .withOpacity(
                                                                        0.1)),
                                                                child: Center(
                                                                  child: controller.wasteCollectedVisibilityListForNotFound[index]? CupertinoActivityIndicator(): Text(
                                                                    "REJECT",
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.red,
                                                                        fontSize: 13,
                                                                        fontFamily: AppFont
                                                                            .poppinsSemiBold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            child: InkWell(
                                                              onTap: (){
                                                                controller.updateCollectionStatusApi(controller.getWasteCollectionListModel!.data[index].id, 2,index, context).then((value) {
                                                                  controller.getWasteCollectionApi(context, "1", "", "","1");
                                                                });
                                                              },
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets.all(12),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        5),
                                                                    color: AppColor
                                                                        .greenLight
                                                                        .withOpacity(
                                                                        0.4)),
                                                                child: Center(
                                                                  child: controller.wasteCollectedVisibilityList[index]? CupertinoActivityIndicator(): Text(
                                                                    "APPROVE",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize: 13,
                                                                        fontFamily: AppFont
                                                                            .poppinsSemiBold),
                                                                  ),
                                                                ),
                                                              ),
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
                                              left: 25,
                                              top: 2,
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
                                                    '${controller.getWasteCollectionListModel!.data[index].validation!.toUpperCase()}',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: AppColor.green),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * .01,
                                ),
                                Expanded(
                                  child: ScrollConfiguration(
                                    behavior: MyBehavior(),
                                    child: controller.getWasteVerifyCollectionListModel == null ?
                                    myShimmer(): controller.getWasteVerifyCollectionListModel!.data.length == 0 ?
                                    Center(child: Text("No verified collected waste found !!")) : ListView(
                                      children: List.generate(
                                          controller.getWasteVerifyCollectionListModel!.data.length,
                                              (index) => Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Card(
                                                    elevation: 1,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20)),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Serial Number",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      13,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  "${controller.getWasteVerifyCollectionListModel!.data[index].serialNumber}",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      13,
                                                                      fontFamily:
                                                                      AppFont
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
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Batch Number",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      13,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  "${controller.getWasteVerifyCollectionListModel!.data[index].batchNumber}",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      12,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsLight),
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
                                                          // Row(
                                                          //   mainAxisAlignment:
                                                          //       MainAxisAlignment
                                                          //           .spaceAround,
                                                          //   children: [
                                                          //     Expanded(
                                                          //       child: const Text(
                                                          //         "Buyer Name",
                                                          //         style: TextStyle(
                                                          //             color: AppColor
                                                          //                 .black,
                                                          //             fontSize:
                                                          //                 13,
                                                          //             fontFamily:
                                                          //                 AppFont
                                                          //                     .poppinsLight),
                                                          //       ),
                                                          //     ),
                                                          //     Expanded(
                                                          //       flex: 1,
                                                          //       child: const Text(
                                                          //         "Enumeral Solutions Ltd.",
                                                          //         style: TextStyle(
                                                          //             color: AppColor
                                                          //                 .black,
                                                          //             fontSize:
                                                          //                 12,
                                                          //             fontFamily:
                                                          //                 AppFont
                                                          //                     .poppinsLight),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   height: 7,
                                                          // ),
                                                          // Divider(
                                                          //   color: AppColor.black,
                                                          // ),
                                                          // SizedBox(
                                                          //   height: 5,
                                                          // ),
                                                          // Row(
                                                          //   mainAxisAlignment:
                                                          //       MainAxisAlignment
                                                          //           .spaceAround,
                                                          //   children: [
                                                          //     Expanded(
                                                          //       child: const Text(
                                                          //         "Contact Number",
                                                          //         style: TextStyle(
                                                          //             color: AppColor
                                                          //                 .black,
                                                          //             fontSize:
                                                          //                 13,
                                                          //             fontFamily:
                                                          //                 AppFont
                                                          //                     .poppinsLight),
                                                          //       ),
                                                          //     ),
                                                          //     Expanded(
                                                          //       flex: 1,
                                                          //       child: const Text(
                                                          //         "+234 09-461-4000",
                                                          //         style: TextStyle(
                                                          //             color: AppColor
                                                          //                 .black,
                                                          //             fontSize:
                                                          //                 12,
                                                          //             fontFamily:
                                                          //                 AppFont
                                                          //                     .poppinsLight),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   height: 7,
                                                          // ),
                                                          // Divider(
                                                          //   color: AppColor.black,
                                                          // ),
                                                          // SizedBox(
                                                          //   height: 5,
                                                          // ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Collection Date",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      13,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  "${controller.getWasteVerifyCollectionListModel!.data[index].collectedDate}",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                      12,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsLight),
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
                                                  left: 25,
                                                  top: 2,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 4,
                                                          left: 11,
                                                          right: 11,
                                                          bottom: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                          color: AppColor
                                                              .greenMedium1),
                                                      child: Text(
                                                        '${controller.getWasteVerifyCollectionListModel!.data[index].validation!.toUpperCase()}',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                            AppColor.green),
                                                      )),
                                                ),
                                              ])),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
    );
  }
}
