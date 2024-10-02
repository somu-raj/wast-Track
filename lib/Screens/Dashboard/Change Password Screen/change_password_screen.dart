import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Authentication%20Controller/update_password_controller.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:UpdatePasswordController(context: context),
         builder: (controller)=>
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
            body: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    " Change Password",
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
                            Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Current Password",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setTextField) {
                                          return CustomTextField(
                                            obscureText: _isObscure,
                                            fillColor: AppColor.white,
                                            hintText: "Enter 8 characters or more",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsRegular),
                                            validator: Validation.validatePass,
                                            controller: currentPasswordController,
                                            // suffixIcon: IconButton(
                                            //     icon: Icon(
                                            //         _isObscure
                                            //             ? Icons.visibility_off
                                            //             : Icons.visibility,
                                            //         color: AppColor.black,
                                            //         size: 14),
                                            //     onPressed: () {
                                            //       setTextField(() {
                                            //         _isObscure = !_isObscure;
                                            //       });
                                            //     }),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " New Password",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setTextField) {
                                          return CustomTextField(
                                            obscureText: _isObscure,
                                            fillColor: AppColor.white,
                                            hintText: "Enter 8 characters or more",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsRegular),
                                            validator: Validation.validatePass,
                                            controller: newPasswordController,
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                    _isObscure
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: AppColor.black,
                                                    size: 14),
                                                onPressed: () {
                                                  setTextField(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                }),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        " ConfirmPassword",
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: AppFont.poppinsMedium,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setTextField) {
                                          return CustomTextField(
                                            obscureText: _isObscure,
                                            fillColor: AppColor.white,
                                            hintText: "Enter 8 characters or more",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily: AppFont.poppinsRegular),
                                            validator: Validation.validatePass,
                                            controller: confirmNewPasswordController,
                                            // suffixIcon: IconButton(
                                            //     icon: Icon(
                                            //         _isObscure
                                            //             ? Icons.visibility_off
                                            //             : Icons.visibility,
                                            //         color: AppColor.black,
                                            //         size: 14),
                                            //     onPressed: () {
                                            //       setTextField(() {
                                            //         _isObscure = !_isObscure;
                                            //       });
                                            //     }),
                                          );
                                        }),
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
                  CustomButton(
                    isLoading: controller.isLoading,
                    onPressed: () async {
                      if(formKey.currentState!.validate()){
                        controller.updatePasswordApi(currentPasswordController.text,newPasswordController.text,confirmNewPasswordController.text,context);
                      }
                      // var isValidate = formKey.currentState?.validate();
                      // //  print("on tap 0");
                      // if (isValidate != null && isValidate == true) {
                      //   //  print("on tap 1");

                      //   if (mobileNumberController.text.isNotEmpty) {
                      //     var formData = dio.FormData.fromMap({
                      //       "phone": mobileNumberController.text,
                      //       "password": passwordController.text,
                      //       "current_gps_address": "",
                      //       "current_latitude": "",
                      //       // _currentPosition?.latitude,
                      //       "current_longitude": "",
                      //       // _currentPosition?.longitude,
                      //       "device_id": "",
                      //       // deviceId,
                      //       "device_information": "",
                      //       // deviceDetail.toJson(),
                      //       "device_contact": "",
                      //       // phoneContactList,
                      //       "fcmtoken": "tokenFcm"
                      //     });
                      //     //   print("testing");
                      //     // authController.login(context, formData,
                      //     //     mobileNumberController.text);
                      //   }
                      //   // }
                      // }
                      //Navigator.pushNamed(context, AppScreen.dashboard);
                      // showDialog(
                      // context: context,
                      // builder: (BuildContext context) {
                      //   Future.delayed(Duration(seconds: 1), () {
                      //     Navigator.pop(context);
                      //     Navigator.pop(context);
                      //   });
                      //
                      //   return CupertinoAlertDialog(
                      //     title: Row(
                      //       children: [
                      //         Container(
                      //           padding: EdgeInsets.all(10),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(30),
                      //             color: AppColor.green,
                      //           ),
                      //           child: Icon(
                      //             Icons.done,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //         Flexible(
                      //           child: Text(
                      //             " Password Changed Successfully",
                      //             style: TextStyle(
                      //                 fontSize: 15, color: AppColor.green),
                      //           ),
                      //         ),
                      //       ],
                      //     ), // show pop-up
                      //   );
                      // },
                      // );
                    },
                    width: AppSize.getWidth(context),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.green),
                    buttonText: "Save Changes",
                    textColor: AppColor.white,
                  ),
                ]),
              ),
            ))
         );


  }
}
