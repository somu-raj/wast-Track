import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class AssignedDetails extends StatefulWidget {
  const AssignedDetails({super.key});

  @override
  State<AssignedDetails> createState() => _AssignedDetailsState();
}

class _AssignedDetailsState extends State<AssignedDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool isButtonSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Batch Number",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 12,
                    fontFamily: AppFont.poppinsSemiBold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "7478939857564",
                style: TextStyle(
                    color: AppColor.green,
                    fontSize: 12,
                    fontFamily: AppFont.poppinsBold),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " Vendor Details",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsSemiBold),
                      ),
                      Row(
                        children: [
                          Text(
                            " Vendor Code :",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 11,
                                fontFamily: AppFont.poppinsLight),
                          ),
                          Text(
                            " 12345",
                            style: TextStyle(
                                color: AppColor.green,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsBold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    " Enumeral Waste Solutions Limited",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColor.black,
                        fontSize: 13,
                        fontFamily: AppFont.poppinsSemiBold),
                  ),
                  SizedBox(
                    height: 5,
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
                      const Text(
                        " Lorem Ipsum",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        " vendor@gmail.com",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.call_end_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "+234 90-461-4000",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "abc colony, xyz area, pqr city",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(AppImages.browser),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "website.com",
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
          SizedBox(
            height: 5,
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
                        labelStyle: TextStyle(fontSize: 12),
                        unselectedLabelColor: AppColor.grey1,
                        indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(color: AppColor.green, width: 2),
                          insets: EdgeInsets.symmetric(horizontal: 2),
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(text: 'Serial Details'),
                          Tab(text: 'Track Order'),
                          Tab(text: 'Buyer Details'),
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
                              child: ListView(
                                children: List.generate(
                                  10,
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
                                                      child: const Text(
                                                        "HCX8849287896",
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
                                                        "Date of Collection",
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
                                                      child: const Text(
                                                        "27 Sept 2023",
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
                                                        "Collected by",
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
                                                      child: const Text(
                                                        "Vendor Staff Name",
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
                                              'COLLECTED',
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
                              child: ListView(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_order,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Placed',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:43 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_generated,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Generated',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_assigned,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Assigned',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_picked,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Picked Up',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_sold,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Sold by Vendor',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 47,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                8,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 47,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
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
                              child: ListView(
                                children: List.generate(
                                  10,
                                  (index) => Card(
                                    elevation: 1,
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Buyer Details",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsBold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                              const Text(
                                                " Lorem Ipsum",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.call_end_outlined,
                                                  color: AppColor.green),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "+234 90-461-4000",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                  color: AppColor.green),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "abc colony, xyz area, pqr city",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
