import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/user_management_controller.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Admin/User Management Controller/nylon_production_company_controller.dart';
import 'Widget/nylon_production_company_add.dart';

class NylonProductionCompany extends StatefulWidget {
  const NylonProductionCompany({super.key});

  @override
  State<NylonProductionCompany> createState() => _NylonProductionCompanyState();
}

class _NylonProductionCompanyState extends State<NylonProductionCompany> {
  bool isButtonSelected = false;
  final controller = Get.put(NylonProductionController());

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
        print('${_image}');
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
   @override
  void initState() {
    // TODO: implement initState
     nylonProductionCompanyController = NylonProductionCompanyController(context: context);
    super.initState();
     nylonProductionCompanyController.getNylonProductionCompanyApi(context);
  }
  late NylonProductionCompanyController nylonProductionCompanyController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NylonProductionCompanyController(context: context),
      builder: (controller) =>
      Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NylonProductionCompanyScreen()));

          },

        ),
        body:controller.nylonModel == null?
        Center(child: myShimmer())
            :controller.nylonModel?.status == false?  Center(child: Text("Nylon production company not found")) : Padding(
          padding: EdgeInsets.only(top: 2, left: 15, right: 15),
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
                                child:

                                _image != null
                                    ? Image.file(
                                  _image!,
                                  // File(image?.path),
                                  fit: BoxFit.cover,
                                )

                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network("${controller.nylonModel?.data?.imageBaseUrl}${controller.nylonModel?.data?.imageName}",
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
                              "${controller.nylonModel?.data?.roleInfo?.roleName}",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsBold),
                            )
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
                                                //opengallery();
                                                _getFromGallery().then(
                                                        (value){
                                                      if(_image != null){
                                                        controller.updateProfilePicNylonApi(controller.nylonModel!.data!.id.toString(),_image!.path.toString());
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
                                                //opencamera();
                                                _getFromCamera().then(
                                                        (value){
                                                      if(_image != null){
                                                        controller
                                                            .updateProfilePicNylonApi(
                                                            controller.nylonModel!.data!.id.toString(),_image!.path.toString());
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
                            "${controller.nylonModel?.data?.firstName}",
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
                            "${controller.nylonModel?.data?.email}",
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
                            "+234 ${controller.nylonModel?.data?.phoneNumber}",
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
                           Text(
                            "${controller.nylonModel?.data?.companyAddress}",
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppScreen.nylonProductionCompanyEditScreen);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 7, bottom: 7, right: 12, left: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppColor.orange.withOpacity(0.1)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: AppColor.orange,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "EDIT",
                                    style: TextStyle(
                                        color: AppColor.orange,
                                        fontSize: 13,
                                        fontFamily: AppFont.poppinsSemiBold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
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
                                              fontSize: 15, color: AppColor.black),
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
                                                  BorderRadius.circular(7),
                                                  color: AppColor.green,
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      fontFamily:
                                                      AppFont.poppinsLight,
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.deleteNylonProductionCompanyApi(controller.nylonModel?.data?.id ?? "").then((value) {
                                                  controller.getNylonProductionCompanyApi(context);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 10,
                                                    top: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(7),
                                                  color: AppColor.green,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'yes',
                                                    style: TextStyle(
                                                        fontFamily:
                                                        AppFont.poppinsLight,
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
                              padding: EdgeInsets.only(
                                  top: 7, bottom: 7, right: 12, left: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.red.withOpacity(0.1)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline_outlined,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "DELETE",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontFamily: AppFont.poppinsSemiBold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              // Row(
              //   children: [
              //     Flexible(
              //       child: CustomSearchTextField(
              //         hintText: 'Search  here...',
              //         hintStyle: TextStyle(
              //             fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
              //         suffixIcon: Icon(
              //           Icons.search,
              //           color: AppColor.green,
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         showModalBottomSheet(
              //           context: context,
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.vertical(
              //               top: Radius.circular(25.0),
              //             ),
              //           ),
              //           backgroundColor: Colors.white,
              //           builder: (BuildContext context) {
              //             return Wrap(
              //               children: [
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.all(20.0),
              //                             child: Row(
              //                               children: [
              //                                 SvgPicture.asset(
              //                                   AppImages.union,
              //                                   height: 15,
              //                                 ),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 const Text(
              //                                   "Filter By",
              //                                   style: TextStyle(
              //                                       fontFamily:
              //                                           AppFont.poppinsSemiBold),
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Order ID'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           Divider(
              //                             color: Colors.black.withOpacity(0.59),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Vendor Code'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           Divider(
              //                             color: Colors.black.withOpacity(0.59),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Company Name'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 10,
              //                           ),
              //                           Divider(
              //                             color: Colors.black.withOpacity(0.59),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Order Date'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 10,
              //                           ),
              //                           Divider(
              //                             color: Colors.black.withOpacity(0.59),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Order Amount'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 10,
              //                           ),
              //                           Divider(
              //                             color: Colors.black.withOpacity(0.59),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(
              //                                 left: 20,
              //                                 right: 20,
              //                                 top: 10,
              //                                 bottom: 10),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Text('Revenue Earned'),
              //                                 const SizedBox(
              //                                   width: 10,
              //                                 ),
              //                                 CustomRadioButton(
              //                                   isSelected: isButtonSelected,
              //                                   onChanged: (value) {
              //                                     setState(() {
              //                                       isButtonSelected = value;
              //                                     });
              //                                   },
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 10,
              //                           ),
              //                         ])
              //                   ],
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //       child: Container(
              //           padding: EdgeInsets.all(6),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             border: Border.all(color: AppColor.green),
              //             borderRadius: BorderRadius.circular(7),
              //           ),
              //           child: Icon(
              //             Icons.filter_alt_outlined,
              //             color: AppColor.green,
              //           )),
              //     )
              //   ],
              // ),
              // Flexible(
              //   child: ScrollConfiguration(
              //     behavior: MyBehavior(),
              //     child: ListView.builder(
              //       itemCount: 20,
              //       itemBuilder: (context, index) {
              //         return Obx(
              //           () {
              //             return Column(
              //               children: [
              //                 Visibility(
              //                   visible: controller.isContainerVisible.isTrue,
              //                   child: Stack(
              //                     clipBehavior: Clip.none,
              //                     children: [
              //                       Container(
              //                         padding: EdgeInsets.only(top: 20),
              //                         margin: const EdgeInsets.only(bottom: 5),
              //                         child: Card(
              //                           elevation: 1,
              //                           margin: EdgeInsets.zero,
              //                           shape: ContinuousRectangleBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(20)),
              //                           clipBehavior: Clip.hardEdge,
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(15.0),
              //                             child: Column(
              //                               children: [
              //                                 SizedBox(
              //                                   height: 7,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Order ID",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "#123456789",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Revenue Earned",
              //                                         style: TextStyle(
              //                                             fontSize: 13,
              //                                             fontFamily: AppFont
              //                                                 .poppinsSemiBold),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "₦7,580.00",
              //                                         style: TextStyle(
              //                                             fontSize: 12,
              //                                             fontFamily: AppFont
              //                                                 .poppinsSemiBold),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   height: 7,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Positioned(
              //                         left: 300,
              //                         top: 7,
              //                         child: GestureDetector(
              //                           onTap: () {
              //                             controller.ContainerVisible();
              //                           },
              //                           child: Container(
              //                             decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(50),
              //                                 border: Border.all(
              //                                     width: 3, color: AppColor.green)),
              //                             child: Icon(
              //                               Icons.arrow_drop_down,
              //                               size: 20,
              //                               color: AppColor.green,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 Visibility(
              //                   visible: controller.isContainerVisible.isFalse,
              //                   child: Stack(
              //                     clipBehavior: Clip.none,
              //                     children: [
              //                       Container(
              //                         padding: EdgeInsets.only(top: 20),
              //                         margin: const EdgeInsets.only(bottom: 5),
              //                         child: Card(
              //                           elevation: 1,
              //                           margin: EdgeInsets.zero,
              //                           shape: ContinuousRectangleBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(20)),
              //                           clipBehavior: Clip.hardEdge,
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(15.0),
              //                             child: Column(
              //                               children: [
              //                                 SizedBox(
              //                                   height: 7,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Order ID",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "#123456789",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Vendor Code",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "123456",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 12,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Company Name",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "Enumeral Waste Solutions",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 12,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Order Date",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "14 Sept 2023, 12:45PM",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 12,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Order Amount",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 13,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "₦37,900.00",
              //                                         style: TextStyle(
              //                                             color: AppColor.black,
              //                                             fontSize: 12,
              //                                             fontFamily:
              //                                                 AppFont.poppinsLight),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 Divider(
              //                                   color: AppColor.black,
              //                                 ),
              //                                 SizedBox(
              //                                   height: 5,
              //                                 ),
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Expanded(
              //                                       child: const Text(
              //                                         "Revenue Earned",
              //                                         style: TextStyle(
              //                                             fontSize: 13,
              //                                             fontFamily: AppFont
              //                                                 .poppinsSemiBold),
              //                                       ),
              //                                     ),
              //                                     Expanded(
              //                                       flex: 1,
              //                                       child: const Text(
              //                                         "₦7,580.00",
              //                                         style: TextStyle(
              //                                             fontSize: 12,
              //                                             fontFamily: AppFont
              //                                                 .poppinsSemiBold),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   height: 7,
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       Positioned(
              //                         left: 300,
              //                         top: 10,
              //                         child: GestureDetector(
              //                           onTap: () {
              //                             controller.ContainerHide();
              //                           },
              //                           child: Container(
              //                             decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(50),
              //                                 border: Border.all(
              //                                     width: 3, color: AppColor.green)),
              //                             child: Icon(
              //                               Icons.arrow_drop_up_sharp,
              //                               size: 20,
              //                               color: AppColor.green,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );


  }
}
