import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Admin/Nylon%20Generation%20Controller/nylon_details_controller.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/user_management_controller.dart';
import 'package:waste_track/Models/Nylon%20Generation%20Model/Nylon%20Details%20Model/nylon_details_assigned_model.dart';
import 'package:waste_track/Utils/Components/Search%20Text%20Field/custom_search_text_field.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_radio_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../../Conrollers/Admin/Nylon Generation Controller/nylon_generation_controller.dart';
import '../../../../Models/Nylon Generation Model/Nylon Details Model/nylon_details_generated_model.dart';
import '../../../../Utils/images/images.dart';
import 'Generated Details/generate_details.dart';

class NylonDetails extends StatefulWidget {
  final GetNylonDetailsGeneratedModel? getNylonDetailsGeneratedModel;
  const NylonDetails({super.key,this.getNylonDetailsGeneratedModel});

  @override
  State<NylonDetails> createState() => _NylonDetailsState();
}

class _NylonDetailsState extends State<NylonDetails>
    with SingleTickerProviderStateMixin {
  bool isButtonSelected = false;
  String status  = "0";
  final ScrollController _scrollController = ScrollController();
  List<String> batchIds=[];
  late TabController tabController;
  late NylonDetailsController nylonDetailsController;

  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = nylonDetailsController.getNylonDetailsGeneratedModel?.data.length??0;
    debugPrint("fetchData called!!!!!  ${nylonDetailsController.getNylonDetailsGeneratedModel?.data.length}");
    if (!isLoadingMoreData && nylonDetailsController.getNylonDetailsGeneratedModel?.data.length != nylonDetailsController.getNylonDetailsGeneratedModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint("limit==>$limit");
       status = nylonDetailsController.isGeneratedDetails? "0":"1";
      nylonDetailsController.getNylonDetailsApi(
          context, status, "1", "$limit", "").then(
              (value){
            // debugPrint(nylonDetailsController.getNylonDetailsGeneratedModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }

  void _onScroll() {

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      debugPrint("maxScrollExtent called!!");
      _fetchData();
    }
  }

  String? formatDate(DateTime? date) {
    String? formattedDate;
    // DateTime dateTime = DateTime.parse(dateString);
    if(date != null){
       formattedDate = DateFormat('dd MMMM yyyy').format(date);
    }
    return formattedDate;
  }

  @override
  void initState() {
    nylonDetailsController = NylonDetailsController(context: context);
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    // debugPrint("generated ${nylonDetailsController.getNylonDetailsGeneratedModel?.data.length}");
    tabController.addListener(() {
      if (tabController.indexIsChanging == false) {
        if(tabController.index == 1){
          nylonDetailsController.isGeneratedDetails = false;
          nylonDetailsController.getNylonDetailsApi(
              context, "1", "1", "10", "");
        }else{
          nylonDetailsController.isGeneratedDetails = true;
          nylonDetailsController.getNylonDetailsApi(
              context, "0", "1", "10", "");
        }
      }
      status = nylonDetailsController.isGeneratedDetails? "0":"1";
    });
    _scrollController.addListener(
            () {
      _onScroll();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


 selectAll(NylonDetailsController controller){
   if(batchIds.length != controller.getNylonDetailsGeneratedModel!.data.length){
     batchIds =[];
     for(var data in controller.getNylonDetailsGeneratedModel!.data)
     {
       batchIds.add(data.id??"");
     }}
   else{
     batchIds =[];
   }
   setState(() {

   });
 }


  // static Future<bool> _permissionRequest() async {
  //   PermissionStatus result = await Permission.storage.request();
  //   debugPrint("status  ${result.isGranted}");
  //   if (!result.isGranted) {
  //     openAppSettings();
  //     await Permission.storage.request();
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: nylonDetailsController,
        builder: (controller)=>
            Scaffold(
              floatingActionButton:
              batchIds.isEmpty
                  ?
              const SizedBox.shrink()
              :Align(
                alignment:  Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green
                    ),
                    child: Text("Download",style: TextStyle(color:AppColor.white),),
                    onPressed: () async {
                      controller.getNylonBatchIdsDownloadUrlApi(batchIds)
                          .then((value){
                        batchIds =[];
                      });
                      // if(await _permissionRequest()) {
                      //
                      // }
                      // else{
                      //   CustomSnackBar.mySnackBar(context, "Please allow Storage Permission!");
                      // }
                      }
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: CustomSearchTextField(
                            onChanged: (value){
                              controller.getNylonDetailsApi(context, status, "1", "10", value);
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
                        //                             Text('Batch Number'),
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
                        //                             Text('Company name'),
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
                        //                             Text('Assigned Date'),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              child: TabBar(
                                labelColor: AppColor.green,
                                labelStyle: TextStyle(fontSize: 15),
                                unselectedLabelColor: AppColor.grey1,
                                indicator: UnderlineTabIndicator(
                                  borderSide:
                                  BorderSide(color: AppColor.green, width: 2),
                                  insets: EdgeInsets.symmetric(horizontal: 2),
                                ),
                                controller: tabController,
                                tabs: const [
                                  Tab(text: 'Generated'),
                                  Tab(text: 'Assigned'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              controller.getNylonDetailsGeneratedModel == null?
                              myShimmer():
                              controller.getNylonDetailsGeneratedModel?.data.length == 0?
                              const Center(child: Text("No Generated Nylon"),):
                              Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: (){
                                             selectAll(controller);
                                          },
                                          child: Row(
                                            children: [
                                              Text("Select All",style: TextStyle(color: AppColor.green,decoration: TextDecoration.underline,),),
                                              Checkbox(
                                                  value: batchIds.length == controller.getNylonDetailsGeneratedModel!.data.length,
                                                  onChanged: (val){
                                                     selectAll(controller);
                                                  })
                                            ],
                                          ))
                                    ],
                                  ),
                                  Expanded(
                                    child: ScrollConfiguration(
                                        behavior: MyBehavior(),
                                        child:
                                        ListView.builder(
                                            controller: _scrollController,
                                            itemCount: nylonDetailsController.getNylonDetailsGeneratedModel?.data.length ?? 0,
                                            itemBuilder: (context,index){
                                              NylonDetailsGeneratedData? nylonDetailsGeneratedData =  controller.getNylonDetailsGeneratedModel?.data[index];
                                              DateTime? generatedDate = controller.getNylonDetailsGeneratedModel?.data[index].createdAt;
                                              String? formattedDate = formatDate(generatedDate);
                                              return Column(
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            right: 10, left: 10, top: 20),
                                                        margin:
                                                        const EdgeInsets.only(bottom: 5),
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
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    Expanded(
                                                                      child: const Text(
                                                                        "Batch Number",
                                                                        style: TextStyle(
                                                                            color:
                                                                            AppColor.black,
                                                                            fontSize: 13,
                                                                            fontFamily: AppFont
                                                                                .poppinsLight),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: Text(
                                                                        "${nylonDetailsGeneratedData?.batchNumber}",
                                                                        style: TextStyle(
                                                                            color:
                                                                            AppColor.black,
                                                                            fontSize: 13,
                                                                            fontFamily: AppFont
                                                                                .poppinsLight),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child: Divider(
                                                                        color: AppColor.black,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left:12.0),
                                                                      child: SizedBox(
                                                                        height: 16,
                                                                         width:16,
                                                                        child: Checkbox(
                                                                            value: batchIds.contains(nylonDetailsGeneratedData?.id),
                                                                            onChanged: (val){
                                                                              debugPrint("value $val");
                                                                                      if(val !=null &&  !val){
                                                                                        // controller.nylonDetailsVisibilityController.areOptionSelectedList?[index] = val;
                                                                                        batchIds.remove(nylonDetailsGeneratedData?.id);
                                                                                      }
                                                                                      else{
                                                                                        batchIds.add(nylonDetailsGeneratedData?.id??'');
                                                                                      }
                                                                                      setState(() {});
                                                                                    }),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    Expanded(
                                                                      child: const Text(
                                                                        "Date of Generation",
                                                                        style: TextStyle(
                                                                            color:
                                                                            AppColor.black,
                                                                            fontSize: 13,
                                                                            fontFamily: AppFont
                                                                                .poppinsLight),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:  Text(
                                                                        formattedDate??"",
                                                                        style: TextStyle(
                                                                            color:
                                                                            AppColor.black,
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Positioned(
                                                        left: 300,
                                                        top: -8,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              controller.nylonDetailsVisibilityController
                                                                  .toggleVisibility(index);
                                                            });
                                                          },
                                                          child: Container(
                                                            child: Image.asset(
                                                              AppImages.opestion,
                                                              height: 50,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 196,
                                                        top: -8,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                               MaterialPageRoute(builder: (context)=>GeneratedDetails(batchId: nylonDetailsGeneratedData?.id,batchNumber: nylonDetailsGeneratedData?.batchNumber,)));
                                                          },
                                                          child: Visibility(
                                                            visible: controller.nylonDetailsVisibilityController
                                                                .areOptionVisibleList[index],
                                                            child: Image.asset(
                                                              AppImages.eye,
                                                              height: 52,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 244,
                                                        top: 6,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller.getNylonBatchIdsDownloadUrlApi([nylonDetailsGeneratedData?.id??'']);
                                                          //  controller.downLoadFile("", controller.getNylonDetailsGeneratedModel?.data[index].id);
                                                          },
                                                          child: Visibility(
                                                            visible: controller.nylonDetailsVisibilityController
                                                                .areOptionVisibleList[index],
                                                            child:Container(
                                                              height: 27,
                                                              width: 27,
                                                              decoration: BoxDecoration(
                                                                color: AppColor.blueLight.withOpacity(0.4),
                                                                borderRadius: BorderRadius.circular(100)
                                                              ),
                                                              child:Center(
                                                                child: Image.asset(
                                                                  AppImages.download,
                                                                  height: 20,
                                                                  width: 20,
                                                                  color: AppColor.blueLight,
                                                                ),
                                                              ),
                                                            )
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 265,
                                                        top: -8,
                                                        child: GestureDetector(
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
                                                                            fontSize: 15,
                                                                            color:
                                                                            AppColor.black),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            child: Container(
                                                                              padding:
                                                                              EdgeInsets
                                                                                  .all(9),
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    7),
                                                                                color: AppColor
                                                                                    .green,
                                                                              ),
                                                                              child: Text(
                                                                                'Cancel',
                                                                                style: TextStyle(
                                                                                    fontFamily:
                                                                                    AppFont
                                                                                        .poppinsLight,
                                                                                    fontSize:
                                                                                    15,
                                                                                    color: Colors
                                                                                        .white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              Navigator.pop(context);
                                                                              controller.getNylonBatchDeleteApi(controller.getNylonDetailsGeneratedModel?.data[index].id);

                                                                            },
                                                                            child: Container(
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left: 20,
                                                                                  right: 20,
                                                                                  bottom:
                                                                                  10,
                                                                                  top: 10),
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    7),
                                                                                color: AppColor
                                                                                    .green,
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'yes',
                                                                                  style: TextStyle(
                                                                                      fontFamily:
                                                                                      AppFont
                                                                                          .poppinsLight,
                                                                                      fontSize:
                                                                                      15,
                                                                                      color: Colors
                                                                                          .white),
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
                                                          child: Visibility(
                                                              visible: controller.nylonDetailsVisibilityController
                                                                  .areOptionVisibleList[index],
                                                              child: Image.asset(
                                                                AppImages.delete,
                                                                height: 50,
                                                              )),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 40,
                                                        top: 7,
                                                        child: controller.getNylonDetailsGeneratedModel?.data[index].status != 0
                                                            ?Container(
                                                          padding: EdgeInsets.only(
                                                              top: 4,
                                                              left: 11,
                                                              right: 11,
                                                              bottom: 4),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(20),
                                                              color: AppColor.greenMedium1),
                                                          child: Text(
                                                            'Printed',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: AppColor.green),
                                                          ),
                                                        ) :
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: 4,
                                                              left: 11,
                                                              right: 11,
                                                              bottom: 4),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(20),
                                                              color: AppColor.redLight.withOpacity(0.2)),
                                                          child: Text(
                                                            'NOT PRINTED',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: AppColor.redLight),
                                                          ),
                                                        )
                                                      ),
                                                    ],
                                                  ),
                                                  if(index == (controller.getNylonDetailsGeneratedModel?.data.length??0)-1  && isLoadingMoreData && (controller.getNylonDetailsGeneratedModel?.data.length != controller.getNylonDetailsGeneratedModel?.pagination?.totalItems))
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: CircularProgressIndicator(color:AppColor.green),
                                                    )
                                                ],
                                              );
                                            })
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * .01,
                                  ),
                                  Expanded(
                                    child: ScrollConfiguration(
                                      behavior: MyBehavior(),
                                      child:
                                      controller.getNylonDetailsAssignedModel == null?
                                      myShimmer():
                                      controller.getNylonDetailsAssignedModel?.data.length == 0?
                                          const Center(child: Text("No Assigned Nylon"),):
                                         ListView.builder(
                                        controller: _scrollController,
                                             itemCount: controller.getNylonDetailsAssignedModel?.data.length??0,
                                             itemBuilder: (_,index) {
                                               NylonDetailsAssignedData? nylonDetailAssigned = controller.getNylonDetailsAssignedModel?.data[index];
                                               // String? formattedDate = formatDate(nylonDetailAssigned?.assignedDate);
                                            return Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      right: 15,
                                                      left: 15),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Card(
                                                    elevation: 1,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 7,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Batch Number",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  nylonDetailAssigned?.batchNumber??"",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          AppFont
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
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Vendor Code",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  nylonDetailAssigned?.vendorCode??"",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          AppFont
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
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Company Name",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  nylonDetailAssigned?.companyName??"",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          AppFont
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
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Expanded(
                                                                child: const Text(
                                                                  "Assigned Date",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          AppFont
                                                                              .poppinsLight),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:  Text(
                                                                  nylonDetailAssigned?.assignedDate??"",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          AppFont
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
                                                    Navigator.pushNamed(
                                                        context,
                                                        AppScreen
                                                            .assignedDetailsScreen);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'View Details',
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: AppColor.green,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color: AppColor.green,
                                                          size: 10,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        // Obx(() {
        //   return
        // })
        );
  }

}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
