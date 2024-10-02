import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_text_colorfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

import '../../Conrollers/Authentication Controller/authentication_controller.dart';
import '../../Utils/Components/custom_sanckbar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var companyNameController = TextEditingController();
  var companyAddressController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;

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
                      children: [
                        const SizedBox(height: 70),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: AppColor.black,
                              fontFamily: AppFont.poppinsBold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/login_image.png',
                          height: 190,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 15, right: 15, top: 5),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    textHeading(text: 'First Name'),
                                                    const Padding(
                                                      padding:
                                                      EdgeInsets.only(bottom: 5),
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
                                                CustomTextColorField(
                                                  controller: nameController,
                                                  hintText: "First Name",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily:
                                                      AppFont.poppinsRegular),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter fist name';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    textHeading(text: 'Last Name'),
                                                    const Padding(
                                                      padding:
                                                      EdgeInsets.only(bottom: 5),
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
                                                CustomTextColorField(
                                                  controller: lastNameController,
                                                  hintText: "Last Name",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily:
                                                      AppFont.poppinsRegular),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter last name';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                      CustomTextColorField(
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
                                          textHeading(text: 'Phone Number'),
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
                                      CustomTextColorField(
                                        onChanged: (value) {
                                          if (value.length == 10) {
                                            FocusScope.of(context)
                                                .unfocus(); // disable keyboard
                                          }
                                        },
                                        maxLength: 10,
                                        hintText: "+234 00-000-0000",
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r"\d"), // allow only numbers
                                          )
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: mobileNumberController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your mobile number';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          textHeading(text: 'Company Name'),
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
                                      CustomTextColorField(
                                        controller: companyNameController,
                                        hintText: "Company Name",
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter company name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          textHeading(text: 'Company Address'),
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
                                      CustomTextColorField(
                                        controller:companyAddressController,
                                        hintText: "Company Address",
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter Company Address ';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          textHeading(text: 'Set Password'),
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
                                      StatefulBuilder(builder: (context, setTextField) {
                                        return CustomTextColorField(
                                          obscureText: _isObscure,
                                          fillColor: AppColor.white,
                                          hintText: "Enter 8 characters or more",
                                          hintStyle: TextStyle(
                                              color: AppColor.lightGrey,
                                              fontSize: 13,
                                              fontFamily: AppFont.poppinsRegular),
                                          validator: Validation.validatePass,
                                          controller: passwordController,
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
                                        height: 12,
                                      ),

                                      /// Login Button
                                     // controller.isLoading ? CupertinoActivityIndicator(
                                     //   radius: 15, color: Colors.amber,
                                     //   // color: !bgReverse ? Colors.white : color
                                     // ):
                                     // CustomButton(
                                     //    isLoading: controller.isLoading == false,
                                     //    onPressed: () async {
                                     //      if(formKey.currentState!.validate()){
                                     //        controller.registerApi(emailController.text, passwordController.text,nameController.text , lastNameController.text, mobileNumberController.text, companyNameController.text, companyAddressController.text, context);
                                     //        //     .then(
                                     //        //         (value){
                                     //        //     },
                                     //        //     onError: (e){
                                     //        //       CustomSnackBar.mySnackBar(context, e.toString());
                                     //        //     }
                                     //        // );
                                     //
                                     //      }else{
                                     //        CustomSnackBar.mySnackBar(context, "All field are required");
                                     //      }
                                     //      // var isValidate = formKey.currentState?.validate();
                                     //      // //  print("on tap 0");
                                     //      // if (isValidate != null && isValidate == true) {
                                     //      //   //  print("on tap 1");
                                     //
                                     //      //   if (mobileNumberController.text.isNotEmpty) {
                                     //      //     var formData = dio.FormData.fromMap({
                                     //      //       "phone": mobileNumberController.text,
                                     //      //       "password": passwordController.text,
                                     //      //       "current_gps_address": "",
                                     //      //       "current_latitude": "",
                                     //      //       // _currentPosition?.latitude,
                                     //      //       "current_longitude": "",
                                     //      //       // _currentPosition?.longitude,
                                     //      //       "device_id": "",
                                     //      //       // deviceId,
                                     //      //       "device_information": "",
                                     //      //       // deviceDetail.toJson(),
                                     //      //       "device_contact": "",
                                     //      //       // phoneContactList,
                                     //      //       "fcmtoken": "tokenFcm"
                                     //      //     });
                                     //      //     //   print("testing");
                                     //      //     // authController.login(context, formData,
                                     //      //     //     mobileNumberController.text);
                                     //      //   }
                                     //      //   // }
                                     //      // }
                                     //    },
                                     //    width: AppSize.getWidth(context),
                                     //    backgroundColor:
                                     //    MaterialStateProperty.all<Color>(
                                     //        AppColor.green),
                                     //    buttonText: "Register",
                                     //    textColor: AppColor.white,
                                     //  ),

                                      CustomButton(
                                        isLoading: controller.isLoading,
                                        onPressed: () async {
                                          if(formKey.currentState!.validate()){
                                            controller.registerApi(emailController.text, passwordController.text,nameController.text , lastNameController.text, mobileNumberController.text, companyNameController.text, companyAddressController.text, context);
                                            //     .then(
                                            //         (value){
                                            //     },
                                            //     onError: (e){
                                            //       CustomSnackBar.mySnackBar(context, e.toString());
                                            //     }
                                            // );

                                          }else{
                                            CustomSnackBar.mySnackBar(context, "All field are required");
                                          }
                                        },
                                        width: AppSize.getWidth(context),
                                        backgroundColor: MaterialStateProperty.all<Color>(AppColor.green),
                                        buttonText: "Register",
                                        textColor: AppColor.white,
                                      ),
                                      const SizedBox(
                                        height: 5,
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
                                        height: 20,
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            )
      );

  }
}
