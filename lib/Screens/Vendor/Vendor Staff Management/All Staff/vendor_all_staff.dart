import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Vendor/Staff%20%20Management%20Controller/staff_mangement_controller.dart';
import 'package:waste_track/Models/Vendor/Staff%20Management%20model/getVendorAllStaffModel.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Admin/Vendor Manangement Screen/All Vendor/Widgets/All Vendor Saff/Widgets/all_vendor_staff_details.dart';
import 'Widget/edit_all_staff.dart';

class VendorAllStaff extends StatefulWidget {
  const VendorAllStaff({super.key});

  @override
  State<VendorAllStaff> createState() => _VendorAllStaffState();
}

class _VendorAllStaffState extends State<VendorAllStaff> {
  final staffManagementController = Get.put(StaffManagementController());
  bool isButtonSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   callGetStaffApi();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  bool isLoadingMoreData = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();


  Future<void> _fetchData() async {
    int currentDataLength =
        staffManagementController.getVendorAllStaffModel?.vendorAllStaffData.length??0;

    if (!isLoadingMoreData &&
        staffManagementController.getVendorAllStaffModel?.vendorAllStaffData.length !=
            staffManagementController.getVendorAllStaffModel?.pagination?.totalItems) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500));
      debugPrint(limit.toString());

      staffManagementController.getVendorAllStaffApi(context, "1", '$limit', '',)
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
  callGetStaffApi() async{
   await staffManagementController.getVendorAllStaffApi(context, "1", "10", "");
   setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: [
                Flexible(
                  child: CustomSearchTextField(
                    controller: _searchController,
                    hintText: 'Search  here...',
                    onChanged: (v){
                      staffManagementController.getVendorAllStaffApi(context, "1", "10", v).then((value) {
                        setState(() {

                        });
                      });

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
                //                     crossAxisAlignment: CrossAxisAlignment.start,
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
                //                             Text('Name'),
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
                //                             Text('Email'),
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
                //                             Text('Date Added'),
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Text(
              "Vendor Staff Details ",
              style: TextStyle(
                  fontFamily: AppFont.poppinsBold,
                  color: AppColor.green,
                  fontSize: 17),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          staffManagementController.getVendorAllStaffModel == null?
          Center(
            child: myShimmer(
              //color: AppColor.green,
            ),
          ):
          staffManagementController.getVendorAllStaffModel?.vendorAllStaffData.isNotEmpty??false?
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                itemCount: staffManagementController.getVendorAllStaffModel?.vendorAllStaffData.length??0,
                itemBuilder: (context, index) {
                  print('index=>${index}');
                  VendorAllStaffData? data = staffManagementController.getVendorAllStaffModel?.vendorAllStaffData[index];
                    String name = '${data!.firstName} ${data.lastName}';
                    String email = '${data.email}';
                    String phoneNumber = '${data.phoneNumber}';
                    return Obx(() {
                      return Stack(clipBehavior: Clip.none, children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 15, left: 15, right: 15),
                          margin: const EdgeInsets.only(bottom: 3),
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
                                          "Name",
                                          style:  TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          name,
                                          style: const TextStyle(
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
                                          "Email",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          email,
                                          style:const TextStyle(
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
                                          "Contact Number",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsLight),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child:  Text(
                                          phoneNumber,
                                          style: const TextStyle(
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
                        Positioned(
                          left: 320,
                          top: -8,
                          child: GestureDetector(
                            onTap: () {
                              staffManagementController.toggleVisibility(index);
                            },
                            child: Image.asset(
                              AppImages.opestion,
                              height: 50,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 215,
                          top: -8,
                          child: Visibility(
                            visible: staffManagementController
                                .areOptionVisibleList[index],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>AllVendorStaffDetails(vendorId:data.id ,vName: data.firstName,vEmail: data.email,vPhone: data.phoneNumber,)));
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
                          left: 250,
                          top: -8,
                          child: Visibility(
                            visible: staffManagementController
                                .areOptionVisibleList[index],
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context,
                                //     AppScreen.editAllVendorStaffDetailsScreen,
                                // arguments: {
                                //   "id":data.id
                                // }
                                // );
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context)=> EditAllVendorStaff(data: data,),
                                    // settings: RouteSettings(
                                    //     arguments:{
                                    //       "id":data.id,
                                    //       "first_name": data.firstName,
                                    //       "last_name":data.lastName,
                                    //       "email":email,
                                    //       "phone_number": phoneNumber
                                    //     } )
                                )).then((value){
                                  callGetStaffApi();
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
                          left: 285,
                          top: -8,
                          child: Visibility(
                            visible: staffManagementController
                                .areOptionVisibleList[index],
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
                                                        BorderRadius.circular(
                                                            7),
                                                    color: AppColor.green,
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontFamily: AppFont
                                                            .poppinsLight,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {

                                                  staffManagementController.deleteStaffApi(context, data.id).then((value){
                                                    callGetStaffApi();
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 10,
                                                      top: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
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
                      ]);
                    });
                },
              ),
            ),
          ):
              Center(
                child: Text("No staff !! please add staff"),
              )
        ],
      ),
    );
  }
}
