import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waste_track/Conrollers/Sub%20Admin/Sub%20Use%20Management%20Controller/sub_user_management_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Admin/User Management Controller/state_government_angency_controller.dart';
import '../../../../Utils/Components/myShimmer.dart';

class EcoBlueSubUserStateMaAgency extends StatefulWidget {
  const EcoBlueSubUserStateMaAgency({super.key});

  @override
  State<EcoBlueSubUserStateMaAgency> createState() => _EcoBlueSubUserStateMaAgencyState();
}

class _EcoBlueSubUserStateMaAgencyState extends State<EcoBlueSubUserStateMaAgency> {
  bool isButtonSelected = false;
  final stateGovAgencyController = Get.put(StateGovAgencyController());

  ImagePicker picker = ImagePicker();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  File? imageFile;
  var profileImage;
  Future _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('${_image}gggggg');
      });
      // Navigator.pop(context);
    }
  }

  Future _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
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
    int currentDataLength = stateGovernmentController?.getRevenueShareListModel?.data.length??0;

    if (!isLoadingMoreData && stateGovernmentController?.getRevenueShareListModel?.data.length != stateGovernmentController?.getRevenueShareListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      stateGovernmentController?.getRevenueShareListApi(context, "1", '$limit','',stateGovernmentController?.stateModel?.data?.revenueModelId).then(
              (value){
            debugPrint(stateGovernmentController?.getRevenueShareListModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

  StateGovernmentController? stateGovernmentController;

  @override
  void initState() {
    stateGovernmentController = StateGovernmentController(context: context);
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
      init: StateGovernmentController(context:  context),
      builder: (controller)=> Padding(
        padding: EdgeInsets.only(top: 2, left: 10, right: 10),
        child: controller.stateModel == null ? myShimmer():
        !(controller.stateModel?.status?? false) ?
        Center(child: Text("${controller.stateModel?.message}")):Column(
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
                    Stack(clipBehavior: Clip.none, children: [
                      Row(
                        children: [
                          Container(
                              decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                              padding: const EdgeInsets.all(2),
                              clipBehavior: Clip.hardEdge,
                              height: 70,
                              width: 70,
                              child: _image != null
                                  ? Image.file(
                                _image!,
                                // File(image?.path),
                                fit: BoxFit.cover,
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network("${controller.stateModel?.data?.imageBaseUrl}${controller.stateModel!.data!.imageBaseUrl}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context,_,__){
                                    return Image.asset(AppImages.profileImg,fit: BoxFit.fill,);
                                  },
                                ),
                              )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${controller.stateModel?.data?.roleInfo?.roleName}",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsBold),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 45,
                        top: 45,
                        child: GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              backgroundColor: AppColor.white,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(10, 10, 0, 5),
                                          child: Text(
                                            "Change Profile",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.black),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.photo_album_rounded,
                                            ),
                                            color: AppColor.green,
                                            iconSize: 30,
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              _getFromGallery().then(
                                                      (value){
                                                    if(_image != null){
                                                      controller
                                                          .updateProfilePicApi(
                                                          controller.stateModel!.data!.id.toString(),_image!.path.toString());
                                                    }
                                                  });
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.camera_alt_rounded),
                                            color: AppColor.green,
                                            iconSize: 30,
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              _getFromCamera().then(
                                                      (value){
                                                    if(_image != null){
                                                      controller
                                                          .updateProfilePicApi(
                                                          controller.stateModel!.data!.id.toString(),_image!.path.toString());
                                                    }
                                                  }
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(50),
                                color: AppColor.green),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 11,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
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
                        Text(
                          "${controller.stateModel?.data?.firstName}",
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
                          "${controller.stateModel?.data?.email}",
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
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 3, left: 5),
              child: Row(
                children: [
                  Flexible(
                    child: CustomSearchTextField(
                      onChanged: (value){
                        print("this is si ${controller.stateModel?.data?.revenueModelId}");
                        controller.getRevenueShareListApi(context, "1", "10", value, controller.stateModel?.data?.revenueModelId);
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
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
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
                  //                                   AppFont.poppinsSemiBold),
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
                  //                             Text('Order ID'),
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
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Order Date'),
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
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Order Amount'),
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
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Revenue Earned'),
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
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child:controller.getRevenueShareListModel?.data == null ? myShimmer(): controller.getRevenueShareListModel?.data.length == 0 ? Center(child: Text("no revenue list found !!")): ListView.builder(
                  itemCount: controller.getRevenueShareListModel?.data.length,
                  itemBuilder: (context, index) {
                    var revenueList = controller.getRevenueShareListModel?.data[index];
                    return Obx(
                          () {
                        return Column(
                          children: [
                            Visibility(
                              visible: stateGovAgencyController
                                  .isContainerVisible.isTrue,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 20),
                                    margin: const EdgeInsets.only(bottom: 5),
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
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: const Text(
                                                    "Order ID",
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
                                                    "#${revenueList?.orderId}",
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
                                                    "Revenue Earned",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child:  Text(
                                                    "₦${revenueList?.revenueEarned}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
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
                                    left: 300,
                                    top: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3, color: AppColor.green)),
                                      child: GestureDetector(
                                        onTap: () {
                                          stateGovAgencyController
                                              .ContainerVisible();
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_down_sharp,
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
                              visible: stateGovAgencyController
                                  .isContainerVisible.isFalse,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 20),
                                    margin: const EdgeInsets.only(bottom: 5),
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
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: const Text(
                                                    "Order ID",
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
                                                    "#${revenueList?.orderId}",
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
                                                    "Vendor Code",
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
                                                    "${revenueList?.vendorCode}",
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
                                                    "Company Name",
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
                                                    "${revenueList?.companyName}",
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
                                                    "Order Date",
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
                                                    "${revenueList?.createdAt}",
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
                                                    "Order Amount",
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
                                                    "₦${revenueList?.orderTotal}",
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
                                                    "Revenue Earned",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child:  Text(
                                                    "₦${revenueList?.revenueEarned}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: AppFont
                                                            .poppinsSemiBold),
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
                                    left: 300,
                                    top: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 3, color: AppColor.green)),
                                      child: GestureDetector(
                                        onTap: () {
                                          stateGovAgencyController
                                              .ContainerHide();
                                        },
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
                            if(index == (controller.getRevenueShareListModel?.data.length??0)-1  && isLoadingMoreData && (controller.getRevenueShareListModel?.data.length != controller.getRevenueShareListModel?.pagination?.totalItems))
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(color:AppColor.green),
                              ),
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
    );
  }
}
