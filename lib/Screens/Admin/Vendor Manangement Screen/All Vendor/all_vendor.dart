import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/get_vendors_controller.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/All%20Vendor%20Edit/all_vendor_edit.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import 'All Vendor Details/all_vendor_details.dart';

class AllVendor extends StatefulWidget {
  const AllVendor({super.key});

  @override
  State<AllVendor> createState() => _AllVendorState();
}

class _AllVendorState extends State<AllVendor> {
  bool isButtonSelected = false;
  ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = _getVendorsController?.getVendorsModel?.data.length??0;

    if (!isLoadingMoreData && _getVendorsController?.getVendorsModel?.data.length != _getVendorsController?.getVendorsModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      _getVendorsController?.getVendorsApi(context, "1", '$limit','',"1").then(
              (value){
            debugPrint(_getVendorsController?.getVendorsModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

   GetVendorsController? _getVendorsController;

  @override
  void initState() {
    _getVendorsController = GetVendorsController(context: context);
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _getVendorsController,
      builder: (controller) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: CustomSearchTextField(
                        hintText: 'Search  here...',
                        onChanged: (value){
                          controller.getVendorsApi(context, "1", "10", value, "1");
                        },
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
                    //                             Text('Company Address'),
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
                    //                             Text('Company Email'),
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
                    //                             Text('Contact Name'),
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
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: controller.getVendorsModel?.data == null
                    ? myShimmer(): controller.getVendorsModel?.data.length == 0 ? Text("No vendor list found !! "):ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    itemCount: controller.getVendorsModel?.data.length??0,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return Column(
                          children: [
                            Stack(
                                clipBehavior: Clip.none,
                                children: [
                              Container(
                                padding: EdgeInsets.only(top: 13, right: 15, left: 15),
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
                                              child:  Text(
                                                controller.getVendorsModel?.data[index].vendorCode.toString()??"",
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
                                              child:  Text(
                                                controller.getVendorsModel?.data[index].companyName.toString()??"",
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
                                              child:  Text(
                                                controller.getVendorsModel?.data[index].companyAddress.toString()??"",
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
                                              child:  Text(
                                                controller.getVendorsModel?.data[index].email.toString()??"",
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
                                              child: const  Text(
                                                "Name",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                controller.getVendorsModel?.data[index].firstName.toString()??"",
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
                                    controller.allVendorVisibilityController!.AllVendorVisibility(
                                        index);
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
                                  visible: controller.allVendorVisibilityController!
                                      .allVendorVisibleList[index],
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context)=>AllVendorDetails(singleList: controller.getVendorsModel?.data[index],)));
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
                                  visible: controller.allVendorVisibilityController!
                                      .allVendorVisibleList[index],
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, AppScreen.allVendorEditScreen);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>AllVendorEdit(vendorsData: controller.getVendorsModel?.data[index],))
                                      ).then((value){controller.getVendorsApi(context, "1", "10", "", "1");});
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
                                  visible: controller.allVendorVisibilityController!
                                      .allVendorVisibleList[index],
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
                                                        controller.deleteVendorsApi(controller.getVendorsModel?.data[index].id.toString()??"");

                                                        Navigator.pop(context);
                                                        // showDialog(
                                                        //   context: context,
                                                        //   builder:
                                                        //       (BuildContext context) {
                                                        //     Future.delayed(
                                                        //         Duration(seconds: 1),
                                                        //         () {
                                                        //       Navigator.pop(context);
                                                        //       Navigator.pop(context);
                                                        //     });
                                                        //
                                                        //     return CupertinoAlertDialog(
                                                        //       title: Row(
                                                        //         children: [
                                                        //           Container(
                                                        //             padding:
                                                        //                 EdgeInsets.all(
                                                        //                     10),
                                                        //             decoration:
                                                        //                 BoxDecoration(
                                                        //               borderRadius:
                                                        //                   BorderRadius
                                                        //                       .circular(
                                                        //                           30),
                                                        //               color: AppColor
                                                        //                   .green,
                                                        //             ),
                                                        //             child: Icon(
                                                        //               Icons.done,
                                                        //               color:
                                                        //                   Colors.white,
                                                        //             ),
                                                        //           ),
                                                        //           Flexible(
                                                        //             child: Text(
                                                        //               " User Deleted Successfully",
                                                        //               style: TextStyle(
                                                        //                   fontSize: 15,
                                                        //                   color: AppColor
                                                        //                       .green),
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ), // show pop-up
                                                        //     );
                                                        //   },
                                                        // );
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
                            ]
                            ),
                            if(index == (_getVendorsController?.getVendorsModel?.data.length??0)-1  && isLoadingMoreData && (_getVendorsController?.getVendorsModel?.data.length != _getVendorsController?.getVendorsModel?.pagination?.totalItems))
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
          ),
        );
      }
    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
