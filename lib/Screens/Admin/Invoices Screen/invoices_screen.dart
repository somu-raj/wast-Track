import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../Conrollers/Admin/Invoice Controller/invoice_controller.dart';
import '../../../Conrollers/Invoice/invoice_controller.dart';
import '../../../Utils/Components/Search Text Field/custom_search_text_field.dart';
import '../../../Utils/Components/myShimmer.dart';
import 'Invoice Details/invoice_details.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});
  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}
class _InvoicesScreenState extends State<InvoicesScreen> {
  final invoiceController1 = Get.put(InvoiceController());
  bool isButtonSelected = false;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );
  }
  bool isLoadingMoreData = false;
  final ScrollController _scrollController = ScrollController();

  OrderInvoiceController? invoiceController;
  Future<void> _fetchData() async {
    int currentDataLength = invoiceController?.invoiceModel?.data.length??0;

    if (!isLoadingMoreData && invoiceController?.invoiceModel?.data.length != invoiceController?.invoiceModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(milliseconds: 1500 ));
      debugPrint(limit.toString());
      invoiceController?.getOrderInvoiceApi(context, "1", '$limit','').then(
              (value){
            //debugPrint(getVendorRequestController.getVendorRequestModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  // String formatDate(String dateString) {
  //   DateTime dateTime = DateTime.parse(dateString);
  //   String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  //   return formattedDate;
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrderInvoiceController(context:context ),
      builder: (controller) =>
      Scaffold(
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
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomSearchTextField(
                      controller: _searchController,
                      onChanged: (value){
                        controller.getOrderInvoiceApi(context, "1", "10",value);
                      },
                      hintText: 'Search here...',
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
                  //                         CrossAxisAlignment.start,
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
                  //                                       AppFont.poppinsSemiBold),
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
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Invoice ID'),
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
                  //                               MainAxisAlignment.spaceBetween,
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
                  //                               MainAxisAlignment.spaceBetween,
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
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Date & Time'),
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
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Text('Amount'),
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
                  //         border:
                  //             Border.all(color: AppColor.green.withOpacity(0.6)),
                  //         borderRadius: BorderRadius.circular(7),
                  //       ),
                  //       child: Icon(
                  //         Icons.filter_alt_outlined,
                  //         color: AppColor.green,
                  //       )),
                  // )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child:controller.invoiceModel?.data == null? myShimmer():controller.invoiceModel?.data.length == 0 ?
                  Center(child: Text("No order invoice list found !!")): ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.invoiceModel?.data.length,
                    itemBuilder: (context, index) {
                      var invoiceList = controller.invoiceModel?.data[index];
                      // String apiDateString = "${invoiceList?.createdAt}";
                      // String formattedDate = formatDate(apiDateString);
                      return Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                margin: const EdgeInsets.only(bottom: 10),
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
                                                "Invoice ID",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "#${invoiceList!.invoiceNo}",
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: const Text(
                                                "Vendor Code",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${invoiceList?.vendorCode}",
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
                                                "Company Name",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${invoiceList?.companyName}",
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
                                                "Date & Time",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "${invoiceList?.createdAt}",
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
                                                "Total Amount",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsLight),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:  Text(
                                                "₦ ${invoiceList?.total}",
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
                              Positioned(
                                left: 280,
                                top: -8,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      invoiceController1.ImageVisibility(index);
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
                                left: 215,
                                top: -8,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, AppScreen.invoiceDetailsScreen);

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoiceDetails(invoiceId: invoiceList!.id,)));
                                  },
                                  child: Visibility(
                                    visible:
                                    invoiceController1.areOptionVisibleList[index],
                                    child: Image.asset(
                                      AppImages.eye,
                                      height: 52,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 248,
                                top: -8,
                                child: GestureDetector(
                                  onTap: () {
                                    print("object");
                                    controller.generateOrderInvoiceApi(context,invoiceList!.id ?? "");
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     Future.delayed(Duration(seconds: 1), () {
                                    //       Navigator.pop(context);
                                    //
                                    //       // setState(() {
                                    //       //   isEditVisible = true;
                                    //       //   isVisible = false;
                                    //       // });
                                    //     });
                                    //
                                    //     return CupertinoAlertDialog(
                                    //       title: Row(
                                    //         children: [
                                    //           Container(
                                    //             padding: EdgeInsets.all(10),
                                    //             decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(30),
                                    //               color: AppColor.green,
                                    //             ),
                                    //             child: Icon(
                                    //               Icons.done,
                                    //               color: Colors.white,
                                    //             ),
                                    //           ),
                                    //           SizedBox(
                                    //             width: 5,
                                    //           ),
                                    //           Flexible(
                                    //             child: Text(
                                    //               "Invoice Download Successfully",
                                    //               style: TextStyle(
                                    //                   fontSize: 14,
                                    //                   color: AppColor.green),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ), // show pop-up
                                    //     );
                                    //   },
                                    // );
                                  },
                                  child: Visibility(
                                      visible: invoiceController1
                                          .areOptionVisibleList[index],
                                      child: SvgPicture.asset(AppImages.downloaded)),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 2,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 4, left: 11, right: 11, bottom: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColor.greenMedium1),
                                    child: Text(
                                      '${invoiceList!.paymentStatusText}',
                                      style: TextStyle(
                                          fontSize: 11, color: AppColor.green),
                                    )),
                              ),
                            ],
                          ),
                          if(index == (invoiceController?.invoiceModel?.data.length??0)-1  && isLoadingMoreData && (invoiceController?.invoiceModel?.data.length != invoiceController?.invoiceModel?.pagination?.totalItems))
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color:AppColor.green),
                            )

                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
