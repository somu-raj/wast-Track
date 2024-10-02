import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Conrollers/Admin/Nylon%20Generation%20Controller/nylon_details_controller.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Nylon%20Details%20Model/nylon_batch_items_model.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class GeneratedDetails extends StatefulWidget {
  const GeneratedDetails({super.key, this.batchNumber, this.batchId});
  final String? batchNumber;
  final String? batchId;

  @override
  State<GeneratedDetails> createState() => _GeneratedDetailsState();
}



class _GeneratedDetailsState extends State<GeneratedDetails> {
   late final  NylonDetailsController nylonDetailsController ;
   @override
  void initState() {
     nylonDetailsController = NylonDetailsController(context: context);
     callNylonBatchItemsApi();
    // TODO: implement initState
    super.initState();
  }
  callNylonBatchItemsApi() async {
     await nylonDetailsController.getNylonBatchItemsApi(context, widget.batchId);
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
      body:nylonDetailsController.getNylonBatchItemsModel == null?
      Center(
        child: myShimmer(),
      ):
      nylonDetailsController.getNylonBatchItemsModel!.data.isEmpty?
      Center(
        child: Text("No Nylon Batch Items Found!!"),
      ):
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Batch Number :",
                    style: TextStyle(
                        color: AppColor.grey1,
                        fontSize: 15,
                        fontFamily: AppFont.poppinsSemiBold),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    child: Text(
                      nylonDetailsController.getNylonBatchItemsModel?.batchNumber??"",
                      style: TextStyle(
                          color: AppColor.green,
                          fontSize: 17,
                          fontFamily: AppFont.poppinsBold),
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
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 7, bottom: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.75),
                    itemCount: nylonDetailsController.getNylonBatchItemsModel?.data.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      NylonBatchItemsData? nylonBatchItemsData = nylonDetailsController.getNylonBatchItemsModel?.data[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColor.backGround,
                          border: Border.all(
                            color: AppColor.grey
                          )
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              "${nylonDetailsController.getNylonBatchItemsModel?.imageBaseUrl??""}${nylonBatchItemsData?.qrCodeImageName??''}",
                              fit: BoxFit.fill,
                              height: 100,
                              loadingBuilder: (_,child,loadingProgress){
                                if(loadingProgress?.expectedTotalBytes == null){
                                  return child;
                                }
                                return Center(child: CupertinoActivityIndicator(),);
                              },
                              errorBuilder: (_,child,stackTrace){
                                return Image.asset(
                                  AppImages.qr,
                                  height: 100,
                                );
                              },
                            ),
                            const SizedBox(height: 5,),
                            Text(nylonBatchItemsData?.serialNumber??"",style: TextStyle(fontSize: 12),)
                          ],
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
