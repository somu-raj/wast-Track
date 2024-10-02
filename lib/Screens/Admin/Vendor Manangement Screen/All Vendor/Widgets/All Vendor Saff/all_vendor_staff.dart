import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../../../Utils/Components/app_font.dart';
import '../../../../../../../Utils/colors/app_colors.dart';
import '../../../../../../Conrollers/Admin/Vender Mangagement Controller/vendor_staff_controller.dart';
import '../../../../../../Models/Vendor Management Model/Get Vendor Staff Model/get_vendor_staff_model.dart';
import 'Widgets/all_vendor_staff_details.dart';
import 'Widgets/all_vendor_staff_edit.dart';

class AllVendorStaff extends StatefulWidget {
   String? vendorId;
   GeVendorStaffModel? staffModel;
   AllVendorStaff({super.key,this.vendorId,this.staffModel});

  @override
  State<AllVendorStaff> createState() => _AllVendorStaffState();
}

class _AllVendorStaffState extends State<AllVendorStaff> {
  final allVendorStaffController = Get.put(AllVendorStaffController());
  bool isButtonSelected = false;

  ScrollController _scrollController = ScrollController();
  VendorStaffController? vendorStaffController;
  @override
  void initState() {
    vendorStaffController = VendorStaffController(context: context);
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = vendorStaffController?.geVendorStaffModel?.data.length??0;

    if (!isLoadingMoreData && vendorStaffController?.geVendorStaffModel?.data.length != vendorStaffController?.geVendorStaffModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      vendorStaffController?.getVendorStaffApi(context, "1", '$limit','',).then(
              (value){
            debugPrint("ssssss${vendorStaffController?.geVendorStaffModel?.data.length.toString()}");
            setState(() {
              isLoadingMoreData =false;
            });
          });
         //dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }





  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: VendorStaffController(context: context),
        builder: (controller){
        controller.vendorId = widget.vendorId;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.green,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppScreen.vendorAddStaffList,
              );
            },
            child: const Icon(Icons.add),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomSearchTextField(
                          hintText: 'Search  here...',
                          onChanged: (value){
                            controller.getVendorStaffApi(context, "1", "10", value,);
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
                    /*  GestureDetector(
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                Text('Name'),
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
                                                Text('Email'),
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
                          ),
                        ),
                      )*/
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child:controller.geVendorStaffModel == null ? myShimmer(): controller.geVendorStaffModel?.data.length == 0 ? Text("${controller.geVendorStaffModel?.message}") :
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.geVendorStaffModel!.data.length,

                        itemBuilder: (context, index) {
                         var staffModelLst = controller.geVendorStaffModel!.data[index];
                          print('index=>${index}');
                          return Obx(
                                () {
                              return Column(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
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
                                                        style: TextStyle(
                                                            color: AppColor.black,
                                                            fontSize: 13,
                                                            fontFamily:
                                                            AppFont.poppinsLight),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:  Text(
                                                        "${staffModelLst.firstName}",
                                                        style: TextStyle(
                                                            color: AppColor.black,
                                                            fontSize: 13,
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
                                                        "Email",
                                                        style: TextStyle(
                                                            color: AppColor.black,
                                                            fontSize: 13,
                                                            fontFamily:
                                                            AppFont.poppinsLight),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:  Text(
                                                        "${staffModelLst.email}",
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
                                                            fontFamily:
                                                            AppFont.poppinsLight),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child:  Text(
                                                        "${staffModelLst.phoneNumber}",
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
                                      Positioned(
                                        left: 275,
                                        top: -8,
                                        child: GestureDetector(
                                          onTap: () {
                                            allVendorStaffController.toggleVisibility(index);
                                          },
                                          child: Image.asset(
                                            AppImages.opestion,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 180,
                                        top: -8,
                                        child: Visibility(
                                          visible: allVendorStaffController.areOptionVisibleList[index],
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context)=>AllVendorStaffDetails(vendorId:staffModelLst.id,vName:staffModelLst.firstName,vEmail:staffModelLst.email,vPhone:staffModelLst.phoneNumber)));
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
                                        left: 213,
                                        top: -8,
                                        child: Visibility(
                                          visible: allVendorStaffController.areOptionVisibleList[index],
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context)=>AllVendorStaffEdit(staffList: controller.geVendorStaffModel?.data[index],))
                                              ).then((value){controller.getVendorStaffApi(context,"1","10","");});
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
                                        left: 245,
                                        top: -8,
                                        child: Visibility(
                                          visible: allVendorStaffController.areOptionVisibleList[index],
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
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets.all(9),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(7),
                                                                  color: AppColor.green,
                                                                ),
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      fontFamily: AppFont
                                                                          .poppinsLight,
                                                                      fontSize: 15,
                                                                      color:
                                                                      Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                                controller.deleteVendorStaffApi(staffModelLst.id ?? "").then((value){controller.getVendorStaffApi(context, "1","10", "");});

                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    bottom: 10,
                                                                    top: 10),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(7),
                                                                  color: AppColor.green,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'yes',
                                                                    style: TextStyle(
                                                                        fontFamily: AppFont
                                                                            .poppinsLight,
                                                                        fontSize: 15,
                                                                        color:
                                                                        Colors.white),
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
                                    ],
                                  ),
                                  if(index == (vendorStaffController?.geVendorStaffModel?.data.length??0)-1  && isLoadingMoreData && (vendorStaffController?.geVendorStaffModel?.data.length != vendorStaffController?.geVendorStaffModel?.pagination?.totalItems))
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(color:AppColor.green),
                                    )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        }

    );


  }
}
