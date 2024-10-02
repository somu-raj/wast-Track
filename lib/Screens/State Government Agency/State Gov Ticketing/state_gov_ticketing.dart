import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class StateGovTicketing extends StatefulWidget {
  const StateGovTicketing({super.key});

  @override
  State<StateGovTicketing> createState() => _StateGovTicketingState();
}

class _StateGovTicketingState extends State<StateGovTicketing>
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
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Row(
                children: [
                  Flexible(
                    child: CustomSearchTextField(
                      hintText: 'Search tickets here...',
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
                  GestureDetector(
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
                                                    fontFamily: AppFont
                                                        .poppinsSemiBold),
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
                                              Text('Date'),
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
                                      ])
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
                          border: Border.all(
                              color: AppColor.green.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: AppColor.green,
                        )),
                  )
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
                          labelStyle: TextStyle(fontSize: 13),
                          unselectedLabelColor: AppColor.grey1,
                          indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(color: AppColor.green, width: 2),
                            insets: EdgeInsets.symmetric(horizontal: 2),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(text: 'In Progress'),
                            Tab(text: 'On Hold'),
                            Tab(text: 'Resolved'),
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
                                    (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            AppScreen
                                                .stateGovTicketingDetailsScreen);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              // clipBehavior: Clip.hardEdge,
                                              height: 65,
                                              width: 65,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(42),
                                                  child: Image.asset(
                                                      AppImages.profileImg)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Enumeral Solutions Ltd.",
                                                        style: TextStyle(
                                                            color:
                                                                AppColor.black,
                                                            fontSize: 12,
                                                            fontFamily: AppFont
                                                                .poppinsBold),
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),
                                                      const Text(
                                                        "14 Oct",
                                                        style: TextStyle(
                                                            color:
                                                                AppColor.black,
                                                            fontSize: 12,
                                                            fontFamily: AppFont
                                                                .poppinsBold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Withdrawal Related issue",
                                                    style: TextStyle(
                                                        color: AppColor.black
                                                            .withOpacity(0.9),
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "I am not able to withdraw my money even....",
                                                    style: TextStyle(
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 11,
                                                        fontFamily: AppFont
                                                            .poppinsRegular),
                                                  ),
                                                ],
                                              ),
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
                                    (index) => Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            // clipBehavior: Clip.hardEdge,
                                            height: 65,
                                            width: 65,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(42),
                                                child: Image.asset(
                                                    AppImages.profileImg)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Enumeral Solutions Ltd.",
                                                      style: TextStyle(
                                                          color: AppColor.black,
                                                          fontSize: 12,
                                                          fontFamily: AppFont
                                                              .poppinsBold),
                                                    ),
                                                    const SizedBox(
                                                      width: 40,
                                                    ),
                                                    const Text(
                                                      "14 Oct",
                                                      style: TextStyle(
                                                          color: AppColor.black,
                                                          fontSize: 12,
                                                          fontFamily: AppFont
                                                              .poppinsBold),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Withdrawal Related issue",
                                                  style: TextStyle(
                                                      color: AppColor.black
                                                          .withOpacity(0.9),
                                                      fontSize: 12,
                                                      fontFamily: AppFont
                                                          .poppinsSemiBold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "I am not able to withdraw my money even....",
                                                  style: TextStyle(
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontSize: 11,
                                                      fontFamily: AppFont
                                                          .poppinsRegular),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  children: List.generate(
                                    10,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            AppScreen
                                                .stateGovTicketingDetailsScreen);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              // clipBehavior: Clip.hardEdge,
                                              height: 65,
                                              width: 65,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(42),
                                                  child: Image.asset(
                                                      AppImages.profileImg)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Enumeral Solutions Ltd.",
                                                        style: TextStyle(
                                                            color:
                                                                AppColor.black,
                                                            fontSize: 12,
                                                            fontFamily: AppFont
                                                                .poppinsBold),
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),
                                                      const Text(
                                                        "14 Oct",
                                                        style: TextStyle(
                                                            color:
                                                                AppColor.black,
                                                            fontSize: 12,
                                                            fontFamily: AppFont
                                                                .poppinsBold),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Withdrawal Related issue",
                                                    style: TextStyle(
                                                        color: AppColor.black
                                                            .withOpacity(0.9),
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "I am not able to withdraw my money even....",
                                                    style: TextStyle(
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontSize: 11,
                                                        fontFamily: AppFont
                                                            .poppinsRegular),
                                                  ),
                                                ],
                                              ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.green,
        onPressed: () {
          Navigator.pushNamed(context, AppScreen.stateGovCreateTicketingScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
