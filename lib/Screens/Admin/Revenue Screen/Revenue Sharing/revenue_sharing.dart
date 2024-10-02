import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Admin/Revenue%20Controller/revenue_share_controller.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../../Conrollers/Admin/Revenue Controller/revenue_controller.dart';

class RevenueSharing extends StatefulWidget {
  const RevenueSharing({super.key});

  @override
  State<RevenueSharing> createState() => _RevenueSharingState();
}

class _RevenueSharingState extends State<RevenueSharing> {
  final revenueSharingController = Get.put(RevenueSharingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RevenueController(context: context),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 7, left: 20, right: 20),
            child: Obx(() {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Revenue Share',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFont.poppinsBold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: revenueSharingController
                                    .isPercentageVisible.value
                                ? AppColor.grey.withOpacity(0.3)
                                : AppColor.greenMedium1.withOpacity(0.4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              revenueSharingController
                                  .togglePercentageVisibility();
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              color: revenueSharingController
                                      .isPercentageVisible.value
                                  ? AppColor.green.withOpacity(0.3)
                                  : AppColor.green,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    controller.getRevenueShareModel?.data == null
                        ? CupertinoActivityIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount:
                                controller.getRevenueShareModel?.data.length ??
                                    0,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(
                                              top: 15, left: 10, bottom: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Colors.white,
                                          ),
                                          child: controller.getRevenueShareModel?.data[index].sharingType == 1 ? Text(
                                            "${controller.getRevenueShareModel?.data[index].companyName}\n (Fixed per roll)",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: AppFont.poppinsMedium,
                                              color: Colors.black,
                                            ),
                                          ) :Text(
                                            controller.getRevenueShareModel?.data[index].companyName ?? "",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: AppFont.poppinsMedium,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Visibility(
                                        visible: revenueSharingController
                                            .isPercentageVisible.value,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColor.green),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: controller
                                                          .parentageControllers[
                                                      index],
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 5,
                                                              bottom: 15)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            controller.getRevenueShareModel?.data[index].sharingType == 1
                                                ? SizedBox(width: 15,)
                                                : Text(
                                                    '%',
                                                    style: TextStyle(
                                                      color: AppColor.green,
                                                      fontSize: 17,
                                                      fontFamily: AppFont
                                                          .poppinsSemiBold,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: revenueSharingController
                                            .isPercentageValueVisible.value,
                                        child: Container(
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.green),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors.white),
                                          child: controller.getRevenueShareModel?.data[index].sharingType == 1
                                              ? Text(
                                                  '${controller.getRevenueShareModel?.data[index].sharingPercentage} ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppFont.poppinsBold,
                                                    color: Colors.green,
                                                  ),
                                                )
                                              : Text(
                                                  '${controller.getRevenueShareModel?.data[index].sharingPercentage}%',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppFont.poppinsBold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                    CustomButton(
                      onPressed: () async {
                        // if (revenueSharingController.isButtonEnabled.value) {
                        //   revenueSharingController.isPercentageVisible.value = false;
                        //   Get.dialog(
                        //     CupertinoAlertDialog(
                        //       title: Row(
                        //         children: [
                        //           Container(
                        //             padding: EdgeInsets.all(10),
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(30),
                        //               color: AppColor.green,
                        //             ),
                        //             child: Icon(
                        //               Icons.done,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           Flexible(
                        //             child: Text(
                        //               " Revenue Shared Updates",
                        //               style: TextStyle(
                        //                 fontSize: 15,
                        //                 color: AppColor.green,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        //   Future.delayed(Duration(seconds: 1), () {
                        //     Get.back();
                        //     revenueSharingController.isPercentageValueVisible.value = true;
                        //   });
                        // }
                        controller.updateRevenueShareApi().then((value) {
                          revenueSharingController.togglePercentageVisibility();
                        });
                      },
                      width: AppSize.getWidth(context),
                      backgroundColor: !revenueSharingController
                              .isButtonEnabled.value
                          ? MaterialStateProperty.all<Color>(
                              AppColor.green.withOpacity(0.2))
                          : MaterialStateProperty.all<Color>(AppColor.green),
                      buttonText: "Save Changes",
                      textColor: AppColor.white,
                    )
                  ],
                ),
              );
            }),
          );
        });
  }
}
