import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_track/API%20Integration/API%20URL%20endpoints/api_endpoints.dart';
import 'package:waste_track/Conrollers/Authentication%20Controller/profile_controller.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key,});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {



  final sharedPref = SharedPref();
  ImagePicker picker = ImagePicker();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _image;
  // //XFile? imagefile;
  // opengallery() async {
  //   var cameraStatus = await Permission.camera.status;
  //   var storageStatus = await Permission.storage.status;
  //
  //   PermissionStatus? cameraShowAlert;
  //   PermissionStatus? storageShowAlert;
  //
  //   if (!cameraStatus.isGranted) {
  //     cameraShowAlert = await Permission.camera.request();
  //   }
  //
  //   if (!storageStatus.isGranted) {
  //     storageShowAlert = await Permission.storage.request();
  //   }
  //
  //   if (await Permission.camera.isGranted) {
  //     if (await Permission.storage.isGranted) {
  //       imagefile = await picker.pickImage(
  //         source: ImageSource.gallery,
  //         imageQuality: 20,
  //       );
  //       if (imagefile != null) {
  //         setState(() {
  //           _image = File(imagefile!.path);
  //         });
  //
  //         // if (mounted) {
  //         //   showToast('Profile photo upadted successfully!...');
  //         // }
  //       }
  //     } else {
  //       print(
  //           "Camera needs to access your storage, please provide permission");
  //     }
  //   } else {
  //     if (cameraShowAlert == PermissionStatus.permanentlyDenied ||
  //         storageShowAlert == PermissionStatus.permanentlyDenied) {
  //       await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text('Requires Camera Permission'),
  //             content: const Text(
  //                 'This application requires access to your camera and storage'),
  //             actions: <Widget>[
  //               ElevatedButton(
  //                 child: const Text('Allow'),
  //                 onPressed: () async {
  //                   await openAppSettings();
  //                 },
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       print("Camera access denied!.. $cameraStatus and $storageStatus");
  //     }
  //   }
  // }
  //
  //
  // opencamera() async {
  //   var cameraStatus = await Permission.camera.status;
  //   var storageStatus = await Permission.storage.status;
  //
  //   PermissionStatus? cameraShowAlert;
  //   PermissionStatus? storageShowAlert;
  //
  //   if (!cameraStatus.isGranted) {
  //     cameraShowAlert = await Permission.camera.request();
  //   }
  //
  //   if (!storageStatus.isGranted) {
  //     storageShowAlert = await Permission.storage.request();
  //   }
  //
  //   if (await Permission.camera.isGranted) {
  //     if (await Permission.storage.isGranted) {
  //       imagefile = await picker.pickImage(
  //           source: ImageSource.camera, imageQuality: 20);
  //       if (imagefile != null) {
  //         setState(() {
  //           _image = File(imagefile!.path);
  //         });
  //
  //         //if (mounted) showToast("Profile photo upadted successfully!...");
  //       }
  //     } else {
  //       print("Camera needs to access your storage, please provide permission");
  //     }
  //   } else {
  //     if (cameraShowAlert == PermissionStatus.permanentlyDenied ||
  //         storageShowAlert == PermissionStatus.permanentlyDenied) {
  //       await showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: const Text('Requires Camera Permission'),
  //               content: const Text(
  //                   'This application requires access to your camera and storage'),
  //               actions: <Widget>[
  //                 ElevatedButton(
  //                   child: const Text('Allow'),
  //                   onPressed: () async {
  //                     await openAppSettings();
  //                   },
  //                 ),
  //                 ElevatedButton(
  //                   child: const Text('Cancel'),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             );
  //           });
  //     } else {
  //       print("Provide Camera permission to use camera.");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(context: context),
        builder: (controller) =>
            Scaffold(
                appBar: AppBar(
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
                body:controller.firstNameController.text.isEmpty ? myShimmer(): Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 17,
                            fontFamily: AppFont.poppinsBold),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Card(
                          elevation: 1,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius:BorderRadius.circular(100) ,
                                    child: Container(
                                        decoration:
                                        const BoxDecoration(shape: BoxShape.circle),
                                        padding: const EdgeInsets.all(2),
                                        clipBehavior: Clip.hardEdge,
                                        height: 150,
                                        width: 150,
                                        child: _image != null
                                            ? Image.file(
                                          _image!,
                                          // File(image?.path),
                                          fit: BoxFit.fill,
                                        )
                                            :  ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.network("${controller.model!.data!.imageBaseUrl}${controller.model!.data!.imageName}",
                                            fit: BoxFit.fill,
                                            errorBuilder: (context,_,__){
                                              return Image.asset(AppImages.profileImg,fit: BoxFit.fill,);
                                            },
                                          ),
                                        )

                                    ),
                                  ),
                                  Positioned(
                                    left: 110,
                                    top: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    const Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets.fromLTRB(
                                                            10, 10, 0, 5),
                                                        child: Text(
                                                          "Change Profile",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              color: AppColor.black),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.photo_album_rounded,
                                                          ),
                                                          color: AppColor.green,
                                                          iconSize: 30,
                                                          onPressed: () async {
                                                            // Navigator.pop(context);
                                                            //opengallery();
                                                            _getFromGallery();

                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.camera_alt_rounded),
                                                          color: AppColor.green,
                                                          iconSize: 30,
                                                          onPressed: () async {
                                                            //Navigator.pop(context);
                                                            //opencamera();
                                                            _getFromCamera();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );


                                            });


                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 3),
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColor.green),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            textHeading(text: 'First Name'),
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
                                          controller: controller.firstNameController,
                                          hintText: "First Name",
                                          hintStyle: TextStyle(
                                              color: AppColor.lightGrey,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsRegular),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter fist name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            textHeading(text: 'Last Name'),
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
                                          controller: controller.lastNameController,
                                          hintText: "Last Name",
                                          hintStyle: TextStyle(
                                              color: AppColor.lightGrey,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsRegular),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter last name';
                                            }
                                            return null;
                                          },
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
                                          controller: controller.emailController,
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
                                            textHeading(text: 'Designation'),
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
                                          readOnly: true,
                                          controller: controller.designationController,
                                          hintText: "Designation",
                                          hintStyle: TextStyle(
                                              color: AppColor.lightGrey,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsRegular),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter Designation';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   width: 150,
                      //   child:
                      //   controller.isLoading
                      //       ? CupertinoActivityIndicator() // Show activity indicator when loading
                      //       :
                      //   ElevatedButton(
                      //     onPressed: (){
                      //
                      //       controller.updateProfileApi(controller.firstNameController.text,controller.emailController.text,controller.lastNameController.text,context,File(_image!.path));
                      //
                      //     },
                      //     style: ButtonStyle(
                      //
                      //     ),
                      //     child: Text(
                      //       "Save",
                      //       style: TextStyle(color: Colors.amber),
                      //     ),
                      //   ),
                      // ),

                      CustomButton(
                        isLoading: controller.isLoading,
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            controller.updateProfileApi(controller.firstNameController.text,controller.emailController.text,controller.lastNameController.text,context,File(_image?.path??"")).then((value){
                              controller.getProfileApi(context);
                            } );
                          }

                        },
                        width: AppSize.getWidth(context),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.green),
                        buttonText: "Edit Profile ",
                        textColor: AppColor.white,
                      ),
                    ]),
                  ),
                ))
    );
  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var profileImage;
  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('${imageFile}gggggg');
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
}
