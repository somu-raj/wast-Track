import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neat_and_clean_calendar/simple_gesture_detector.dart';
import 'package:get/get.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Vendor/Order%20Management%20Controller/order_management_controller.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Order%20Management/By%20Nylon/Widgets/place_order.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class ByNylonDetails extends StatefulWidget {
  const ByNylonDetails({super.key});

  @override
  State<ByNylonDetails> createState() => _ByNylonDetailsState();
}

class _ByNylonDetailsState extends State<ByNylonDetails> {
  final controller = Get.put(OrderManagementController());
  int? quantity;
  int? availableQuantity;
  int finalQuantity = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String,dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    if (args != null) {
      quantity = args['quantity'];
      // quantity = controller.quantity.value;
      availableQuantity = args['available_quantity'];
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetNylonDetailsApi();

  }

  callGetNylonDetailsApi() async {
    await controller.getNylonDetailsApi(context);
    setState(() {});
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
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx( () {
          finalQuantity = (controller.getBuyNylonDetailsModel?.data?.previusQtyInfo?.qty ?? 0)+controller.quantity.value;
          var  productionPercentage = (controller.getBuyNylonDetailsModel?.data?.productionCommisionPerQty ?? 0) * finalQuantity;
          var percentage = controller.getBuyNylonDetailsModel?.data?.commisionInfo?.sharingPercentage;
          var subtotal = (controller.getBuyNylonDetailsModel?.data?.nylonInfo?.currentPrice??0) * finalQuantity ;
          var subTotalFinal = (controller.getBuyNylonDetailsModel?.data?.nylonInfo?.currentPrice??0) * finalQuantity - (controller.getBuyNylonDetailsModel?.data?.productionCommisionPerQty ?? 0) ;
          var revisedCommission = ((percentage??10)*(subtotal-productionPercentage))/100;
          var total =  subtotal-revisedCommission;
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child:
            controller.waiting.value?
            Center(
              child: CupertinoActivityIndicator(
                color: Colors.green,
              ),
            ):
            controller.getBuyNylonDetailsModel?.data == null ? Center(child: CupertinoActivityIndicator()): ListView(
              children: [
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product Details",
                            style: TextStyle(
                                fontFamily: AppFont.poppinsBold, fontSize: 15)),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.bag,
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nylon Bags",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsRegular,
                                            fontSize: 13)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("₦ ${controller.getBuyNylonDetailsModel?.data?.nylonInfo?.currentPrice??0}",
                                        style: TextStyle(
                                            fontFamily: AppFont.poppinsSemiBold,
                                            fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    controller.decreaseQuantity();
                                  },
                                  child: Image.asset(
                                    AppImages.mini,
                                    height: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                controller.getBuyNylonDetailsModel?.data?.previusQtyInfo != null ?Text("${finalQuantity}") :Text('${controller.quantity.value}'),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    controller.increaseQuantity();
                                  },
                                  child: Image.asset(
                                    AppImages.plus,
                                    height: 25,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment Details",
                            style: TextStyle(
                                fontFamily: AppFont.poppinsBold, fontSize: 15)),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsRegular,
                                    fontSize: 13)),

                            Text("₦$subtotal",style: TextStyle(
                                fontFamily: AppFont.poppinsRegular,
                                fontSize: 13)),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("Production Percentage",
                        //         style: TextStyle(
                        //             fontFamily: AppFont.poppinsRegular,
                        //             fontSize: 13)),
                        //
                        //     Text("₦$productionPercentage",style: TextStyle(
                        //         fontFamily: AppFont.poppinsRegular,
                        //         fontSize: 13)),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vendor Commissions (${percentage}%)",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsRegular,
                                    fontSize: 13)),
                            Text("₦${revisedCommission}",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsRegular,
                                    fontSize: 13)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsSemiBold,
                                    fontSize: 13)),
                            Text("₦${total}",
                                style: TextStyle(
                                    fontFamily: AppFont.poppinsSemiBold,
                                    fontSize: 13)),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Billing Details",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: AppFont.poppinsBold),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pushNamed(
                            //         context, AppScreen.editBellingDetailsScreen);
                            //   },
                            //   child: Icon(
                            //     Icons.mode_edit_outline_outlined,
                            //     color: Colors.black,
                            //     size: 25,
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          " ${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.companyName??""}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColor.black,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsSemiBold),
                        ),
                        SizedBox(
                          height: 5,
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
                              " ${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.firstName} ${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.lastName}",
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
                              " ${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.email??""}",
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
                              "${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.phoneNumber}",
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
                            Icon(Icons.location_on_outlined,
                                color: AppColor.green),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${controller.getBuyNylonDetailsModel?.data?.vendorInfo?.companyAddress}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NylonPlaceOrder(subTotal: subtotal,commissions:revisedCommission,total: total,commissionsPercentage: percentage,quantity: controller.quantity.value,productionPercentage: productionPercentage,)));
                        // Navigator.pushNamed(
                        //     context, AppScreen.nylonPlaceOrderScreen,arguments:[
                        //
                        // ]);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, right: 40, left: 40, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.green),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppFont.poppinsSemiBold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
        ),
      ),
    );
  }
}
