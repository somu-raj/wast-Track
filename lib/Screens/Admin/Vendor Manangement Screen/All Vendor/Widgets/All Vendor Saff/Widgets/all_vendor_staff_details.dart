import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/vendor_managment_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../../../Conrollers/Admin/Vender Mangagement Controller/vendor_staff_controller.dart';

class AllVendorStaffDetails extends StatefulWidget {
  final vendorId,vName,vEmail,vPhone;
  const AllVendorStaffDetails({super.key,this.vendorId,this.vName,this.vEmail,this.vPhone});

  @override
  State<AllVendorStaffDetails> createState() => _AllVendorStaffDetailsState();
}

class _AllVendorStaffDetailsState extends State<AllVendorStaffDetails> {
  bool isButtonSelected = false;
  final controller = Get.put(AllVendorStaffController());

  ScrollController _scrollController = ScrollController();
 late VendorStaffController  vendorStaffController ;
  @override
  void initState() {
    vendorStaffController = VendorStaffController(context: context);
    // TODO: implement initState
    super.initState();
    callVendorStaffCollection();
    _scrollController.addListener((){
          _onScroll();
        });

  }
  callVendorStaffCollection() async {
   await vendorStaffController.getVendorStaffCollectedListApi(context, "1", "10", "",widget.vendorId);
setState(() {

});
  }
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    print("dasdfafdsFsdzfds");
    int currentDataLength = vendorStaffController.getStaffCollectedListModel?.data.length??0;

    if (!isLoadingMoreData && vendorStaffController.getStaffCollectedListModel?.data.length != vendorStaffController.getStaffCollectedListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      vendorStaffController.getVendorStaffCollectedListApi(context,"1",'$limit','',widget.vendorId,).then(
              (value){
            debugPrint("ssssss${vendorStaffController.getStaffCollectedListModel?.data.length.toString()}");
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
    return  GetBuilder(
      init: VendorStaffController(context: context),
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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
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
                          Text(
                            "${widget.vName}",
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
                          Text(
                            "${widget.vEmail}",
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
                          Text(
                            "+234 ${widget.vPhone}",
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: CustomSearchTextField(
                        onChanged: (v){
                          setState(() {
                            vendorStaffController.getVendorStaffCollectedListApi(context,"1",'10',v,widget.vendorId);

                          });
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
                                      Visibility(
                                        visible: controller.isShowVisible.isTrue,
                                        child: Column(
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
                                                  Text('Waste Collected'),
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
                                                  Text('Picket Date'),
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
                                                  Text('Pickup Day'),
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
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.isShowVisible.isFalse,
                                        child: Column(
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
                                                  Text('Serial Number'),
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
                                                  Text('Company Email'),
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
                                                  Text('Buyer Name'),
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
                                                  Text('Buyer Address'),
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
                                                  Text('Date of Generation'),
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
                                        ),
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
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Waste Collected',
                  style: TextStyle(
                      color: AppColor.green,
                      fontFamily: AppFont.poppinsBold,
                      fontSize: 17),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child:vendorStaffController.getStaffCollectedListModel?.data == null ? myShimmer() :vendorStaffController.getStaffCollectedListModel?.data.length == 0 ? Center(child: Text("No waste collected !!")):
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: vendorStaffController.getStaffCollectedListModel?.data.length,
                    itemBuilder: (context, index) {
                      var vendorStaffList = vendorStaffController.getStaffCollectedListModel?.data[index];
                      return Column(
                        children: [
                          Container(
                            padding:
                            EdgeInsets.only(top: 10, left: 10, right: 10),
                            margin: const EdgeInsets.only(bottom: 3),
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Nylon Bags Quantity",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorStaffList?.qty}",
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
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Serial Number",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorStaffList?.serialNumber}",
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
                                            "Pickup Date & Day",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily: AppFont.poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorStaffList?.collectedDate}, ${vendorStaffList?.collectedDay}",
                                            style: TextStyle(
                                                color: AppColor.black,
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
                          ),
                         /* GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  AppScreen.allVendorSerialDetailsScreen);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12, top: 2),
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
                          ),*/
                          if(index == (vendorStaffController.getStaffCollectedListModel?.data.length??0)-1  && isLoadingMoreData && (vendorStaffController.getStaffCollectedListModel?.data.length != vendorStaffController.getStaffCollectedListModel?.pagination?.totalItems))
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color:AppColor.green),
                            ),
                          SizedBox(
                            height: 7,
                          ),
                        ],
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
}
