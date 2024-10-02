import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Admin/Nylon%20Generation%20Controller/nylon_generation_controller.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Get%20Nylon%20Model/get_nylon_model.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class NylonGeneration extends StatefulWidget {
  final GetNylonModel? getNylonModel;
  const NylonGeneration({super.key,this.getNylonModel});

  @override
  State<NylonGeneration> createState() => _NylonGenerationState();
}
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

class _NylonGenerationState extends State<NylonGeneration> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NylonGenerationController(context: context),
        builder: (controller)=>
        Scaffold(
          body:  controller.getNylonModel == null ?
          myShimmer(): SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Row(
                    children: [
                      Flexible(
                        child: Card(
                          elevation: 1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.getNylonModel != null ? Text(
                                      "${controller.getNylonModel?.data?.availableQty}",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 27,
                                          color: AppColor.green),
                                    ):Text(
                                      "0",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsBold,
                                          fontSize: 27,
                                          color: AppColor.green),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: AppColor.greenMedium1),
                                        child: Center(
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: AppColor.green,
                                            size: 27,
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Nylon Rolls Available",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsMedium,
                                      fontSize: 13,
                                      color: AppColor.grey1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          elevation: 1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: controller.getNylonModel != null ?  Text(
                                        "₦ ${controller.getNylonModel?.data?.currentPrice}",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 25,
                                            color: AppColor.green),
                                      ):Text(
                                        "₦ 0.0",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsBold,
                                            fontSize: 25,
                                            color: AppColor.green),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: AppColor.greenMedium1),
                                        child: Center(
                                            child: Image.asset(
                                              AppImages.cash,
                                              height: 27,
                                            )))
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Current Nylon Price",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsMedium,
                                      fontSize: 13,
                                      color: AppColor.grey1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Card(
                          elevation: 1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Column(
                              children: [
                                Text(
                                  "Generate Nylon Rolls",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsMedium,
                                      fontSize: 13,
                                      color: AppColor.black),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Image.asset(
                                  AppImages.bag,
                                  height: 120,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enter\nQuantity",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 12,
                                          color: AppColor.grey1),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        height: 30,
                                        child: CustomTextField(
                                          keyboardType: TextInputType.number,
                                          fillColor: AppColor.greenLight
                                              .withOpacity(0.3),
                                          filled: true,
                                          controller: quantityController,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(quantityController.text.isNotEmpty){
                                      controller
                                          .updateNylonQuantityApi(
                                          quantityController.text)
                                          .then((value) {
                                        controller.getNylonApi(context);
                                        quantityController.clear();
                                      });
                                    }
                                    else{
                                      CustomSnackBar.mySnackBar(context, "Please Enter Quantity");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.green),
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: controller.isLoadingQuantity == true  ? CupertinoActivityIndicator(): Text(
                                        "Generate",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsSemiBold,
                                            fontSize: 13,
                                            color: AppColor.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          elevation: 1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Column(
                              children: [
                                Text(
                                  "Set Nylon Roll Price",
                                  style: TextStyle(
                                      fontFamily: AppFont.poppinsMedium,
                                      fontSize: 13,
                                      color: AppColor.black),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Image.asset(
                                  AppImages.doller,
                                  height: 120,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Set Price",
                                      style: TextStyle(
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 12,
                                          color: AppColor.grey1),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                          height: 30,
                                          child: CustomTextField(
                                            keyboardType: TextInputType.number,
                                            controller: priceController,
                                            filled: true,
                                            fillColor: AppColor.greenLight.withOpacity(0.3),
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(priceController.text.isNotEmpty){
                                      controller
                                          .updateNylonPriceApi(
                                          priceController.text,
                                          controller
                                              .getNylonModel?.data?.id)
                                          .then((value) {
                                        controller.getNylonApi(context);
                                        priceController.clear();
                                      });
                                    }
                                    else{
                                      CustomSnackBar.mySnackBar(context, "Please Enter Price");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.green),
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: controller.isLoading == true  ? CupertinoActivityIndicator(): Text(
                                        "set",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsSemiBold,
                                            fontSize: 13,
                                            color: AppColor.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        )

    );
  }
}
