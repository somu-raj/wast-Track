import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Vendor/Vendor%20Waste%20Management%20Controller/vendoe_waste_managemet_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Vendor Staff/Vendor Staff Waste Collected/waste_collected_controller.dart';
import '../../../Utils/Components/myShimmer.dart';

class VendorWasteManagement extends StatefulWidget {
  const VendorWasteManagement({super.key});

  @override
  State<VendorWasteManagement> createState() => _VendorWasteManagementState();
}

class _VendorWasteManagementState extends State<VendorWasteManagement> {
  bool isButtonSelected = false;
  final controller1 = Get.put(VendorWasteManagementController());

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  bool isLoadingMoreData = false;
  final ScrollController _scrollController = ScrollController();

  WasteCollectedController? wasteCollectedController;

  Future<void> _fetchData() async {
    int currentDataLength = wasteCollectedController?.getVendorStaffCollectionListModel?.data.length??0;

    if (!isLoadingMoreData && wasteCollectedController?.getVendorStaffCollectionListModel?.data.length != wasteCollectedController?.getVendorStaffCollectionListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
      wasteCollectedController?.getVendorStaffCollectionApi(context, "1", '$limit','').then(
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
      _fetchData();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WasteCollectedController(context: context),
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomSearchTextField(
                        controller: _searchController,
                        onChanged: (value){
                          controller.getVendorStaffCollectionApi(context, "1", "10",value);
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
                    //                             Text('Buyer Address'),
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
                    //         border: Border.all(
                    //             color: AppColor.green.withOpacity(0.6)),
                    //         borderRadius: BorderRadius.circular(7),
                    //       ),
                    //       child: Icon(
                    //         Icons.filter_alt_outlined,
                    //         color: AppColor.green,
                    //       )),
                    // )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child:  controller.getVendorStaffCollectionListModel?.data == null? myShimmer():controller.getVendorStaffCollectionListModel?.data.length == 0 ?
                    Center(child: Text("No waste collected !!")): ListView.builder(
                      controller: _scrollController,
                      itemCount: controller.getVendorStaffCollectionListModel?.data.length,
                      itemBuilder: (context, index) {
                        var vendorStaffCollected = controller.getVendorStaffCollectionListModel!.data[index];
                        return Obx(() {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
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
                                                "Serial Number",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${vendorStaffCollected.serialNumber}",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
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
                                                "Batch Number",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${vendorStaffCollected.batchNumber}",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
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
                                                "Collection Date",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${vendorStaffCollected.collectedDate}",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppFont.poppinsLight),
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
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     Expanded(
                                        //       child: const Text(
                                        //         "Buyer Name",
                                        //         style: TextStyle(
                                        //             color: AppColor.black,
                                        //             fontSize: 13,
                                        //             fontFamily:
                                        //                 AppFont.poppinsLight),
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       flex: 1,
                                        //       child: const Text(
                                        //         "Lorem ipsum",
                                        //         style: TextStyle(
                                        //             color: AppColor.black,
                                        //             fontSize: 12,
                                        //             fontFamily:
                                        //                 AppFont.poppinsLight),
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
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     Expanded(
                                        //       child: const Text(
                                        //         "Buyer Address",
                                        //         style: TextStyle(
                                        //             color: AppColor.black,
                                        //             fontSize: 13,
                                        //             fontFamily:
                                        //                 AppFont.poppinsLight),
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       flex: 1,
                                        //       child: const Text(
                                        //         "abc area, xyz city",
                                        //         style: TextStyle(
                                        //             color: AppColor.black,
                                        //             fontSize: 12,
                                        //             fontFamily:
                                        //                 AppFont.poppinsLight),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller1.isShowVisible.isFalse,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Column(
                                            children: [
                                              Text(
                                                "Are you sure you want to Remove this Serial?",
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
                                                        builder: (BuildContext
                                                            context) {
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 1),
                                                              () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          });

                                                          return CupertinoAlertDialog(
                                                            title: Row(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
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
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    " Serial Removed Successfully",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
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
                                                              color:
                                                                  Colors.white),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Remove Serial',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.red,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if(index == (wasteCollectedController?.getVendorStaffCollectionListModel?.data.length??0)-1  && isLoadingMoreData && (wasteCollectedController?.getVendorStaffCollectionListModel?.data.length != wasteCollectedController?.getVendorStaffCollectionListModel?.pagination?.totalItems))
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(color:AppColor.green),
                                )

                            ],
                          );
                        });
                      },
                    ),
                  ),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.green,
          onPressed: () {
            Get.dialog(
              AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload Nylon Collected",
                            style: TextStyle(
                                fontSize: 15, fontFamily: AppFont.poppinsBold),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.close,
                              size: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Enter Serial Manually",
                        style: TextStyle(fontSize: 14, color: AppColor.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: 'Enter Serial Number',
                        hintStyle: TextStyle(
                            fontSize: 12,
                            color: AppColor.black.withOpacity(0.4),
                            fontFamily: AppFont.poppinsSemiBold),
                        prefixIcon: Icon(
                          Icons.keyboard_alt_outlined,
                          color: AppColor.green,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                controller1.ShowVisibility();
                              });

                              return CupertinoAlertDialog(
                                title: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColor.green,
                                      ),
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        " Serial added  Successfully",
                                        style: TextStyle(
                                            fontSize: 15, color: AppColor.green),
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
                              left: 20, right: 20, bottom: 10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Serial',
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsLight,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                insetPadding: const EdgeInsets.all(10),
              ),
            );
          },
          child: const Icon(Icons.upload_file),
        ),
      ),
    );
  }
}
