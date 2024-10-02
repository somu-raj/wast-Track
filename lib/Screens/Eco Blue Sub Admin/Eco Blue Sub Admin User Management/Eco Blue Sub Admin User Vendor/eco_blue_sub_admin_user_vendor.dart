import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/user_management_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Admin/Vender Mangagement Controller/get_vendors_controller.dart';
import '../../../../Utils/Components/myShimmer.dart';
import '../../../Admin/Vendor Manangement Screen/All Vendor/All Vendor Details/all_vendor_details.dart';

class EcoBlueSubUserVendor extends StatefulWidget {
  const EcoBlueSubUserVendor({super.key});

  @override
  State<EcoBlueSubUserVendor> createState() => _EcoBlueSubUserVendorState();
}

class _EcoBlueSubUserVendorState extends State<EcoBlueSubUserVendor> {
  bool isButtonSelected = false;
  final vendorVisibilityController = Get.put(VendorVisibilityController());
  ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = _getVendorsController?.getVendorsModel?.data.length??0;

    if (!isLoadingMoreData && _getVendorsController?.getVendorsModel?.data.length != _getVendorsController?.getVendorsModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      _getVendorsController?.getVendorsApi(context, "1", '$limit','',"1").then(
              (value){
            debugPrint(_getVendorsController?.getVendorsModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

  GetVendorsController? _getVendorsController;

  @override
  void initState() {
    _getVendorsController = GetVendorsController(context: context);
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _getVendorsController,
        builder: (controller) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7, left: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSearchTextField(
                          onChanged: (value){
                            controller.getVendorsApi(context, "1", "10", value, "1");
                          },
                          hintText: 'Search  here...',
                          hintStyle: TextStyle(
                              fontSize: 12, color: AppColor.grey1.withOpacity(
                              0.5)),
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
                      //               mainAxisAlignment: MainAxisAlignment
                      //                   .spaceBetween,
                      //               crossAxisAlignment: CrossAxisAlignment
                      //                   .start,
                      //               children: [
                      //                 Column(
                      //                     crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(
                      //                             20.0),
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
                      //                                   AppFont
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
                      //                           MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text('Vendor Code'),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             CustomRadioButton(
                      //                               isSelected: isButtonSelected,
                      //                               onChanged: (value) {
                      //                                 setState(() {
                      //                                   isButtonSelected =
                      //                                       value;
                      //                                 });
                      //                               },
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       Divider(
                      //                         color: Colors.black.withOpacity(
                      //                             0.59),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 20,
                      //                             right: 20,
                      //                             top: 10,
                      //                             bottom: 10),
                      //                         child: Row(
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text('Company Name'),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             CustomRadioButton(
                      //                               isSelected: isButtonSelected,
                      //                               onChanged: (value) {
                      //                                 setState(() {
                      //                                   isButtonSelected =
                      //                                       value;
                      //                                 });
                      //                               },
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       Divider(
                      //                         color: Colors.black.withOpacity(
                      //                             0.59),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 20,
                      //                             right: 20,
                      //                             top: 10,
                      //                             bottom: 10),
                      //                         child: Row(
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text('Company Address'),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             CustomRadioButton(
                      //                               isSelected: isButtonSelected,
                      //                               onChanged: (value) {
                      //                                 setState(() {
                      //                                   isButtonSelected =
                      //                                       value;
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
                      //                         color: Colors.black.withOpacity(
                      //                             0.59),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 20,
                      //                             right: 20,
                      //                             top: 10,
                      //                             bottom: 10),
                      //                         child: Row(
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text('Company Email'),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             CustomRadioButton(
                      //                               isSelected: isButtonSelected,
                      //                               onChanged: (value) {
                      //                                 setState(() {
                      //                                   isButtonSelected =
                      //                                       value;
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
                      //                         color: Colors.black.withOpacity(
                      //                             0.59),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 20,
                      //                             right: 20,
                      //                             top: 10,
                      //                             bottom: 10),
                      //                         child: Row(
                      //                           mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                           children: [
                      //                             Text('Contact Name'),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             CustomRadioButton(
                      //                               isSelected: isButtonSelected,
                      //                               onChanged: (value) {
                      //                                 setState(() {
                      //                                   isButtonSelected =
                      //                                       value;
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
                  height: 5,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child:  controller.getVendorsModel?.data == null
                        ? myShimmer(): controller.getVendorsModel?.data.length == 0 ? Text("No vendor list found !! "): ListView.builder(
                      itemCount: controller.getVendorsModel?.data.length??0,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        var  vendorList = controller.getVendorsModel?.data[index];
                        print('index=>${index}');

                        return Column(children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 13, right: 15, left: 15),
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
                                            "Vendor Code",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorList!.vendorCode}",
                                            style: TextStyle(
                                                color: AppColor.black,
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
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Company Name",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorList.companyName}",
                                            style: TextStyle(
                                                color: AppColor.black,
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
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Company Address",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorList.companyAddress}",
                                            style: TextStyle(
                                                color: AppColor.black,
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
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Company Email",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorList.email}",
                                            style: TextStyle(
                                                color: AppColor.black,
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
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: const Text(
                                            "Contact Name",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:  Text(
                                            "${vendorList.firstName}",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 12,
                                                fontFamily: AppFont
                                                    .poppinsLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, AppScreen.vendorViewDetailsScreen);
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context)=>AllVendorDetails(singleList: controller.getVendorsModel?.data[index],subAdmin: true,)));
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
                          if(index == (_getVendorsController?.getVendorsModel?.data.length??0)-1  && isLoadingMoreData && (_getVendorsController?.getVendorsModel?.data.length != _getVendorsController?.getVendorsModel?.pagination?.totalItems))
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
          );
        }
    );
  }
}
