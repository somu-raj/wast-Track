import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/get_vendors_controller.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_request_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Get%20Vendors%20Model/get_vendors_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Models/Vendor Management Model/Area Search Model/area_search_model.dart';
import '../../../../Utils/Components/custom_sanckbar.dart';
import '../../../../Utils/Components/custom_textfield.dart';

class VendorRequest extends StatefulWidget {
  const VendorRequest({super.key});

  @override
  State<VendorRequest> createState() => _VendorRequestState();
}

class _VendorRequestState extends State<VendorRequest>
    with SingleTickerProviderStateMixin {

  bool isButtonSelected = false;
  String status = "0";
  String? areaId;
  late TabController tabController;
  late GetVendorRequestController getVendorRequestController;
   TextEditingController searchController =  TextEditingController();
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = getVendorRequestController.getVendorRequestModel?.data.length??0;

    if (!isLoadingMoreData && getVendorRequestController.getVendorRequestModel?.data.length != getVendorRequestController.getVendorRequestModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
       status = getVendorRequestController.isPendingRequest? "0":"2";
      getVendorRequestController.getVendorRequestApi(context, "1", '$limit','',status).then(
              (value){
            debugPrint(getVendorRequestController.getVendorRequestModel?.data.length.toString());
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
  final areaSearchController =  TextEditingController();
  @override
  void initState() {
    getVendorRequestController = GetVendorRequestController(context: context);
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // Check if the tab index changed
      if (tabController.indexIsChanging == false) {
       if(tabController.index == 1){
         getVendorRequestController.isPendingRequest = false;
          getVendorRequestController.getVendorRequestApi(
              context, "1", "10", "", "2");
        }else{
         getVendorRequestController.isPendingRequest = true;
         getVendorRequestController.getVendorRequestApi(
             context, "1", "10", "", "0");
       }
        status = getVendorRequestController.isPendingRequest? "0":"2";

      }
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  final ScrollController _scrollController = ScrollController();
  final vendorRequestVisibilityController = Get.put(VendorRequestVisibilityController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: getVendorRequestController,
      builder: (controller) {
        // debugPrint("hhhhhhhhhhhhhhhh");
        // controller.getVendorsApi(context, "1", "10", "", "0");
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomSearchTextField(
                      onChanged: (value){
                        controller.getVendorRequestApi(context, "1", "10",value, status);
                      },
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
                  //               MainAxisAlignment.spaceBetween,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Column(
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
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
                  //                           MainAxisAlignment.spaceBetween,
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
                  //                           MainAxisAlignment.spaceBetween,
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
                  //                           MainAxisAlignment.spaceBetween,
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
                  //                           MainAxisAlignment.spaceBetween,
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
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Request Date'),
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
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 310,
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
                              Tab(text: 'Rejected'),
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
                                  controller.getVendorRequestModel == null?
                                  myShimmer():
                                  controller.getVendorRequestModel?.data.length== 0?
                                  Center(
                                    child: Text("No Pending Request"),
                                  )
                                      :
                                  ListView(
                                    controller: _scrollController,
                                    children: List.generate(
                                        controller.getVendorRequestModel?.data.length??1,
                                            (index) {

                                          String apiDateString =
                                              "${controller.getVendorRequestModel?.data[index].createdAt}";
                                          String formattedDate =
                                          formatDate(apiDateString);
                                          return Column(
                                            children: [
                                              Visibility(
                                                visible: vendorRequestVisibilityController
                                                    .isPeContainerVisible.isTrue,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      EdgeInsets.only(top: 20),
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
                                                                    child:
                                                                    const Text(
                                                                      "Company Name",
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
                                                                    child:
                                                                    Text(
                                                                      controller.getVendorRequestModel?.data[index].companyName.toString()??"",
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
                                                                color:
                                                                AppColor.black,
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
                                                                      "Company Address",
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
                                                                    child:
                                                                    Text(
                                                                      controller.getVendorRequestModel?.data[index].companyAddress.toString()??"",
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 300,
                                                      top: 7,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            vendorRequestVisibilityController
                                                                .PeContainerVisible();
                                                          });
                                                        },
                                                        child: Container(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_down_circle_outlined,
                                                              size: 30,
                                                              color: AppColor.green,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: vendorRequestVisibilityController
                                                    .isPeContainerVisible.isFalse,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: 20),
                                                          margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                          child: Card(
                                                            elevation: 1,
                                                            margin: EdgeInsets.zero,
                                                            shape: ContinuousRectangleBorder(
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
                                                                          "Company Name",
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
                                                                        child:
                                                                        Text(
                                                                          controller.getVendorRequestModel?.data[index].companyName.toString()??"",
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
                                                                          "Company Address",
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
                                                                        child:
                                                                        Text(
                                                                          controller.getVendorRequestModel?.data[index].companyAddress.toString()??"",
                                                                          style: TextStyle(
                                                                              color: AppColor
                                                                                  .black,
                                                                              fontSize:
                                                                              12,
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
                                                                          "Company Email",
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
                                                                        child:
                                                                        Text(
                                                                          controller.getVendorRequestModel?.data[index].email.toString()??"",
                                                                          style: TextStyle(
                                                                              color: AppColor
                                                                                  .black,
                                                                              fontSize:
                                                                              12,
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
                                                                          "Contact Number",
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
                                                                        child:
                                                                        Text(
                                                                          controller.getVendorRequestModel?.data[index].phoneNumber.toString()??"",
                                                                          style: TextStyle(
                                                                              color: AppColor
                                                                                  .black,
                                                                              fontSize:
                                                                              12,
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
                                                                          "Contact Name",
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
                                                                        child:
                                                                        Text(
                                                                          controller.getVendorRequestModel?.data[index].firstName.toString()??"",
                                                                          style: TextStyle(
                                                                              color: AppColor
                                                                                  .black,
                                                                              fontSize:
                                                                              12,
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
                                                                        Text(
                                                                          "Request Date",
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
                                                                        child:
                                                                        Text(
                                                                          formattedDate,
                                                                          style: TextStyle(
                                                                              color: AppColor
                                                                                  .black,
                                                                              fontSize:
                                                                              12,
                                                                              fontFamily:
                                                                              AppFont.poppinsLight),
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
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            GestureDetector(
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
                                                                            "Do you want to Reject this Request?",
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
                                                                            MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap:
                                                                                    () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  padding: EdgeInsets.all(9),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                    color: AppColor.green,
                                                                                  ),
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: TextStyle(fontFamily: AppFont.poppinsLight, fontSize: 15, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap:
                                                                                    () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      Future.delayed(Duration(seconds: 1), () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                      });

                                                                                      return CupertinoAlertDialog(
                                                                                        title: Row(
                                                                                          children: [
                                                                                            Container(
                                                                                              padding: EdgeInsets.all(10),
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(30),
                                                                                                color: Colors.red.withOpacity(0.1),
                                                                                              ),
                                                                                              child: Icon(
                                                                                                Icons.close,
                                                                                                color: Colors.red,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 3,
                                                                                            ),
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                "Request Rejected Successfully.",
                                                                                                style: TextStyle(fontSize: 14, color: Colors.red),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ), // show pop-up
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(7),
                                                                                    color: AppColor.green,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Reject',
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
                                                                padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    right: 55,
                                                                    left: 55),
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(
                                                                    7),
                                                                    color: Colors
                                                                        .red
                                                                        .withOpacity(
                                                                        0.3)),
                                                                child: Text(
                                                                  'Reject',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsSemiBold),
                                                                ),
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
                                                                                "Assign Area",
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
                                                                            controller: areaSearchController,
                                                                            readOnly: true,
                                                                            onTap:() {
                                                                              controller.getAreaSearchApi(context, "").then(
                                                                                      (value) {
                                                                                    if(value != null) {
                                                                                      showAreasList(controller)
                                                                                          ?.then((value) {
                                                                                        areaSearchController.text =
                                                                                            value;
                                                                                      });
                                                                                    }else{
                                                                                      CustomSnackBar.mySnackBar(context, "Something Went Wrong!!");
                                                                                    }
                                                                                  });
                                                                            },
                                                                            padding:
                                                                            EdgeInsets
                                                                                .all(
                                                                                10),
                                                                            prefix: Icon(
                                                                              Icons
                                                                                  .search_outlined,
                                                                              color: AppColor
                                                                                  .green,
                                                                              size: 25,
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius.circular(
                                                                                    7),
                                                                                border: Border.all(
                                                                                    color: AppColor
                                                                                        .green)),
                                                                            placeholder:
                                                                            'Search  Area',
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                               controller.assignToVendor(areaId.toString(),controller.getVendorRequestModel!.data[index].id?? "",context).then((value){
                                                                               controller.getVendorRequestApi(context,  "1", "10", "", "0");
                                                                              } );
                                                                               Navigator.pop(context);
                                                                               areaSearchController.clear();

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
                                                                                  'Assign Area',
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
                                                                padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    right: 50,
                                                                    left: 50),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        7),
                                                                    color: AppColor
                                                                        .greenMedium1
                                                                        .withOpacity(
                                                                        0.7)),
                                                                child: Text(
                                                                  'Approve',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .green,
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      AppFont
                                                                          .poppinsSemiBold),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Positioned(
                                                      left: 300,
                                                      top: 10,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            vendorRequestVisibilityController
                                                                .PeContainerHide();
                                                          });
                                                        },
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50),
                                                                border: Border.all(
                                                                    width: 3,
                                                                    color: AppColor
                                                                        .green)),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_up_sharp,
                                                              size: 20,
                                                              color: AppColor.green,
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if(index == (controller.getVendorRequestModel?.data.length??0)-1  && isLoadingMoreData && (controller.getVendorRequestModel?.data.length != controller.getVendorRequestModel?.pagination?.totalItems))
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircularProgressIndicator(color:AppColor.green),
                                                )
                                            ],
                                          );
                                        }
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
                                  child:
                                  controller.getVendorRequestRejectedModel == null?
                                  myShimmer():
                                  controller.getVendorRequestRejectedModel?.data.length == 0?
                                  Center(
                                    child: Text("No Rejected Vendor"),
                                  )
                                      :

                                  ListView(
                                    controller: _scrollController,
                                    children: List.generate(
                                      controller.getVendorRequestRejectedModel?.data.length??1,
                                          (index){

                                            String apiRequestDateString =
                                                "${controller.getVendorRequestRejectedModel?.data[index].createdAt}";
                                            String requestFormattedDate =
                                            formatDate(apiRequestDateString);

                                            String apiRejectDateString =
                                                "${controller.getVendorRequestRejectedModel?.data[index].rejectedDate}";
                                            String rejectFormattedDate =
                                            formatDate(apiRejectDateString);
                                        return Column(
                                              children: [
                                                Visibility(
                                                  visible: vendorRequestVisibilityController
                                                      .isContainerVisible.isTrue,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        padding:
                                                        EdgeInsets.only(top: 20),
                                                        margin: const EdgeInsets.only(
                                                            bottom: 5),
                                                        child: Card(
                                                          elevation: 1,
                                                          margin: EdgeInsets.zero,
                                                          shape:
                                                          ContinuousRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                          ),
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
                                                                      child:
                                                                      const Text(
                                                                        "Company Name",
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
                                                                      child:
                                                                      Text(
                                                                        "${controller.getVendorRequestRejectedModel?.data[index].companyName}",
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
                                                                  color:
                                                                  AppColor.black,
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
                                                                        "Company Address",
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
                                                                      child:
                                                                      Text(
                                                                        "${controller.getVendorRequestRejectedModel?.data[index].companyAddress}",
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 300,
                                                        top: 7,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            vendorRequestVisibilityController
                                                                .ContainerVisible();
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(50),
                                                                border: Border.all(
                                                                    width: 3,
                                                                    color: AppColor
                                                                        .green)),
                                                            child: Icon(
                                                              Icons.arrow_drop_down,
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
                                                  visible: vendorRequestVisibilityController
                                                      .isContainerVisible.isFalse,
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                top: 20),
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
                                                                    .circular(20),
                                                              ),
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
                                                                            "Company Name",
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
                                                                          child:
                                                                          Text(
                                                                            "${controller.getVendorRequestRejectedModel?.data[index].companyName}",
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
                                                                            "Company Address",
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
                                                                          child:
                                                                          Text(
                                                                            "${controller.getVendorRequestRejectedModel?.data[index].companyAddress}",
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
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
                                                                            "Company Email",
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
                                                                          child:
                                                                          Text(
                                                                            "${controller.getVendorRequestRejectedModel?.data[index].email}",
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
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
                                                                            "Contact Number",
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
                                                                          child:
                                                                          Text(
                                                                            "${controller.getVendorRequestRejectedModel?.data[index].phoneNumber}",
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
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
                                                                            "Contact Name",
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
                                                                          child:
                                                                          Text(
                                                                            "${controller.getVendorRequestRejectedModel?.data[index].firstName}",
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
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
                                                                            "Request Date",
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
                                                                          child:
                                                                          Text(
                                                                            "${requestFormattedDate}",
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
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
                                                                            "Rejection Date",
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
                                                                          child:
                                                                           Text(
                                                                             rejectFormattedDate,
                                                                            style: TextStyle(
                                                                                color: AppColor
                                                                                    .black,
                                                                                fontSize:
                                                                                12,
                                                                                fontFamily:
                                                                                AppFont.poppinsLight),
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
                                                          SizedBox(
                                                            height: 7,
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
                                                                              "Assign Area",
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
                                                                          controller: areaSearchController,
                                                                          readOnly: true,
                                                                          onTap:() {
                                                                            controller.getAreaSearchApi(context, "").then(
                                                                                    (value) {
                                                                                  if(value != null) {
                                                                                    showAreasList(controller)
                                                                                        ?.then((value) {
                                                                                      areaSearchController.text =
                                                                                          value;
                                                                                    });
                                                                                  }else{
                                                                                    CustomSnackBar.mySnackBar(context, "Something Went Wrong!!");
                                                                                  }
                                                                                });
                                                                          },
                                                                          padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          prefix: Icon(
                                                                            Icons
                                                                                .search_outlined,
                                                                            color: AppColor
                                                                                .green,
                                                                            size: 25,
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius.circular(
                                                                                  7),
                                                                              border: Border.all(
                                                                                  color: AppColor
                                                                                      .green)),
                                                                          placeholder:
                                                                          'Search  Area',
                                                                        ),
                                                                        SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            controller.assignToVendor(areaId.toString(),controller.getVendorRequestRejectedModel!.data[index].id?? "",context).then((value){
                                                                              controller.getVendorRequestApi(context,  "1", "10", "", "2");
                                                                            } );
                                                                            Navigator.pop(context);

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
                                                                                'Assign Area',
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
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                padding:
                                                                EdgeInsets.only(
                                                                  top: 10,
                                                                  bottom: 10,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        7),
                                                                    color: AppColor
                                                                        .greenMedium1
                                                                        .withOpacity(
                                                                        0.7)),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Approve',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .green,
                                                                        fontSize: 15,
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned(
                                                        left: 300,
                                                        top: 10,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            vendorRequestVisibilityController
                                                                .ContainerHide();
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(50),
                                                                border: Border.all(
                                                                    width: 3,
                                                                    color: AppColor
                                                                        .green)),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_up_sharp,
                                                              size: 20,
                                                              color: AppColor.green,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if(index == (controller.getVendorRequestRejectedModel?.data.length??0)-1  && isLoadingMoreData && (controller.getVendorRequestRejectedModel?.data.length != controller.getVendorRequestRejectedModel?.pagination?.totalItems))
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: CircularProgressIndicator(color:AppColor.green),
                                                  )
                                              ],
                                            );
                                          }

                                    ),
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
            ],
          ),
        );
      }
    );
  }
  Future<String>? showAreasList(GetVendorRequestController controller) async {
    ValueNotifier<GetAreaSearchModel> searchAreaModel = ValueNotifier(controller.searchAreaModel!);

    (String?,String?)area = await showDialog(
        context: context,
        builder: (_){
          return Dialog(
            child:
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hintText: "Search Area",
                    onChanged: (val){
                      controller.getAreaSearchApi(context, val).then(
                              (value){
                            searchAreaModel.value = value!;
                          });
                    },
                    hintStyle: TextStyle(
                        color: AppColor.lightGrey,
                        fontSize: 13,
                        fontFamily: AppFont.poppinsRegular),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: ValueListenableBuilder(
                        valueListenable: searchAreaModel,
                        builder: (_,searchAreaModel,child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              searchAreaModel.data.length == 0?
                              Center(child: Text("No Area Found"),):
                              Flexible(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchAreaModel.data.length,
                                    itemBuilder: (_,index){
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          GestureDetector(
                                            onTap: (){

                                              if(searchAreaModel.data[index].isAlreadyAssigned??false){
                                                showAreaAlreadyAssignedDialog().then(
                                                        (value){
                                                      if(value??false){
                                                        Navigator.pop(context,(searchAreaModel.data[index].areaName,searchAreaModel.data[index].id));
                                                      }
                                                      else{
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                              }
                                              else {
                                                Navigator.pop(context,
                                                    (searchAreaModel.data[index]
                                                        .areaName, searchAreaModel
                                                        .data[index].id));
                                              }
                                            },
                                            child: Text(
                                              searchAreaModel.data[index].areaName??"",
                                              style: TextStyle(
                                                  fontSize: 16
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 2,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );

    areaId = area.$2;
    debugPrint("areaIdaaaaaaa = ${areaId}");
    return area.$1??"";
  }
  Future<bool?> showAreaAlreadyAssignedDialog() async {
    bool? confirm = await showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text("This area is already assigned to another vendor. Are you sure you want to proceed with the assignment?"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,true);
                  },
                  child: Text("Yes",style: TextStyle(color: AppColor.green),)),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,false);
                  },
                  child: Text("No",style: TextStyle(color: AppColor.redLight),)),
            ],
          );
        }
    );
    return confirm;
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}


