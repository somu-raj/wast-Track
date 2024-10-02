import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Sub%20Admin%20Controller/sub_admin_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Conrollers/Admin/User Management Controller/eco_blue_sub_admin_controller.dart';
import '../../../../../Models/User Management Model/EcoBlue SubAdmin/get_ecoblue_sub_admin_model.dart';
import '../../../../../Utils/Components/myShimmer.dart';

class EcoBlueSubAdminDetails extends StatefulWidget {
  final SubAdminListData? subAdminList;
  const EcoBlueSubAdminDetails({super.key,this.subAdminList});

  @override
  State<EcoBlueSubAdminDetails> createState() => _EcoBlueSubAdminDetailsState();
}

class _EcoBlueSubAdminDetailsState extends State<EcoBlueSubAdminDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController = tabController = TabController(length: 1, vsync: this) ;

  @override
  void initState() {
    super.initState();

    ecoBlueSubAdminController = EcoBlueSubAdminController(context: context);
    wasteCollectedEcoBlueApi();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  late EcoBlueSubAdminController ecoBlueSubAdminController;
  wasteCollectedEcoBlueApi() async {
    await  ecoBlueSubAdminController.getWasteCollectionApi(context, "1","10","",'2',widget.subAdminList?.id);
    setState(() {

    });
    debugPrint("${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length}aaaaaaaa");
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length??0;

    if (!isLoadingMoreData && ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length != ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      ecoBlueSubAdminController.getWasteCollectionApi(context, "1", '$limit','','2',widget.subAdminList?.id).then(
              (value){
            debugPrint("aaaaaaaaaaaa${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length.toString()}");
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  bool isButtonSelected = false;
  final controller1 = Get.put(AdminSubAdminController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EcoBlueSubAdminController(context: context),
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CustomSearchTextField(
                            onChanged: (v){
                              ecoBlueSubAdminController.getWasteCollectionApi(context, "1","10",v,'2',widget.subAdminList?.id);

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
                        /* GestureDetector(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Ticket ID'),
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
                                              left: 20,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Ticket Creator Name'),
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
                                        ),
                                      ],
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
                    )*/
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          // These are the slivers that show up in the "outer" scroll view.
                          return <Widget>[
                            SliverToBoxAdapter(
                              child: AspectRatio(
                                aspectRatio: 7 / 4,
                                // child:  Container(color: Colors.amber,)
                                child: Card(
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              // clipBehavior: Clip.hardEdge,
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(42),
                                                  child: Image.asset(
                                                      AppImages.profileImg)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Sub-Admin Company Name",
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_outline_rounded,
                                              color: AppColor.green,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${widget.subAdminList?.firstName}",
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.email_outlined,
                                                color: AppColor.green),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${widget.subAdminList?.email}",
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
                              ),
                            ),
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              pinned: true,
                              elevation: 0,
                              backgroundColor: AppColor.backGround,
                              title: TabBar(
                                labelColor: AppColor.green,
                                labelStyle: TextStyle(fontSize: 11),
                                unselectedLabelColor: AppColor.grey1,
                                indicator: UnderlineTabIndicator(
                                  borderSide:
                                  BorderSide(color: AppColor.green, width: 2),
                                  insets: EdgeInsets.symmetric(horizontal: 20),
                                ),
                                controller: tabController,
                                tabs: const [
                                  /* Tab(text: 'Tickets Resolved'),*/
                                  Tab(
                                    text: 'Waste Collection Verified',
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                        body: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            /* ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(
                              5,
                              (index) => Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Card(
                                      elevation: 1,
                                      margin: EdgeInsets.zero,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                                    "Ticket ID",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            AppFont.poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "123364",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
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
                                                    "Ticket Creator Name",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            AppFont.poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "Enumeral Waste Solutions",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
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
                                                    "Subject",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            AppFont.poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "Withdrawal Related  Issue",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
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
                                                    "Resolved",
                                                    style: TextStyle(
                                                        color: AppColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            AppFont.poppinsLight),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: const Text(
                                                    "15 Sept 2023, 11:45 AM",
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppScreen.ticketResolvedDetailsScreen);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'View Details',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColor.green,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: AppColor.green,
                                            size: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),*/ // Waste collection TabBarView

                            ScrollConfiguration(
                              behavior: MyBehavior(),
                              child:ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data == null ? myShimmer():ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length == 0 ?Center(child: Text("No verify collected list !!"),):ListView(

                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length ??0,
                                      (index) => Column(

                                    children: [

                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Obx(
                                                () {
                                              return Column(
                                                children: [
                                                  Visibility(
                                                    visible: controller1
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].serialNumber}",
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].collectedDate}",
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
                                                          left: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.83,
                                                          top: 7,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              controller1
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
                                                    visible: controller1
                                                        .isContainerVisible.isFalse,
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].serialNumber}",
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
                                                                          "Buyer Name",
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].name}",
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
                                                                  Divider(
                                                                    color: AppColor.black,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  /* Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Expanded(
                                                                    child: const Text(
                                                                      "Contact Number",
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
                                                                      "+234 ${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].}",
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
                                                              Divider(
                                                                color: AppColor.black,
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),*/
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].collectedDate}",
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
                                                                          "Status",
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
                                                                          "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].statusText}",
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
                                                                  /* Divider(
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
                                                                      "Remark",
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
                                                                    child: const Text(
                                                                      "${ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data[index].}",
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
                                                              )*/
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.83,
                                                          top: 10,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              controller1.ContainerHide();
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
                                          ),
                                          Positioned(
                                            left: 15,
                                            top: 7,
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
                                                  'COLLECTED-ORIGINAL',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: AppColor.green),
                                                )),
                                          ),
                                        ],
                                      ),
                                      if(index == (ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length??0)-1  && isLoadingMoreData && (ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.data.length != ecoBlueSubAdminController.getWasteVerifyCollectionListModel?.pagination?.totalItems))
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(color:AppColor.green),
                                        )
                                    ],
                                  ),
                                ),
                                controller: _scrollController,
                              ),
                            ), //
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
