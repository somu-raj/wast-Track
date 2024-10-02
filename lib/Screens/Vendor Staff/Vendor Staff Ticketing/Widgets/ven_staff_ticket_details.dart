import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/divider/horizontal_doted_divider.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class VenStaffTicketDetails extends StatefulWidget {
  const VenStaffTicketDetails({super.key});

  @override
  State<VenStaffTicketDetails> createState() => _VenStaffTicketDetailsState();
}

class _VenStaffTicketDetailsState extends State<VenStaffTicketDetails> {
  var messageController = TextEditingController();
  File? _image;
  XFile? imageFile;
  final picker = ImagePicker();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  openGallery() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;
    PermissionStatus? cameraShowAlert;
    PermissionStatus? storageShowAlert;
    if (!cameraStatus.isGranted) {
      cameraShowAlert = await Permission.camera.request();
    }
    if (!storageStatus.isGranted) {
      storageShowAlert = await Permission.storage.request();
    }
    if (await Permission.camera.isGranted) {
      if (await Permission.storage.isGranted) {
        imageFile = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 20);
        if (imageFile != null) {
          setState(() {
            _image = File(imageFile!.path);
          });
        }
      } else {
        //  print("Camera needs to access your storage, please provide permission");
      }
    } else {
      if (cameraShowAlert == PermissionStatus.permanentlyDenied ||
          storageShowAlert == PermissionStatus.permanentlyDenied) {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: const Text('Requires Camera Permission'),
                  content: const Text(
                      'This application requires access to your camera and storage'),
                  actions: <Widget>[
                    CustomButton(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.yellowLight),
                      textColor: AppColor.black,
                      buttonText: 'Allow',
                      onPressed: () async {
                        await openAppSettings();
                        Navigator.pop(context);
                      },
                    ),
                    CustomButton(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.yellowLight),
                      textColor: AppColor.black,
                      buttonText: 'Cancel',
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
      } else {
        //  print("Camera access denied!.. $cameraStatus and $storageStatus");
      }
    }
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              openGallery();
                            },
                            icon:
                                Icon(Icons.attach_file, color: AppColor.green),
                          ),
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          hintText: "Send Your Response",
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontSize: 12,
                              fontFamily: AppFont.poppinsSemiBold),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: AppColor.green.withOpacity(0.6),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColor.green,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColor.green,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColor.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: AppColor.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Ticket Id : #${"121255"}",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 15,
                      fontFamily: AppFont.poppinsBold),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ticket Information",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: AppFont.poppinsSemiBold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ticket Opened by:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outline_sharp,
                                            color: AppColor.green,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Enumeral Waste Solutions Limited",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor.grey1,
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Vendor@gmail.com",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          " Also on this Ticket:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppFont.poppinsSemiBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline_sharp,
                                              color: AppColor.green,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Admin Name",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.grey1,
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Admin@gmail.com",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline_sharp,
                                              color: AppColor.green,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Sub-Admin",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.grey1,
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "subAdmin@gmail.com",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AppImages.info,
                    height: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Withdraw related issue",
              style: TextStyle(
                  color: AppColor.green,
                  fontSize: 15,
                  fontFamily: AppFont.poppinsBold),
            ),
            const SizedBox(
              height: 20,
            ),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                Stack(clipBehavior: Clip.none, children: [
                                  Positioned(
                                    top: -40,
                                    left: 150,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      // clipBehavior: Clip.hardEdge,
                                      height: 75,
                                      width: 75,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(42),
                                          child: Image.asset(
                                              AppImages.profileImg)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          "Enumeral Waste Solutions Limited",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily:
                                                  AppFont.poppinsSemiBold),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AppColor.greenLight
                                                          .withOpacity(0.6)),
                                                  child: Icon(
                                                    Icons.person_outline_sharp,
                                                    color: AppColor.green,
                                                    size: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Contact Person",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AppColor.greenLight
                                                          .withOpacity(0.6)),
                                                  child: Icon(
                                                    Icons.email_outlined,
                                                    color: AppColor.green,
                                                    size: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Vendor@gmail.com",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: AppColor.greenLight
                                                          .withOpacity(0.6)),
                                                  child: Icon(
                                                    Icons.call_end_outlined,
                                                    color: AppColor.green,
                                                    size: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "+234 09-461-4000",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ],
                            );
                          },
                        );
                      },
                      child: senderMessagesCard(
                        context: context,
                        name: "Vendor Name",
                        message: "Hello",
                        profileImage: Image.asset(AppImages.profileImg),
                        time: "11 sept 2023 ,03:62 PM",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: DottedHorizontalDivider(
                      color: Colors.green,
                      spacing: 5.0,
                      strokeWidth: 2.0,
                      width: 340.0,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    receiveMessagesCard(
                      context: context,
                      name: "Admin Name",
                      message: "Hello",
                      profileImage: Image.asset(AppImages.profileImg),
                      time: "11 sept 2023 ,03:00 PM",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget senderMessagesCard({
    required String message,
    required String name,
    required BuildContext context,
    required Widget profileImage,
    required String time,
  }) {
    return Row(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(2),
          // clipBehavior: Clip.hardEdge,
          height: 70,
          width: 70,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(42), child: profileImage),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 12,
                        fontFamily: AppFont.poppinsBold),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        color: AppColor.grey1,
                        fontSize: 10,
                        fontFamily: AppFont.poppinsRegular),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: TextStyle(
                    color: AppColor.black.withOpacity(0.9),
                    fontSize: 12,
                    fontFamily: AppFont.poppinsRegular),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget receiveMessagesCard({
    required String message,
    required String name,
    required BuildContext context,
    required Widget? profileImage,
    required String time,
    String? attachment,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(2),
            // clipBehavior: Clip.hardEdge,
            height: 70,
            width: 70,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(42), child: profileImage),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 12,
                          fontFamily: AppFont.poppinsBold),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          color: AppColor.grey1,
                          fontSize: 10,
                          fontFamily: AppFont.poppinsRegular),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: AppColor.black.withOpacity(0.9),
                      fontSize: 12,
                      fontFamily: AppFont.poppinsRegular),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          // Visibility(
          //   visible: attachment != null && attachment != "",
          //   child: Container(
          //     clipBehavior: Clip.hardEdge,
          //     width: AppSize.getWidth(context) / 2,
          //     decoration:
          //         BoxDecoration(borderRadius: BorderRadius.circular(15)),
          //     child: FadeInImage.assetNetwork(
          //       placeholder: AppImages.loader,
          //       image: Endpoints.imageUrl + attachment.toString(),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
