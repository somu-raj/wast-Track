import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_text_colorfield.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../Conrollers/Authentication Controller/authentication_controller.dart';
import '../../Utils/App Size/app_size.dart';
import '../../Utils/Components/app_font.dart';
import '../../Utils/colors/app_colors.dart';
import '../../Utils/validation.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  // final controller =
  //     Get.put<ForgetPasswordController>(ForgetPasswordController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? dropdownValue;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LoginController(),
         builder: (controller) =>
          SafeArea(
            child: Scaffold(
             body: Container(
               decoration: BoxDecoration(
               image: DecorationImage(
                image: AssetImage(
                    AppImages.background), // Replace with your image path
                fit: BoxFit.cover, // You can adjust the fit as needed
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: AppColor.black,
                      fontFamily: AppFont.poppinsBold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Enter your Email and we’ll send you a Login link to get back into your account.",
                    style: TextStyle(
                      fontFamily: AppFont.poppinsMedium,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/login_image.png',
                  height: 190,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Login as",
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
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColor.green,
                                  ),
                                  underline: Container(),
                                  hint: Text(
                                    'Select Account',
                                    style: TextStyle(
                                        color: AppColor.black.withOpacity(0.4)),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: "admin",
                                      child: Text(
                                        "Admin",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "subAdmin",
                                      child: Text(
                                        "Sub-Admin",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "vendor",
                                      child: Text(
                                        "Vendor",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "vendorStaff",
                                      child: Text(
                                        "Vendor-Staff",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "wasteManagementAgency",
                                      child: Text(
                                        "waste Management Agency",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "wasteManagementStaff",
                                      child: Text(
                                        "waste Management Staff",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "stateGovernmentAgency",
                                      child: Text(
                                        "State Government Agency",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    // Add more DropdownMenuItem widgets as needed
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Select your account type to get started with the password recovery process.",
                                  style: TextStyle(
                                    fontFamily: AppFont.poppinsMedium,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email Address",
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
                              CustomTextColorField(
                                validator: Validation.validateEmail,
                                controller: emailController,
                                hintText: "Enter Email  ID",
                                hintStyle: TextStyle(
                                    color: AppColor.lightGrey,
                                    fontSize: 13,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// Login Button
                                    CustomButton(
                                      // isLoading: authController.buttonLoader.value,
                                      onPressed: () async {
                                        if(emailController.text.isEmpty){
                                          CustomSnackBar.mySnackBar(context, "email is required");
                                        }else{
                                          controller.forgetPasswordApi(emailController.text, "", context);
                                          Navigator.pop(context);

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
                                      },
                                      width: AppSize.getWidth(context),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColor.green),
                                      buttonText: "Send Link",
                                      textColor: AppColor.white,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppScreen.login);
                                      },
                                      child: Text(
                                        "Back to Login  ",
                                        style: TextStyle(
                                            color: AppColor.green,
                                            fontSize: 15,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            )),
         ),
       )
    );
  }
}
