import 'package:flutter/material.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../Conrollers/Area Alloted Controller/area_alloted_contoller.dart';
import '../../../Nylon Management Screen/Nylon Details/Generated Details/generate_details.dart';

class AllVendorViewDetails extends StatefulWidget {
  final vendorId,orderDate,orderId,qty,totalAmount;
  const AllVendorViewDetails({super.key,this.vendorId,this.orderDate,this.orderId,this.qty,this.totalAmount});

  @override
  State<AllVendorViewDetails> createState() => _AllVendorViewDetailsState();
}

class _AllVendorViewDetailsState extends State<AllVendorViewDetails> {

  void initState() {
    // TODO: implement initState

    super.initState();
    callNylonListApi();

  }
  AreaAllotedController allotedController=AreaAllotedController();
  callNylonListApi()async{
    await allotedController.getVendorBatchListingApi(context, widget.vendorId);
    setState(() {

    });
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
      body:allotedController.getVendorBatchListModel?.data == null ? myShimmer() : allotedController.getVendorBatchListModel?.data.length == 0 ? Center(child: Text("No batch number !!")): Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Order ID",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(
                              "#${widget.orderId}",
                              style: TextStyle(
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Order Date",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(
                              "${widget.orderDate}",
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
                     /* SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Pickup Date",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: const Text(
                              "16 Sept 2023, 11:15 PM",
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
                      ),*/
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Quantity",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 13,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(
                              "${widget.qty} Rolls",
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: const Text(
                              "Amount Paid",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 12,
                                  fontFamily: AppFont.poppinsBold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(
                              "₦${widget.totalAmount}",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 12,
                                  fontFamily: AppFont.poppinsBold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Text(
                    "Batch Details",
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 15,
                        fontFamily: AppFont.poppinsBold),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      "(Click on Batch Number to view serial details)",
                      style: TextStyle(
                          color: AppColor.grey1,
                          fontSize: 10,
                          fontFamily: AppFont.poppinsLight),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child:GridView.builder(
                    padding: EdgeInsets.only(top: 7, bottom: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 35.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 4.0),
                    itemCount: allotedController.getVendorBatchListModel?.data.length,

                    itemBuilder: (BuildContext context, int index) {
                     var batchList = allotedController.getVendorBatchListModel?.data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>GeneratedDetails(batchNumber: batchList?.batchNumber,batchId: batchList?.id,)));
                        },
                        child: Card(
                          elevation: 1,
                          margin: EdgeInsets.zero,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              "${batchList?.batchNumber}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
