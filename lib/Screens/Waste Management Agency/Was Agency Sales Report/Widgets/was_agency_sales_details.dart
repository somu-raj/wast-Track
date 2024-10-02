import 'package:flutter/material.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class WasAgencySalesDetails extends StatefulWidget {
  const WasAgencySalesDetails({super.key});

  @override
  State<WasAgencySalesDetails> createState() => _WasAgencySalesDetailsState();
}

class _WasAgencySalesDetailsState extends State<WasAgencySalesDetails> {
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
          padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Buyer Name",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "Lorem ipsum",
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Contact Number",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "+234 90-123-2000",
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Buyer Address",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "abc area, xyz city",
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Quantity",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "50 Rolls",
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Date of Purchase",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "15 Sept 2023, 01:30PM",
                              style: TextStyle(
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Batch Details",
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 15,
                        fontFamily: AppFont.poppinsBold),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      "(Click on Batch Number to view serial details)",
                      style: TextStyle(
                          color: AppColor.grey1,
                          fontSize: 10,
                          fontFamily: AppFont.poppinsLight),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 7, bottom: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 35.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 4.0),
                    itemCount: 31,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,
                              AppScreen.wasAgencySalesBatchDetailsScreen);
                        },
                        child: Card(
                          elevation: 1,
                          margin: EdgeInsets.zero,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              "7478939872156",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
