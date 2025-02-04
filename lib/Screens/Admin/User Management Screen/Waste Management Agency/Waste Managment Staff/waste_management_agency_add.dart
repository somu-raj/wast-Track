import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

import '../../../../../Conrollers/Admin/User Management Controller/eco_blue_sub_admin_controller.dart';
import '../../../../../Conrollers/Admin/User Management Controller/waste_angency_controller.dart';
import '../../../../../Models/User Management Model/Waste Management Agency/get_agency_model.dart';

class WasteManagementAgencyAddScreen extends StatefulWidget {
  final GetWasteAgencyModel? wasteModel;
  const WasteManagementAgencyAddScreen({super.key,this.wasteModel});

  @override
  State<WasteManagementAgencyAddScreen> createState() => _WasteManagementAgencyAddScreenState();
}

class _WasteManagementAgencyAddScreenState extends State<WasteManagementAgencyAddScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WasteManagementAgencyController(context: context),
        builder: (controller) => Scaffold(
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
                padding: EdgeInsets.all(10),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.wasteModel?.status == false ? Text(
                          'Waste Management Agency Add Details',
                          style: TextStyle(
                              color: AppColor.green,
                              fontSize: 16,
                              fontFamily: AppFont.poppinsBold),
                        ):Text(
                          'Waste Management Add Staff Details',
                          style: TextStyle(
                              color: AppColor.green,
                              fontSize: 16,
                              fontFamily: AppFont.poppinsBold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
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
                                                Row(
                                                  children: [
                                                    textHeading(
                                                        text: 'First Name'),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
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
                                                  controller:
                                                      firstNameController,
                                                  hintText: "First Name",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily: AppFont
                                                          .poppinsRegular),
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
                                                    textHeading(
                                                        text: 'Last Name'),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
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
                                                  controller:
                                                      lastNameController,
                                                  hintText: "Last Name",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily: AppFont
                                                          .poppinsRegular),
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
                                                    textHeading(
                                                        text: 'Phone Number'),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
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

                                                  maxLength: 10,
                                                  validator: Validation.validateMobile,
                                                  keyboardType: TextInputType.number,

                                                  controller: mobileController,
                                                  hintText: "Phone Number",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily: AppFont
                                                          .poppinsRegular),

                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),


                                                Row(
                                                  children: [
                                                    textHeading(text: 'Email Address'),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
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
                                                  keyboardType: TextInputType.emailAddress,

                                                  validator:
                                                      Validation.validateEmail,
                                                  controller: emailController,
                                                  hintText: "Enter Email ID",
                                                  hintStyle: TextStyle(
                                                      color: AppColor.lightGrey,
                                                      fontSize: 13,
                                                      fontFamily: AppFont
                                                          .poppinsRegular),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    textHeading(
                                                        text: 'Password'),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
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
                                                  height: 15,
                                                ),
                                              ],
                                            )),
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
                                  if((controller.wasteModel?.status != false)){
                                    if(formKey.currentState!.validate()) {
                                      print("Add Staff");
                                      print(controller.wasteModel!.data!.id);
                                      print(controller.wasteModel?.status);
                                      controller.addWasteStaffApi(
                                        emailController.text,
                                        passwordController.text,
                                        firstNameController.text,
                                        lastNameController.text,
                                        mobileController.text,
                                        controller.wasteModel!.data!.id,context,);

                                      // Future.delayed(Duration(milliseconds: 1000),(){
                                      //   return get();
                                      //
                                      // });
                                    }else{
                                      CustomSnackBar.mySnackBar(context, "All field are required");
                                    }
                                  }else{
                                    print("Add Agency");
                                    if(formKey.currentState!.validate()) {
                                      controller.addWasteAgencyApi(
                                          emailController.text,
                                          passwordController.text,
                                          firstNameController.text,
                                          lastNameController.text,
                                          mobileController.text,
                                          context);
                                      Future.delayed(Duration(milliseconds: 1000),(){
                                        return get();
                                      });
                                    }else{
                                      CustomSnackBar.mySnackBar(context, "All field are required");
                                    }
                                  }


                                },
                                width: AppSize.getWidth(context),
                                backgroundColor: MaterialStateProperty.all<Color>(AppColor.green),
                                buttonText:(controller.wasteModel?.status != false) ? "Add Staff" :"Add Agency",
                                textColor: AppColor.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
  get(){
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
  }
}
