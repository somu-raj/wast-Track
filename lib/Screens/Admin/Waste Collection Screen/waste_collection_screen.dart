import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Vendor Staff/Vendor Staff Waste Collected/waste_collected_controller.dart';

class WastCollectionScreen extends StatefulWidget {
  const WastCollectionScreen({super.key});

  @override
  State<WastCollectionScreen> createState() => _WastCollectionScreenState();
}

class _WastCollectionScreenState extends State<WastCollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late WasteCollectedController wasteCollectedController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
          _onScroll();
        });

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

  bool isLoadingMoreData = false;
  final ScrollController _scrollController = ScrollController();


  Future<void> _fetchData() async {
    int currentDataLength = wasteCollectedController.getWasteCollectionListModel?.data.length??0;

    if (!isLoadingMoreData && wasteCollectedController.getWasteCollectionListModel?.data.length != wasteCollectedController?.getWasteCollectionListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
      wasteCollectedController.getVendorStaffCollectionApi(context, "1", '$limit','').then(
              (value){
            //debugPrint(getVendorRequestController.getVendorRequestModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
     // _fetchData();
    }
  }

  bool isButtonSelected = false;
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder(
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
          child: Column(children: [
            Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    onChanged: (value) async {
                      if(tabController.index == 1){
                        controller.getWasteVerifyCollectionListModel = null;
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
                //                     crossAxisAlignment: CrossAxisAlignment.start,
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
                                child:
                                controller.getWasteCollectionListModel == null ?
                                myShimmer():controller.getWasteCollectionListModel?.data.length == 0 ?
                                 Center(child: Text("no pending collected waste found !!")) :
                                ListView(
                                  children: List.generate(
                                    controller.getWasteCollectionListModel!.data.length,
                                    (index) => Column(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(top: 15),
                                              margin:
                                                  const EdgeInsets.only(bottom: 10),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
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
                                                    '${controller.getWasteCollectionListModel!.data[index].validation}',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: AppColor.green),
                                                  )),
                                            ),
                                          ],
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
                                Center(child: Text("No verified collected waste found !!")) :

                                
                                ListView(
                                  children: List.generate(
                                      controller.getWasteVerifyCollectionListModel!.data.length,
                                      (index) => Column(
                                        children: [
                                          Stack(
                                              clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.only(top: 15),
                                                      margin: const EdgeInsets.only(
                                                          bottom: 10),
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
                                                      left: 10,
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
                                                  ]),
                                          // if(index == (wasteCollectedController?.getWasteCollectionListModel?.data.length??0)-1  && isLoadingMoreData && (wasteCollectedController?.getWasteCollectionListModel?.data.length != wasteCollectedController?.getWasteCollectionListModel?.pagination?.totalItems))
                                          //   Padding(
                                          //     padding: const EdgeInsets.all(8.0),
                                          //     child: CircularProgressIndicator(color:AppColor.green),
                                          //   )
                                        ],
                                      )),
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
