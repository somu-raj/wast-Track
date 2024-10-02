import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Area Alloted Controller/area_alloted_contoller.dart';

class VendorAssignedAreas extends StatefulWidget {
  const VendorAssignedAreas({super.key});

  @override
  State<VendorAssignedAreas> createState() => _VendorAssignedAreasState();
}

class _VendorAssignedAreasState extends State<VendorAssignedAreas> {

  void initState() {
    // TODO: implement initState

    super.initState();
    callNylonListApi();

  }
  AreaAllotedController allotedController=AreaAllotedController();
  callNylonListApi()async{
    await allotedController.getAreaAllotedApi(context, "", "", "","");
    setState(() {

    });
  }

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
      body:allotedController.getAreaAllotedModel?.data == null ? myShimmer(): allotedController.getAreaAllotedModel?.data.length == 0 ? Center(child: Text("No assigned area !!")): Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Areas Assigned",
              style: TextStyle(
                  fontFamily: AppFont.poppinsBold,
                  color: AppColor.green,
                  fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: allotedController.getAreaAllotedModel?.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: 0),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: Card(
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: const Text(
                                      "Areas:",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsBold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child:  Text(
                                      "${allotedController.getAreaAllotedModel?.data[index].areaName}",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 13,
                                          fontFamily: AppFont.poppinsLight),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
