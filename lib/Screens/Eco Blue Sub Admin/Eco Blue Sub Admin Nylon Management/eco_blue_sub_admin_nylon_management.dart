import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Nylon Management Controller/nylon_management_controller.dart';
import '../../../Utils/Components/myShimmer.dart';
import 'Eco Blue Sub Admin Nylon Management Details/eco_blue_sub_admin_nylon_management_details.dart';

class EcoBlueSubAdminNylonManagement extends StatefulWidget {
  const EcoBlueSubAdminNylonManagement({super.key});

  @override
  State<EcoBlueSubAdminNylonManagement> createState() =>
      _EcoBlueSubAdminNylonManagementState();
}

class _EcoBlueSubAdminNylonManagementState extends State<EcoBlueSubAdminNylonManagement> {
  bool isButtonSelected = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    callNylonListApi();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  NylonManagementController nylonManagementController=NylonManagementController();
  callNylonListApi()async{
    await nylonManagementController.getNylonDetailsApi(context, "1", "10", "");
    setState(() {

    });
  }

  ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = nylonManagementController.getNylonDetailsAssignedModel?.data.length??0;

    if (!isLoadingMoreData && nylonManagementController.getNylonDetailsAssignedModel?.data.length != nylonManagementController.getNylonDetailsAssignedModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      nylonManagementController.getNylonDetailsApi(context, "1", '$limit','',).then(
              (value){
            debugPrint(nylonManagementController.getNylonDetailsAssignedModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
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
      body: nylonManagementController.getNylonDetailsAssignedModel == null ?myShimmer():nylonManagementController.getNylonDetailsAssignedModel?.data.length == 0 ? Center(child: Text("Nylon List Not Found !!")) :Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              "Nylon Management",
              style: TextStyle(
                  color: AppColor.green,
                  fontFamily: AppFont.poppinsBold,
                  fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    onChanged: (value){
                      nylonManagementController.getNylonDetailsApi(context, "1", "10", value,);
                    },
                    hintText: 'Search here...',
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
                /*GestureDetector(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            Text('Batch Number'),
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
                                            Text('Vendor Code'),
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
                                            Text('Company name'),
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
                                            Text('Assigned Date'),
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
                        border:
                            Border.all(color: AppColor.green.withOpacity(0.6)),
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
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:nylonManagementController.getNylonDetailsAssignedModel?.data.length,
                  itemBuilder: (context, index) {
                    var nylonList = nylonManagementController.getNylonDetailsAssignedModel?.data[index];
                    return Column(children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 13,
                        ),
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
                                        "Batch Number",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "${nylonList?.batchNumber}",
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
                                        "${nylonList?.vendorCode}",
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
                                        "Company Name",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${nylonList?.companyName}",
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
                                        "Assigned Date",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "${nylonList?.assignedDate}",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SubNylonManagementDetails(batchNumber: nylonList?.batchNumber,vendorId: nylonList?.vendorId,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'View Details',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColor.green,
                                  fontSize: 11,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppColor.green,
                                size: 11,
                              )
                            ],
                          ),
                        ),
                      ),
                      if(index == (nylonManagementController.getNylonDetailsAssignedModel?.data.length??0)-1  && isLoadingMoreData && (nylonManagementController.getNylonDetailsAssignedModel?.data.length != nylonManagementController.getNylonDetailsAssignedModel?.pagination?.totalItems))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color:AppColor.green),
                        ),
                      SizedBox(
                        height: 7,
                      ),
                    ]);
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
