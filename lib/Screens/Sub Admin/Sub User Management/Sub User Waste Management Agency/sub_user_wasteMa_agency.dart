import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Admin/User Management Controller/waste_angency_controller.dart';
import '../../../../Utils/Components/myShimmer.dart';

class SubUserWasteMaAgency extends StatefulWidget {
  const SubUserWasteMaAgency({super.key});

  @override
  State<SubUserWasteMaAgency> createState() => _SubUserWasteMaAgencyState();
}

class _SubUserWasteMaAgencyState extends State<SubUserWasteMaAgency> {
  bool isButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WasteManagementAgencyController(context: context),
      builder: (controller)=>
      controller.wasteModel == null?
      Center(child: myShimmer())
          :controller.wasteModel?.status == false?  Center(child: Text("Waste management agency not found")) :    Padding(
        padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 5, left: 7),
            //   child: Row(
            //     children: [
            //       Flexible(
            //         child: CustomSearchTextField(
            //           hintText: 'Search  here...',
            //           hintStyle: TextStyle(
            //               fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
            //           suffixIcon: Icon(
            //             Icons.search,
            //             color: AppColor.green,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //      /* GestureDetector(
            //         onTap: () {
            //           showModalBottomSheet(
            //             context: context,
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.vertical(
            //                 top: Radius.circular(25.0),
            //               ),
            //             ),
            //             backgroundColor: Colors.white,
            //             builder: (BuildContext context) {
            //               return Wrap(
            //                 children: [
            //                   Column(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.all(20.0),
            //                               child: Row(
            //                                 children: [
            //                                   SvgPicture.asset(
            //                                     AppImages.union,
            //                                     height: 15,
            //                                   ),
            //                                   const SizedBox(
            //                                     width: 10,
            //                                   ),
            //                                   const Text(
            //                                     "Filter By",
            //                                     style: TextStyle(
            //                                         fontFamily:
            //                                             AppFont.poppinsSemiBold),
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 20,
            //                                   right: 20,
            //                                   top: 10,
            //                                   bottom: 10),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text('Name'),
            //                                   const SizedBox(
            //                                     width: 10,
            //                                   ),
            //                                   CustomRadioButton(
            //                                     isSelected: isButtonSelected,
            //                                     onChanged: (value) {
            //                                       setState(() {
            //                                         isButtonSelected = value;
            //                                       });
            //                                     },
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                             Divider(
            //                               color: Colors.black.withOpacity(0.59),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 20,
            //                                   right: 20,
            //                                   top: 10,
            //                                   bottom: 10),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text('Email'),
            //                                   const SizedBox(
            //                                     width: 10,
            //                                   ),
            //                                   CustomRadioButton(
            //                                     isSelected: isButtonSelected,
            //                                     onChanged: (value) {
            //                                       setState(() {
            //                                         isButtonSelected = value;
            //                                       });
            //                                     },
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                             Divider(
            //                               color: Colors.black.withOpacity(0.59),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   left: 20,
            //                                   right: 20,
            //                                   top: 10,
            //                                   bottom: 10),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text('Date Added'),
            //                                   const SizedBox(
            //                                     width: 10,
            //                                   ),
            //                                   CustomRadioButton(
            //                                     isSelected: isButtonSelected,
            //                                     onChanged: (value) {
            //                                       setState(() {
            //                                         isButtonSelected = value;
            //                                       });
            //                                     },
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                             const SizedBox(
            //                               height: 10,
            //                             ),
            //                           ])
            //                     ],
            //                   ),
            //                 ],
            //               );
            //             },
            //           );
            //         },
            //         child: Container(
            //             padding: EdgeInsets.all(6),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               border: Border.all(color: AppColor.green),
            //               borderRadius: BorderRadius.circular(7),
            //             ),
            //             child: Icon(
            //               Icons.filter_alt_outlined,
            //               color: AppColor.green,
            //             )),
            //       )*/
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
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
                      children: [
                        Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          padding: const EdgeInsets.all(2),
                          clipBehavior: Clip.hardEdge,
                          height: 70,
                          width: 70,
                          child: Image.network('${controller.wasteModel?.data?.imageBaseUrl}${controller.wasteModel?.data?.imageName}',
                              fit: BoxFit.cover),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${controller.wasteModel?.data?.roleInfo?.roleName}",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsBold),
                        ),
                      ],
                    ),
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
                          "${controller.wasteModel?.data?.firstName}",
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
                          "${controller.wasteModel?.data?.email}",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsMedium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pushNamed(
                    //             context, AppScreen.subUserWasteMaAgDetailsScreen);
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.only(
                    //             top: 7, bottom: 7, right: 20, left: 20),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(3),
                    //             color: AppColor.darkBlue.withOpacity(0.1)),
                    //         child: Row(
                    //           children: [
                    //             Icon(
                    //               Icons.remove_red_eye,
                    //               size: 20,
                    //               color: AppColor.darkBlue,
                    //             ),
                    //             SizedBox(
                    //               width: 7,
                    //             ),
                    //             Text(
                    //               "VIEW DETAILS",
                    //               style: TextStyle(
                    //                   color: AppColor.darkBlue,
                    //                   fontSize: 12,
                    //                   fontFamily: AppFont.poppinsSemiBold),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '    Waste Management Staff Details',
                style: TextStyle(
                    color: AppColor.green,
                    fontFamily: AppFont.poppinsBold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: controller.staffModel?.data.length,
                  itemBuilder: (context, index) {
                    var staffList = controller.staffModel?.data[index];
                    print('index=>${controller.staffModel?.data.length}');

                    return Column(children: [
                      Container(
                        //padding: EdgeInsets.only(top: 13, right: 10, left: 15),
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
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Expanded(
                                //       child: const Text(
                                //         "Vendor Code",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 13,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child:  Text(
                                //         "${staffList?.vendorCode}",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 13,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Divider(
                                //   color: AppColor.black,
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Expanded(
                                //       child: const Text(
                                //         "Company Name",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 13,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child:  Text(
                                //         "${staffList?.firstName}",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 12,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 7,
                                // ),
                                // Divider(
                                //   color: AppColor.black,
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Expanded(
                                //       child: const Text(
                                //         "Company Address",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 13,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: const Text(
                                //         "abc street, xyz city",
                                //         style: TextStyle(
                                //             color: AppColor.black,
                                //             fontSize: 12,
                                //             fontFamily: AppFont.poppinsLight),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 7,
                                // ),
                                // Divider(
                                //   color: AppColor.black,
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),

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
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "${staffList?.firstName}",
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
                                        "Mobile :",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "${staffList?.phoneNumber}",
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
                                        "Email: ",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsLight),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:  Text(
                                        "${staffList?.email}",
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
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context,
                      //         AppScreen.subUserWasteMaStaffDetailsScreen);
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(right: 12),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         Text(
                      //           'View Details',
                      //           style: TextStyle(
                      //             decoration: TextDecoration.underline,
                      //             color: AppColor.green,
                      //             fontSize: 11,
                      //           ),
                      //         ),
                      //         Icon(
                      //           Icons.arrow_forward_ios_outlined,
                      //           color: AppColor.green,
                      //           size: 11,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
