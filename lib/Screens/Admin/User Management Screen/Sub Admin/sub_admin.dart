import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/sub_admin_controller.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Sub%20Admin/Widgets/sub_admin_edit.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../Ecoblue Sub Admin/Widgets/ecoblue_sub_admin_details.dart';
import 'Widgets/sub_admin_details.dart';

class SubAdmin extends StatefulWidget {
  const SubAdmin({super.key});

  @override
  State<SubAdmin> createState() => _SubAdminState();
}

class _SubAdminState extends State<SubAdmin> {
  final TextEditingController _searchController = TextEditingController();
  bool isButtonSelected = false;
  bool isLoadingMoreData = false;
  ScrollController _scrollController = ScrollController();
  late SubAdminController subAdminController;

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    int currentDataLength = subAdminController.model?.data.length ?? 0;

    if (!isLoadingMoreData &&
        subAdminController.model?.data.length !=
            subAdminController.model?.pagination?.totalItems) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      subAdminController
          .getSubAdminApi(context, "1", "$limit", _searchController.text)
          .then((value) {
        debugPrint(subAdminController.model?.data.length.toString());
        setState(() {
          isLoadingMoreData = false;
        });
      });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subAdminController = SubAdminController(context: context);
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: subAdminController,
        builder: (controller) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.green,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppScreen.subAdminAddScreen,
                );
              },
              child: const Icon(Icons.add),
            ),
            body: controller.model == null
                ? myShimmer()
                : Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: CustomSearchTextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  subAdminController.getSubAdminApi(
                                      context, "1", "10", value);
                                  // filterSearchResults(value); // Call the filter method when text changes
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
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Padding(
                            //                       padding:
                            //                           const EdgeInsets.all(20.0),
                            //                       child: Row(
                            //                         children: [
                            //                           SvgPicture.asset(
                            //                             AppImages.union,
                            //                             height: 15,
                            //                           ),
                            //                           const SizedBox(
                            //                             width: 10,
                            //                           ),
                            //                           const Text(
                            //                             "Filter By",
                            //                             style: TextStyle(
                            //                                 fontFamily: AppFont
                            //                                     .poppinsSemiBold),
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 20,
                            //                           right: 20,
                            //                           top: 10,
                            //                           bottom: 10),
                            //                       child: Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           Text('Name'),
                            //                           const SizedBox(
                            //                             width: 10,
                            //                           ),
                            //                           CustomRadioButton(
                            //                             isSelected:
                            //                                 isButtonSelected,
                            //                             onChanged: (value) {
                            //                               setState(() {
                            //                                 isButtonSelected =
                            //                                     value;
                            //                               });
                            //                             },
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     Divider(
                            //                       color: Colors.black
                            //                           .withOpacity(0.59),
                            //                     ),
                            //                     Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 20,
                            //                           right: 20,
                            //                           top: 10,
                            //                           bottom: 10),
                            //                       child: Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           Text('Email'),
                            //                           const SizedBox(
                            //                             width: 10,
                            //                           ),
                            //                           CustomRadioButton(
                            //                             isSelected:
                            //                                 isButtonSelected,
                            //                             onChanged: (value) {
                            //                               setState(() {
                            //                                 isButtonSelected =
                            //                                     value;
                            //                               });
                            //                             },
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     Divider(
                            //                       color: Colors.black
                            //                           .withOpacity(0.59),
                            //                     ),
                            //                     Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 20,
                            //                           right: 20,
                            //                           top: 10,
                            //                           bottom: 10),
                            //                       child: Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           Text('Date Added'),
                            //                           const SizedBox(
                            //                             width: 10,
                            //                           ),
                            //                           CustomRadioButton(
                            //                             isSelected:
                            //                                 isButtonSelected,
                            //                             onChanged: (value) {
                            //                               setState(() {
                            //                                 isButtonSelected =
                            //                                     value;
                            //                               });
                            //                             },
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     const SizedBox(
                            //                       height: 10,
                            //                     ),
                            //                   ],
                            //                 )
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
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: controller.model?.data == null
                                ? myShimmer() :controller.model?.data.length == 0? Center(child: Text("No sub admin List found !!")):
                                 ListView.builder(
                                    controller: _scrollController,
                                    itemCount:
                                        controller.model?.data.length ?? 15,
                                    itemBuilder: (context, index) {
                                      var subAdmin = controller.model?.data[index];
                                      String apiDateString =
                                          "${controller.model?.data[index].createdAt}";
                                      String formattedDate =
                                          formatDate(apiDateString);
                                      return Obx(
                                        () {
                                          return Column(
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
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
                                                                  child:
                                                                      const Text(
                                                                    "Name",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            AppFont.poppinsLight),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${subAdmin?.firstName}",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            AppFont.poppinsLight),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: AppColor
                                                                  .black,
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
                                                                  child:
                                                                      const Text(
                                                                    "Email",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            AppFont.poppinsLight),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "${subAdmin?.email}",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            AppFont.poppinsLight),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: AppColor
                                                                  .black,
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
                                                                  child:
                                                                      const Text(
                                                                    "Date Added",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            AppFont.poppinsLight),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "${formattedDate}",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            'PoppinsLight',
                                                                      ),
                                                                    )),
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
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8,
                                                    top: -8,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        //controller.model?.data[index];
                                                        subAdminController
                                                            .subAdminVisibilityController
                                                            .toggleVisibility(
                                                                index);
                                                      },
                                                      child: Image.asset(
                                                        AppImages.opestion,
                                                        height: 50,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 199,
                                                    top: -8,
                                                    child: Visibility(
                                                      visible: subAdminController
                                                          .subAdminVisibilityController
                                                          .areOptionVisibleList[index],
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SubAdminDetails(subAdminList:subAdmin)));
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
                                                      visible: subAdminController
                                                          .subAdminVisibilityController
                                                          .areOptionVisibleList[index],
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SubAdminEditScreen(
                                                                model:
                                                                    controller
                                                                        .model,
                                                                // Assuming controller.subAdmin is your model
                                                                index:
                                                                    index, // Assuming index is the index you want to edit
                                                              ),
                                                            ),
                                                          ).then((value) {
                                                            controller
                                                                .getSubAdminApi(
                                                                    context,
                                                                    "1",
                                                                    "10",
                                                                    "");
                                                          });
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
                                                    top: -10,
                                                    child: Visibility(
                                                      visible: subAdminController
                                                          .subAdminVisibilityController
                                                          .areOptionVisibleList[index],
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return CupertinoAlertDialog(
                                                                title: Column(
                                                                  children: [
                                                                    Text(
                                                                      "Are you sure you want to Delete this User?",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              AppColor.black),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(9),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(7),
                                                                              color: AppColor.green,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              'Cancel',
                                                                              style: TextStyle(fontFamily: AppFont.poppinsLight, fontSize: 15, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.deleteSubAdminApi(subAdmin!.id.toString());
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding: EdgeInsets.only(
                                                                                left: 20,
                                                                                right: 20,
                                                                                bottom: 10,
                                                                                top: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(7),
                                                                              color: AppColor.green,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'yes',
                                                                                style: TextStyle(fontFamily: AppFont.poppinsLight, fontSize: 15, color: Colors.white),
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
                                                ],
                                              ),
                                              if (index ==
                                                      (subAdminController
                                                                  .model
                                                                  ?.data
                                                                  .length ??
                                                              0) -
                                                          1 &&
                                                  isLoadingMoreData &&
                                                  (subAdminController
                                                          .model?.data.length !=
                                                      subAdminController
                                                          .model
                                                          ?.pagination
                                                          ?.totalItems))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(color:AppColor.green),
                                                )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        )
                      ],
                    ))));
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

// ignore: must_be_immutable
