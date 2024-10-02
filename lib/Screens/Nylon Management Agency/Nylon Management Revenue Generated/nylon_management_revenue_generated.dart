import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:waste_track/Models/Revenue%20Container%20Model/revenue_container_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Admin/Revenue Controller/revenue_share_controller.dart';
import '../../../Utils/Components/myShimmer.dart';

class NylonManagementRevenueGenerated extends StatefulWidget {
  const NylonManagementRevenueGenerated({super.key});

  @override
  State<NylonManagementRevenueGenerated> createState() =>
      _NylonManagementRevenueGeneratedState();
}

class _NylonManagementRevenueGeneratedState extends State<NylonManagementRevenueGenerated> {
  bool isButtonSelected = false;

  // List<Widget> containerWidgets = [
  //   RevenueStateGovernmentAgency(),
  //   RevenueNylonProductionCompany(),
  //   RevenueEnvironmentalConsultants(),
  //   RevenueWasteManagementAgency(),
  //   RevenueVendor(),
  //   RevenueEnforcementTeam(),
  // ];
  // List<String> containerName = [
  //   'State Government Agency',
  //   'Nylon Production Company',
  //   'Environment Consultants',
  //   'Waste Management Agency',
  //   'Vendor',
  //   'Enforcement Team',
  // ];
  int selectedWidgetIndex = 0;
  TextEditingController _searchController = TextEditingController();
  String? sharId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    revenueController = RevenueController(context: context);
    callRevenueApis();
    _scrollController.addListener(() {
      _onScroll();
    });
  }
  callRevenueApis() async {
    await revenueController.getRevenueShareApi(context);
    await revenueController.getRevenueShareAllApi(context);
    revenueController.getRevenueShareCountApi(context,revenueController.getRevenueShareAllModel?.data.first.id ?? "",);
    revenueController.getRevenueShareListApi(context, "1", '10','',revenueController.getRevenueShareAllModel?.data.first.id??"",);
  }

  bool isLoadingMoreData = false;
  final ScrollController _scrollController = ScrollController();

  late RevenueController revenueController;

  Future<void> _fetchData() async {
    int currentDataLength =
        revenueController.getRevenueShareListModel?.data.length ?? 0;

    if (!isLoadingMoreData &&
        revenueController.getRevenueShareListModel?.data.length !=
            revenueController.getRevenueShareListModel?.pagination?.totalItems) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500));
      debugPrint(limit.toString());

      revenueController.getRevenueShareListApi(context, "1", '$limit', '', '')
          .then((value) {
        //debugPrint(getVendorRequestController.getVendorRequestModel?.data.length.toString());
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
    return GetBuilder(init: revenueController,
      builder: (controller) => Scaffold(
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
        body: controller.getRevenueShareAllModel == null?Center(child: myShimmer()):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Revenue Generated",
                    style: TextStyle(
                        fontFamily: AppFont.poppinsBold,
                        fontSize: 17,
                        color: AppColor.green),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CustomSearchTextField(
                          onChanged: (v) {
                            controller.getRevenueShareListApi(
                                context, "1", "10",v,controller.getRevenueShareAllModel?.data[selectedWidgetIndex].id??"");
                          },
                          hintText: 'Search here...',
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
                      //                               MainAxisAlignment
                      //                                   .spaceBetween,
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
                      //                         color:
                      //                             Colors.black.withOpacity(0.59),
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
                      //                         color:
                      //                             Colors.black.withOpacity(0.59),
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
                      //                             Text('Company name'),
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
                      //                         color:
                      //                             Colors.black.withOpacity(0.59),
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
                      //                       const SizedBox(
                      //                         height: 10,
                      //                       ),
                      //                       Divider(
                      //                         color:
                      //                             Colors.black.withOpacity(0.59),
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          controller.getRevenueShareAllModel?.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 7, left: 10, right: 10, bottom: 2),
                              decoration: selectedWidgetIndex == index
                                  ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: AppColor.grey)
                                  : BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.transparent),
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedWidgetIndex = index;
                                    controller.getRevenueShareCountApi(context,controller.getRevenueShareAllModel!.data[index].id);
                                    controller.getRevenueShareListApi(context, "1", "10", "", controller.getRevenueShareAllModel!.data[index].id);

                                  });
                                },
                                child: Text(
                                  "${controller.getRevenueShareAllModel?.data[index].companyName}",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFont.poppinsLight,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColor.green,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: NestedScrollView(
                              headerSliverBuilder:
                                  (BuildContext context, bool innerBoxIsScrolled) {
                                // These are the slivers that show up in the "outer" scroll view.
                                return <Widget>[
                                  SliverToBoxAdapter(
                                    child: AspectRatio(
                                      aspectRatio: 9 / 3,
                                      child: ScrollConfiguration(
                                        behavior: MyBehavior(),
                                        child: Container(
                                          height: 120,
                                          child: controller.getRevenueShareCountModel == null ?myShimmer():ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                    width: MediaQuery.of(context).size.width * 0.46,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                    child: Card(
                                                      elevation: 1,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: AppColor.grey),),

                                                      clipBehavior: Clip.hardEdge,
                                                      child: Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                        padding: EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    "",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 12,
                                                                        color: AppColor
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Center(
                                                                    child:
                                                                    Image.asset(
                                                                      AppImages.pay_box,
                                                                      height: 32,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "₦${controller.getRevenueShareCountModel?.data?.overall?.amount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold,
                                                                        fontSize: 18,
                                                                        color: AppColor
                                                                            .green),
                                                                  ),
                                                                  Text(
                                                                    "Total Revenue Earned",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 11,
                                                                        color: AppColor
                                                                            .grey1),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                                    width: MediaQuery.of(context).size.width * 0.46,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                    child: Card(
                                                      elevation: 1,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: AppColor.grey),),
                                                      clipBehavior: Clip.hardEdge,
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    "This Week",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 12,
                                                                        color: AppColor
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Center(
                                                                    child:
                                                                    Image.asset(
                                                                      (controller.getRevenueShareCountModel?.data?.weekly?.changePercentage??0)>=0?AppImages.stock1:AppImages.stock,
                                                                      height: 32,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "₦${controller.getRevenueShareCountModel!.data?.weekly?.amount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold,
                                                                        fontSize: 18,
                                                                        color: AppColor
                                                                            .green),
                                                                  ),
                                                                  Text(
                                                                    "${controller.getRevenueShareCountModel?.data?.weekly?.changePercentage??"0"}% compared to last week",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 11,
                                                                        color:(controller.getRevenueShareCountModel?.data?.weekly?.changePercentage ??0)<0 ? AppColor.redLight:AppColor.green) ,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                                    width: MediaQuery.of(context).size.width * 0.46,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                    child: Card(
                                                      elevation: 1,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: AppColor.grey),),
                                                      clipBehavior: Clip.hardEdge,
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    "This Month",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 12,
                                                                        color: AppColor
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Center(
                                                                    child:
                                                                    Image.asset(
                                                                      (controller.getRevenueShareCountModel?.data?.monthly?.changePercentage??0)>=0?AppImages.stock1:AppImages.stock,
                                                                      height: 32,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "₦${controller.getRevenueShareCountModel!.data?.monthly?.amount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold,
                                                                        fontSize: 18,
                                                                        color: AppColor
                                                                            .green),
                                                                  ),
                                                                  controller.getRevenueShareCountModel!.data!.monthly!.changePercentage == null ? Text("0 % compared to last month",style: TextStyle( fontSize: 11, fontFamily:
                                                                  AppFont
                                                                      .poppinsMedium,color: AppColor
                                                                      .grey1),) :Text(
                                                                    "${controller.getRevenueShareCountModel!.data?.monthly?.changePercentage}% compared to last month",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 11,
                                                                        color:(controller.getRevenueShareCountModel?.data?.monthly?.changePercentage ??0)<0 ? AppColor.redLight:AppColor.green) ,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                                    width: MediaQuery.of(context).size.width * 0.46,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                    child: Card(
                                                      elevation: 1,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: AppColor.grey),),
                                                      clipBehavior: Clip.hardEdge,
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: 10,
                                                            left: 10,
                                                            right: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    "This Year",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 12,
                                                                        color: AppColor
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Center(
                                                                    child:
                                                                    Image.asset(
                                                                      (controller.getRevenueShareCountModel?.data?.yearly?.changePercentage??0)>=0?AppImages.stock1:AppImages.stock,
                                                                      height: 32,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "₦${controller.getRevenueShareCountModel!.data?.yearly?.amount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold,
                                                                        fontSize: 18,
                                                                        color: AppColor
                                                                            .green),
                                                                  ),
                                                                  controller.getRevenueShareCountModel!.data!.yearly!.changePercentage == null ? Text("0 % compared to last year",style: TextStyle( fontSize: 11, fontFamily:
                                                                  AppFont
                                                                      .poppinsMedium,color: AppColor
                                                                      .grey1),) :Text(
                                                                    "${controller.getRevenueShareCountModel!.data?.yearly?.changePercentage}% compared to last year",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        AppFont
                                                                            .poppinsMedium,
                                                                        fontSize: 11,
                                                                        color:(controller.getRevenueShareCountModel?.data?.yearly?.changePercentage ??0)<0 ? AppColor.redLight:AppColor.green) ,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              body: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: controller.getRevenueShareListModel?.data ==
                                    null
                                    ? myShimmer()
                                    : controller.getRevenueShareListModel?.data
                                    .length ==
                                    0
                                    ? Center(
                                    child: Text(
                                        "revenue sharing list not found !!"))
                                    : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: controller
                                      .getRevenueShareListModel
                                      ?.data
                                      .length,
                                  itemBuilder: (context, index) {
                                    var shareList = controller
                                        .getRevenueShareListModel
                                        ?.data[index];
                                    return Column(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              padding:
                                              EdgeInsets.only(top: 10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 3, top: 10),
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
                                                            child: const Text(
                                                              "Order Date",
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
                                                            child: Text(
                                                              "${shareList?.createdAt}",
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
                                                              "Vendor Code",
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
                                                            child: Text(
                                                              "${shareList?.vendorCode}",
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
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
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
                                                            child: Text(
                                                              "${shareList?.companyName}",
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
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
                                                              "Order Amount",
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
                                                            child: Text(
                                                              "₦${shareList?.orderTotal}",
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
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          Expanded(
                                                            child: const Text(
                                                              "Revenue Earned",
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
                                                            child: Text(
                                                              "₦${shareList?.revenueEarned}",
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
                                              left: 10,
                                              top: 10,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 4,
                                                    left: 11,
                                                    right: 11,
                                                    bottom: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                  color:
                                                  AppColor.greenMedium1,
                                                ),
                                                child: Text(
                                                  '#${shareList?.orderId}',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: AppColor.green),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if(index == (controller.getRevenueShareListModel?.data.length??0)-1  && isLoadingMoreData && (controller.getRevenueShareListModel?.data.length != controller.getRevenueShareListModel?.pagination?.totalItems))
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(color:AppColor.green),
                                          )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
