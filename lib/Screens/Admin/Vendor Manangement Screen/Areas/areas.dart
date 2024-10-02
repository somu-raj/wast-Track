import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../../../Utils/images/images.dart';
import '../../../../Conrollers/Admin/Vender Mangagement Controller/add_area_controller.dart';
import '../../../../Models/Vendor Management Model/Area Model/get_area_model.dart';
import '../../../../Utils/Components/Search Text Field/custom_search_text_field.dart';
import 'add_area.dart';

class Areas extends StatefulWidget {
  final GetAreaModel? getAreaModel;

  const Areas({super.key, this.getAreaModel});

  @override
  State<Areas> createState() => _AreasState();
}

class _AreasState extends State<Areas> with SingleTickerProviderStateMixin {
  late TabController tabController;
  AddAreaController? addAreaController;
  bool isGeneratedArea = true;
  bool isLoadingMoreData = false;
  String status = "0";
  final ScrollController _scrollController = ScrollController();
  final areaUpdateC =  TextEditingController();
  Future<void> _fetchData() async {
    int currentDataLength = addAreaController?.getAreaModel?.data.length??0;
    if (!isLoadingMoreData && addAreaController?.getAreaModel?.data.length != addAreaController?.getAreaModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
      status = addAreaController!.isPendingRequest? "0":"2";
      addAreaController?.getAreaApi(context,"1", '$limit','').then(
              (value){
            debugPrint(addAreaController?.getAreaModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      debugPrint("maxScrollExtent called!!");
      _fetchData();
    }
  }
  @override
  void initState() {
    super.initState();
    addAreaController = AddAreaController(context: context);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging == false) {
        if (tabController.index == 1) {
          addAreaController?.isGeneratedArea = false;
          // addAreaController?.getAreaApi(context, "1", "10", "");
        } else {
          addAreaController?.isGeneratedArea = true;
          // addAreaController?.getAreaApi(context, "1", "10", "");
        }
      }
      status = addAreaController!.isGeneratedArea ? "0" : "1";
    });
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );


  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool isButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:addAreaController ,
      builder: (controller) =>
          Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColor.green,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddArea()));
                },
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
                                Tab(text: 'Assigned'),
                                Tab(text: 'Not Assigned'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CustomSearchTextField(
                              onChanged: (value){
                                debugPrint(value);
                                controller.getAreaApi(context, "1","10",value);
                              },
                              hintText: 'Search  here...',
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.grey1.withOpacity(0.5)),
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
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Padding(
                          //                         padding:
                          //                             const EdgeInsets.all(20.0),
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
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Text('Area'),
                          //                             const SizedBox(
                          //                               width: 10,
                          //                             ),
                          //                             CustomRadioButton(
                          //                               isSelected:
                          //                                   isButtonSelected,
                          //                               onChanged: (value) {
                          //                                 setState(() {
                          //                                   isButtonSelected =
                          //                                       value;
                          //                                 });
                          //                               },
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       Divider(
                          //                         color: Colors.black
                          //                             .withOpacity(0.59),
                          //                       ),
                          //                       Padding(
                          //                         padding: const EdgeInsets.only(
                          //                             left: 20,
                          //                             right: 20,
                          //                             top: 10,
                          //                             bottom: 10),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Text('Company Name'),
                          //                             const SizedBox(
                          //                               width: 10,
                          //                             ),
                          //                             CustomRadioButton(
                          //                               isSelected:
                          //                                   isButtonSelected,
                          //                               onChanged: (value) {
                          //                                 setState(() {
                          //                                   isButtonSelected =
                          //                                       value;
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
                                      child:controller.getAreaModel?.data == null ?myShimmer():
                                      !(controller.getAreaModel!.data.any((element) => element.status == 1))?
                                      Center(
                                        child: Text("No Assigned Area Available"),
                                      ):
                                      ListView.builder(
                                        controller: _scrollController,
                                        itemCount:
                                        controller.getAreaModel?.data.length,
                                        itemBuilder: (context, index) {
                                          var areaList = controller
                                              .getAreaModel?.data[index];
                                          return
                                            controller.getAreaModel?.data[index].status == 1?

                                            Column(
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      margin: const EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Card(
                                                        elevation: 1,
                                                        margin: EdgeInsets.zero,
                                                        shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                        clipBehavior: Clip.hardEdge,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(
                                                              15.0),
                                                          child: Column(
                                                            children: [

                                                              Row(
                                                                // crossAxisAlignment:
                                                                //     CrossAxisAlignment
                                                                //         .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  // Expanded(
                                                                  //   child: Text(
                                                                  //     "Area",
                                                                  //     style: TextStyle(
                                                                  //         color: AppColor
                                                                  //             .black,
                                                                  //         fontSize: 12,
                                                                  //         fontFamily:
                                                                  //             AppFont
                                                                  //                 .poppinsLight),
                                                                  //   ),
                                                                  // ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${areaList!.areaName}",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .black,
                                                                          fontSize: 12,
                                                                          fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      GestureDetector(
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
                                                                                      MainAxisAlignment
                                                                                          .spaceAround,
                                                                                      children: [
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: Container(
                                                                                            padding:
                                                                                            EdgeInsets.all(9),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(7),
                                                                                              color: AppColor.green,
                                                                                            ),
                                                                                            child: Text(
                                                                                              'Cancel',
                                                                                              style: TextStyle(
                                                                                                  fontFamily: AppFont
                                                                                                      .poppinsLight,
                                                                                                  fontSize: 15,
                                                                                                  color:
                                                                                                  Colors.white),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            controller.deleteAreaApi(areaList.id ?? "").then((value){controller.getAreaApi(context,"1", "10","" );});
                                                                                            Navigator.pop(context);

                                                                                          },
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.only(
                                                                                                left: 20,
                                                                                                right: 20,
                                                                                                bottom: 10,
                                                                                                top: 10),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(7),
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
                                                                        child: Image.asset(
                                                                          AppImages.delete,
                                                                          height: 50,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          Get.dialog(
                                                                            AlertDialog(
                                                                              content: SizedBox(
                                                                                width: MediaQuery.of(
                                                                                    context)
                                                                                    .size
                                                                                    .width,
                                                                                child: Column(
                                                                                  mainAxisSize:
                                                                                  MainAxisSize
                                                                                      .min,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment
                                                                                          .spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Edit Area",
                                                                                          style: TextStyle(
                                                                                              fontSize:
                                                                                              15,
                                                                                              color: AppColor
                                                                                                  .black),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () =>
                                                                                              Get.back(),
                                                                                          child: Icon(
                                                                                            Icons
                                                                                                .close,
                                                                                            size: 18,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    CupertinoTextField(
                                                                                      controller: areaUpdateC,
                                                                                      padding:
                                                                                      EdgeInsets
                                                                                          .all(
                                                                                          10),
                                                                                      prefix: Icon(
                                                                                        Icons
                                                                                            .keyboard_alt_outlined,
                                                                                        color: AppColor
                                                                                            .green,
                                                                                        size: 15,
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius:
                                                                                          BorderRadius.circular(
                                                                                              7),
                                                                                          border: Border.all(
                                                                                              color: AppColor
                                                                                                  .green)),
                                                                                      placeholder:
                                                                                      'Enter text',
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        controller.updateAreaApi(controller.getAreaModel!.data[index].id?? "", areaUpdateC.text).then((value){
                                                                                          controller.getAreaApi(context, "1", "10","");
                                                                                        } );

                                                                                      },
                                                                                      child:
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: 20,
                                                                                            right: 20,
                                                                                            bottom:
                                                                                            10,
                                                                                            top: 10),
                                                                                        decoration:
                                                                                        BoxDecoration(
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(7),
                                                                                          color: AppColor
                                                                                              .green,
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            'Edit Area',
                                                                                            style: TextStyle(
                                                                                                fontFamily: AppFont
                                                                                                    .poppinsLight,
                                                                                                fontSize:
                                                                                                15,
                                                                                                color:
                                                                                                Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              insetPadding:
                                                                              const EdgeInsets
                                                                                  .all(10),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          child: Image.asset(
                                                                            AppImages.edit,
                                                                            height: 50,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),

                                                              // Divider(
                                                              //   color: AppColor.black,
                                                              // ),
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
                                                              //         "Company Name",
                                                              //         style: TextStyle(
                                                              //             color: AppColor
                                                              //                 .black,
                                                              //             fontSize: 12,
                                                              //             fontFamily:
                                                              //                 AppFont
                                                              //                     .poppinsLight),
                                                              //       ),
                                                              //     ),
                                                              //     Expanded(
                                                              //       flex: 1,
                                                              //       child: const Text(
                                                              //         "Enumeral Waste Solutions",
                                                              //         style: TextStyle(
                                                              //             color: AppColor
                                                              //                 .black,
                                                              //             fontSize: 12,
                                                              //             fontFamily:
                                                              //                 AppFont
                                                              //                     .poppinsLight),
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Positioned(
                                                    //   left: 280,
                                                    //   top: -8,
                                                    //   child: GestureDetector(
                                                    //     onTap: () {
                                                    //       controller.allAreaStateController!.AssignedVisibility(index);
                                                    //     },
                                                    //     child: Image.asset(
                                                    //       AppImages.opestion,
                                                    //       height: 50,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Positioned(
                                                    //   left: 215,
                                                    //   top: -8,
                                                    //   child: Visibility(
                                                    //     visible:
                                                    //         controller.allAreaStateController!
                                                    //                 .assignedVisibleList[
                                                    //             index],
                                                    //     child: GestureDetector(
                                                    //       onTap: () {
                                                    //         Get.dialog(
                                                    //           AlertDialog(
                                                    //             content: SizedBox(
                                                    //               width: MediaQuery.of(
                                                    //                       context)
                                                    //                   .size
                                                    //                   .width,
                                                    //               child: Column(
                                                    //                 mainAxisSize:
                                                    //                     MainAxisSize
                                                    //                         .min,
                                                    //                 children: [
                                                    //                   Row(
                                                    //                     mainAxisAlignment:
                                                    //                         MainAxisAlignment
                                                    //                             .spaceBetween,
                                                    //                     children: [
                                                    //                       Text(
                                                    //                         "Edit Area",
                                                    //                         style: TextStyle(
                                                    //                             fontSize:
                                                    //                                 15,
                                                    //                             color: AppColor
                                                    //                                 .black),
                                                    //                       ),
                                                    //                       GestureDetector(
                                                    //                         onTap: () =>
                                                    //                             Get.back(),
                                                    //                         child: Icon(
                                                    //                           Icons
                                                    //                               .close,
                                                    //                           size: 18,
                                                    //                         ),
                                                    //                       )
                                                    //                     ],
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   CupertinoTextField(
                                                    //                     controller: areaUpdateC,
                                                    //                     padding:
                                                    //                         EdgeInsets
                                                    //                             .all(
                                                    //                                 10),
                                                    //                     prefix: Icon(
                                                    //                       Icons
                                                    //                           .keyboard_alt_outlined,
                                                    //                       color: AppColor
                                                    //                           .green,
                                                    //                       size: 15,
                                                    //                     ),
                                                    //                     decoration: BoxDecoration(
                                                    //                         borderRadius:
                                                    //                             BorderRadius.circular(
                                                    //                                 7),
                                                    //                         border: Border.all(
                                                    //                             color: AppColor
                                                    //                                 .green)),
                                                    //                     placeholder:
                                                    //                         'Enter text',
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   GestureDetector(
                                                    //                     onTap: () {
                                                    //                       controller.updateAreaApi(controller.getAreaModel!.data[index].id?? "", areaUpdateC.text).then((value){
                                                    //                         controller.getAreaApi(context, "1", "10","");
                                                    //                       } );
                                                    //
                                                    //                     },
                                                    //                     child:
                                                    //                         Container(
                                                    //                       padding: EdgeInsets.only(
                                                    //                           left: 20,
                                                    //                           right: 20,
                                                    //                           bottom:
                                                    //                               10,
                                                    //                           top: 10),
                                                    //                       decoration:
                                                    //                           BoxDecoration(
                                                    //                         borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                         color: AppColor
                                                    //                             .green,
                                                    //                       ),
                                                    //                       child: Center(
                                                    //                         child: Text(
                                                    //                           'Edit Area',
                                                    //                           style: TextStyle(
                                                    //                               fontFamily: AppFont
                                                    //                                   .poppinsLight,
                                                    //                               fontSize:
                                                    //                                   15,
                                                    //                               color:
                                                    //                                   Colors.white),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //             insetPadding:
                                                    //                 const EdgeInsets
                                                    //                     .all(10),
                                                    //           ),
                                                    //         );
                                                    //       },
                                                    //       child: Container(
                                                    //         child: Image.asset(
                                                    //           AppImages.edit,
                                                    //           height: 50,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Positioned(
                                                    //   left: 247,
                                                    //   top: -10,
                                                    //   child: Visibility(
                                                    //     visible:
                                                    //         controller.allAreaStateController!
                                                    //                 .assignedVisibleList[
                                                    //             index],
                                                    //     child: GestureDetector(
                                                    //       onTap: () {
                                                    //         showDialog(
                                                    //           context: context,
                                                    //           builder: (BuildContext context) {
                                                    //             return CupertinoAlertDialog(
                                                    //               title: Column(
                                                    //                 children: [
                                                    //                   Text(
                                                    //                     "Are you sure you want to Delete this User?",
                                                    //                     style: TextStyle(
                                                    //                         fontSize: 15,
                                                    //                         color: AppColor.black),
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   Row(
                                                    //                     mainAxisAlignment:
                                                    //                     MainAxisAlignment
                                                    //                         .spaceAround,
                                                    //                     children: [
                                                    //                       GestureDetector(
                                                    //                         onTap: () {
                                                    //                           Navigator.pop(context);
                                                    //                         },
                                                    //                         child: Container(
                                                    //                           padding:
                                                    //                           EdgeInsets.all(9),
                                                    //                           decoration: BoxDecoration(
                                                    //                             borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                             color: AppColor.green,
                                                    //                           ),
                                                    //                           child: Text(
                                                    //                             'Cancel',
                                                    //                             style: TextStyle(
                                                    //                                 fontFamily: AppFont
                                                    //                                     .poppinsLight,
                                                    //                                 fontSize: 15,
                                                    //                                 color:
                                                    //                                 Colors.white),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                       GestureDetector(
                                                    //                         onTap: () {
                                                    //                           controller.deleteAreaApi(areaList.id ?? "").then((value){controller.getAreaApi(context,"1", "10","" );});
                                                    //                           Navigator.pop(context);
                                                    //
                                                    //                         },
                                                    //                         child: Container(
                                                    //                           padding: EdgeInsets.only(
                                                    //                               left: 20,
                                                    //                               right: 20,
                                                    //                               bottom: 10,
                                                    //                               top: 10),
                                                    //                           decoration: BoxDecoration(
                                                    //                             borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                             color: AppColor.green,
                                                    //                           ),
                                                    //                           child: Center(
                                                    //                             child: Text(
                                                    //                               'yes',
                                                    //                               style: TextStyle(
                                                    //                                   fontFamily: AppFont
                                                    //                                       .poppinsLight,
                                                    //                                   fontSize: 15,
                                                    //                                   color:
                                                    //                                   Colors.white),
                                                    //                             ),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                 ],
                                                    //               ), // show pop-up
                                                    //             );
                                                    //           },
                                                    //         );
                                                    //
                                                    //       },
                                                    //       child: Container(
                                                    //         child: Image.asset(
                                                    //           AppImages.delete,
                                                    //           height: 50,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                if(index == (controller.getAreaModel?.data.length??0)-1  && isLoadingMoreData && (controller.getAreaModel?.data.length != controller.getAreaModel?.pagination?.totalItems))
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: CircularProgressIndicator(color:AppColor.green),
                                                  )
                                              ],
                                            ):

                                            const SizedBox.shrink();
                                        },
                                      )),
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
                                      child:controller.getAreaModel?.data == null ?myShimmer():
                                      !(controller.getAreaModel!.data.any((element) => element.status == 0))?
                                      Center(
                                        child: Text("Not Assigned Area not Found"),
                                      ):
                                      ListView.builder(
                                        controller: _scrollController,
                                        itemCount:
                                        controller.getAreaModel?.data.length,
                                        itemBuilder: (context, index) {
                                          var areaList = controller
                                              .getAreaModel?.data[index];
                                          return
                                            controller.getAreaModel!.data[index].status == 0?
                                            Column(
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      margin: const EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Card(
                                                        elevation: 1,
                                                        margin: EdgeInsets.zero,
                                                        shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                        clipBehavior: Clip.hardEdge,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(
                                                              15.0),
                                                          child: Column(
                                                            children: [

                                                              Row(
                                                                // crossAxisAlignment:
                                                                //     CrossAxisAlignment
                                                                //         .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  // Expanded(
                                                                  //   child: Text(
                                                                  //     "Area",
                                                                  //     style: TextStyle(
                                                                  //         color: AppColor
                                                                  //             .black,
                                                                  //         fontSize: 12,
                                                                  //         fontFamily:
                                                                  //             AppFont
                                                                  //                 .poppinsLight),
                                                                  //   ),
                                                                  // ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${areaList!.areaName}",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .black,
                                                                          fontSize: 12,
                                                                          fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      GestureDetector(
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
                                                                                      MainAxisAlignment
                                                                                          .spaceAround,
                                                                                      children: [
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: Container(
                                                                                            padding:
                                                                                            EdgeInsets.all(9),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(7),
                                                                                              color: AppColor.green,
                                                                                            ),
                                                                                            child: Text(
                                                                                              'Cancel',
                                                                                              style: TextStyle(
                                                                                                  fontFamily: AppFont
                                                                                                      .poppinsLight,
                                                                                                  fontSize: 15,
                                                                                                  color:
                                                                                                  Colors.white),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            controller.deleteAreaApi(areaList.id ?? "").then((value){controller.getAreaApi(context,"1", "10","" );});
                                                                                            Navigator.pop(context);

                                                                                          },
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.only(
                                                                                                left: 20,
                                                                                                right: 20,
                                                                                                bottom: 10,
                                                                                                top: 10),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius:
                                                                                              BorderRadius
                                                                                                  .circular(7),
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
                                                                        child: Image.asset(
                                                                          AppImages.delete,
                                                                          height: 50,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          Get.dialog(
                                                                            AlertDialog(
                                                                              content: SizedBox(
                                                                                width: MediaQuery.of(
                                                                                    context)
                                                                                    .size
                                                                                    .width,
                                                                                child: Column(
                                                                                  mainAxisSize:
                                                                                  MainAxisSize
                                                                                      .min,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment
                                                                                          .spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Edit Area",
                                                                                          style: TextStyle(
                                                                                              fontSize:
                                                                                              15,
                                                                                              color: AppColor
                                                                                                  .black),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () =>
                                                                                              Get.back(),
                                                                                          child: Icon(
                                                                                            Icons
                                                                                                .close,
                                                                                            size: 18,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    CupertinoTextField(
                                                                                      controller: areaUpdateC,
                                                                                      padding:
                                                                                      EdgeInsets
                                                                                          .all(
                                                                                          10),
                                                                                      prefix: Icon(
                                                                                        Icons
                                                                                            .keyboard_alt_outlined,
                                                                                        color: AppColor
                                                                                            .green,
                                                                                        size: 15,
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius:
                                                                                          BorderRadius.circular(
                                                                                              7),
                                                                                          border: Border.all(
                                                                                              color: AppColor
                                                                                                  .green)),
                                                                                      placeholder:
                                                                                      'Enter text',
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        controller.updateAreaApi(controller.getAreaModel!.data[index].id?? "", areaUpdateC.text).then((value){
                                                                                          controller.getAreaApi(context, "1", "10","");
                                                                                        } );

                                                                                      },
                                                                                      child:
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: 20,
                                                                                            right: 20,
                                                                                            bottom:
                                                                                            10,
                                                                                            top: 10),
                                                                                        decoration:
                                                                                        BoxDecoration(
                                                                                          borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(7),
                                                                                          color: AppColor
                                                                                              .green,
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            'Edit Area',
                                                                                            style: TextStyle(
                                                                                                fontFamily: AppFont
                                                                                                    .poppinsLight,
                                                                                                fontSize:
                                                                                                15,
                                                                                                color:
                                                                                                Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              insetPadding:
                                                                              const EdgeInsets
                                                                                  .all(10),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          child: Image.asset(
                                                                            AppImages.edit,
                                                                            height: 50,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),

                                                                ],
                                                              ),

                                                              // Divider(
                                                              //   color: AppColor.black,
                                                              // ),
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
                                                              //         "Company Name",
                                                              //         style: TextStyle(
                                                              //             color: AppColor
                                                              //                 .black,
                                                              //             fontSize: 12,
                                                              //             fontFamily:
                                                              //                 AppFont
                                                              //                     .poppinsLight),
                                                              //       ),
                                                              //     ),
                                                              //     Expanded(
                                                              //       flex: 1,
                                                              //       child: const Text(
                                                              //         "Enumeral Waste Solutions",
                                                              //         style: TextStyle(
                                                              //             color: AppColor
                                                              //                 .black,
                                                              //             fontSize: 12,
                                                              //             fontFamily:
                                                              //                 AppFont
                                                              //                     .poppinsLight),
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Positioned(
                                                    //   left: 280,
                                                    //   top: -8,
                                                    //   child: GestureDetector(
                                                    //     onTap: () {
                                                    //       controller.allAreaStateController!.AssignedVisibility(index);
                                                    //     },
                                                    //     child: Image.asset(
                                                    //       AppImages.opestion,
                                                    //       height: 50,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Positioned(
                                                    //   left: 215,
                                                    //   top: -8,
                                                    //   child: Visibility(
                                                    //     visible:
                                                    //         controller.allAreaStateController!
                                                    //                 .assignedVisibleList[
                                                    //             index],
                                                    //     child: GestureDetector(
                                                    //       onTap: () {
                                                    //         Get.dialog(
                                                    //           AlertDialog(
                                                    //             content: SizedBox(
                                                    //               width: MediaQuery.of(
                                                    //                       context)
                                                    //                   .size
                                                    //                   .width,
                                                    //               child: Column(
                                                    //                 mainAxisSize:
                                                    //                     MainAxisSize
                                                    //                         .min,
                                                    //                 children: [
                                                    //                   Row(
                                                    //                     mainAxisAlignment:
                                                    //                         MainAxisAlignment
                                                    //                             .spaceBetween,
                                                    //                     children: [
                                                    //                       Text(
                                                    //                         "Edit Area",
                                                    //                         style: TextStyle(
                                                    //                             fontSize:
                                                    //                                 15,
                                                    //                             color: AppColor
                                                    //                                 .black),
                                                    //                       ),
                                                    //                       GestureDetector(
                                                    //                         onTap: () =>
                                                    //                             Get.back(),
                                                    //                         child: Icon(
                                                    //                           Icons
                                                    //                               .close,
                                                    //                           size: 18,
                                                    //                         ),
                                                    //                       )
                                                    //                     ],
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   CupertinoTextField(
                                                    //                     controller: areaUpdateC,
                                                    //                     padding:
                                                    //                         EdgeInsets
                                                    //                             .all(
                                                    //                                 10),
                                                    //                     prefix: Icon(
                                                    //                       Icons
                                                    //                           .keyboard_alt_outlined,
                                                    //                       color: AppColor
                                                    //                           .green,
                                                    //                       size: 15,
                                                    //                     ),
                                                    //                     decoration: BoxDecoration(
                                                    //                         borderRadius:
                                                    //                             BorderRadius.circular(
                                                    //                                 7),
                                                    //                         border: Border.all(
                                                    //                             color: AppColor
                                                    //                                 .green)),
                                                    //                     placeholder:
                                                    //                         'Enter text',
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   GestureDetector(
                                                    //                     onTap: () {
                                                    //                       controller.updateAreaApi(controller.getAreaModel!.data[index].id?? "", areaUpdateC.text).then((value){
                                                    //                         controller.getAreaApi(context, "1", "10","");
                                                    //                       } );
                                                    //
                                                    //                     },
                                                    //                     child:
                                                    //                         Container(
                                                    //                       padding: EdgeInsets.only(
                                                    //                           left: 20,
                                                    //                           right: 20,
                                                    //                           bottom:
                                                    //                               10,
                                                    //                           top: 10),
                                                    //                       decoration:
                                                    //                           BoxDecoration(
                                                    //                         borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                         color: AppColor
                                                    //                             .green,
                                                    //                       ),
                                                    //                       child: Center(
                                                    //                         child: Text(
                                                    //                           'Edit Area',
                                                    //                           style: TextStyle(
                                                    //                               fontFamily: AppFont
                                                    //                                   .poppinsLight,
                                                    //                               fontSize:
                                                    //                                   15,
                                                    //                               color:
                                                    //                                   Colors.white),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //             insetPadding:
                                                    //                 const EdgeInsets
                                                    //                     .all(10),
                                                    //           ),
                                                    //         );
                                                    //       },
                                                    //       child: Container(
                                                    //         child: Image.asset(
                                                    //           AppImages.edit,
                                                    //           height: 50,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Positioned(
                                                    //   left: 247,
                                                    //   top: -10,
                                                    //   child: Visibility(
                                                    //     visible:
                                                    //         controller.allAreaStateController!
                                                    //                 .assignedVisibleList[
                                                    //             index],
                                                    //     child: GestureDetector(
                                                    //       onTap: () {
                                                    //         showDialog(
                                                    //           context: context,
                                                    //           builder: (BuildContext context) {
                                                    //             return CupertinoAlertDialog(
                                                    //               title: Column(
                                                    //                 children: [
                                                    //                   Text(
                                                    //                     "Are you sure you want to Delete this User?",
                                                    //                     style: TextStyle(
                                                    //                         fontSize: 15,
                                                    //                         color: AppColor.black),
                                                    //                   ),
                                                    //                   SizedBox(
                                                    //                     height: 10,
                                                    //                   ),
                                                    //                   Row(
                                                    //                     mainAxisAlignment:
                                                    //                     MainAxisAlignment
                                                    //                         .spaceAround,
                                                    //                     children: [
                                                    //                       GestureDetector(
                                                    //                         onTap: () {
                                                    //                           Navigator.pop(context);
                                                    //                         },
                                                    //                         child: Container(
                                                    //                           padding:
                                                    //                           EdgeInsets.all(9),
                                                    //                           decoration: BoxDecoration(
                                                    //                             borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                             color: AppColor.green,
                                                    //                           ),
                                                    //                           child: Text(
                                                    //                             'Cancel',
                                                    //                             style: TextStyle(
                                                    //                                 fontFamily: AppFont
                                                    //                                     .poppinsLight,
                                                    //                                 fontSize: 15,
                                                    //                                 color:
                                                    //                                 Colors.white),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                       GestureDetector(
                                                    //                         onTap: () {
                                                    //                           controller.deleteAreaApi(areaList.id ?? "").then((value){controller.getAreaApi(context,"1", "10","" );});
                                                    //                           Navigator.pop(context);
                                                    //
                                                    //                         },
                                                    //                         child: Container(
                                                    //                           padding: EdgeInsets.only(
                                                    //                               left: 20,
                                                    //                               right: 20,
                                                    //                               bottom: 10,
                                                    //                               top: 10),
                                                    //                           decoration: BoxDecoration(
                                                    //                             borderRadius:
                                                    //                             BorderRadius
                                                    //                                 .circular(7),
                                                    //                             color: AppColor.green,
                                                    //                           ),
                                                    //                           child: Center(
                                                    //                             child: Text(
                                                    //                               'yes',
                                                    //                               style: TextStyle(
                                                    //                                   fontFamily: AppFont
                                                    //                                       .poppinsLight,
                                                    //                                   fontSize: 15,
                                                    //                                   color:
                                                    //                                   Colors.white),
                                                    //                             ),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                 ],
                                                    //               ), // show pop-up
                                                    //             );
                                                    //           },
                                                    //         );
                                                    //
                                                    //       },
                                                    //       child: Container(
                                                    //         child: Image.asset(
                                                    //           AppImages.delete,
                                                    //           height: 50,
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                if(index == (controller.getAreaModel?.data.length??0)-1  && isLoadingMoreData && (controller.getAreaModel?.data.length != controller.getAreaModel?.pagination?.totalItems))
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: CircularProgressIndicator(color:AppColor.green),
                                                  )
                                              ],
                                            ):const SizedBox.shrink();
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
