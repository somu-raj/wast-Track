import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

class NylonManagementCreateTicket extends StatefulWidget {
  const NylonManagementCreateTicket({super.key});

  @override
  State<NylonManagementCreateTicket> createState() => _NylonManagementCreateTicketState();
}

class _NylonManagementCreateTicketState extends State<NylonManagementCreateTicket> {
  var nameController = TextEditingController();
  var subjectController = TextEditingController();
  var emailController = TextEditingController();
  var messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _image;
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

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
        //    print("Camera needs to access your storage, please provide permission");
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.redDark),
                      textColor: AppColor.black,
                      buttonText: 'Allow',
                      onPressed: () async {
                        await openAppSettings();
                        Navigator.pop(context);
                      },
                    ),
                    CustomButton(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.black),
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
        //    print("Camera access denied!.. $cameraStatus and $storageStatus");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
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
        padding: const EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              Text(
                "Create Ticket",
                style: TextStyle(
                    color: AppColor.green,
                    fontSize: 18,
                    fontFamily: AppFont.poppinsBold),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Card(
                        elevation: 1,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    textHeading(text: 'Name'),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  controller: nameController,
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsRegular),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please enter name';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    textHeading(text: 'Email'),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  validator: Validation.validateEmail,
                                  controller: emailController,
                                  hintText: "Enter Email ID",
                                  hintStyle: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsRegular),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    textHeading(text: 'Subject'),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  controller: subjectController,
                                  hintText: "Subject",
                                  hintStyle: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsRegular),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please enter Subject';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    textHeading(text: 'Message'),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  controller: messageController,
                                  hintText: "Message",
                                  hintStyle: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontSize: 13,
                                      fontFamily: AppFont.poppinsRegular),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please enter Subject';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _image != null
                                    ? Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: AppSize.getWidth(context),
                                            clipBehavior: Clip.hardEdge,
                                            margin: EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            child: Image.file(
                                              _image!,
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  _image = null;
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: AppColor.black,
                                                )),
                                          )
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          openGallery();
                                        },
                                        child: DottedBorder(
                                          dashPattern: [20, 5],
                                          color: AppColor.green,
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(12),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColor.greenLight
                                                  .withOpacity(0.4),
                                            ),
                                            height: 100,
                                            width: AppSize.getWidth(context),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                    child: Icon(
                                                  Icons.upload_file,
                                                  color: AppColor.green,
                                                )),
                                                Text(
                                                  "Click or drag a file to this area to upload",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
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
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Column(
                                    children: [
                                      Text(
                                        "Are you sure you want to Reset this Ticket?",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.black),
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
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  Future.delayed(
                                                      Duration(seconds: 1), () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  });

                                                  return CupertinoAlertDialog(
                                                    title: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color:
                                                                AppColor.green,
                                                          ),
                                                          child: Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            "Ticket Reset Successfully",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: AppColor
                                                                    .green),
                                                          ),
                                                        ),
                                                      ],
                                                    ), // show pop-up
                                                  );
                                                },
                                              );
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
                                top: 12.0, right: 30, left: 30, bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.green),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });

                                return CupertinoAlertDialog(
                                  title: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: AppColor.green,
                                        ),
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Ticket Created Successfully",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.green),
                                        ),
                                      ),
                                    ],
                                  ), // show pop-up
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 12.0, right: 25, left: 25, bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.green),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontFamily: AppFont.poppinsSemiBold,
                                  color: Colors.white),
                            ),
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
      ),
    );
  }
}
