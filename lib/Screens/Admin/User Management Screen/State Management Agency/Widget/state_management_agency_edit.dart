import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Admin/User%20Management%20Controller/eco-blue_controller.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

import '../../../../../Conrollers/Admin/User Management Controller/state_government_angency_controller.dart';
import '../../../../../Models/User Management Model/State Goverment Agency/get_state_model.dart';

class StateManagementAgencyEdit extends StatefulWidget {
  final GetStateGovernmentModel? stateModel;
  const StateManagementAgencyEdit({super.key,this.stateModel});

  @override
  State<StateManagementAgencyEdit> createState() =>
      _StateManagementAgencyEditState();
}

class _StateManagementAgencyEditState extends State<StateManagementAgencyEdit> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isObscure =  false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StateGovernmentController(context: context),
        builder: (controller)=>
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
                padding: EdgeInsets.all(10),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Edit State Government Agency Details',
                          style: TextStyle(
                              color: AppColor.green,
                              fontSize: 15,
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
                                                controller:  controller.lastNameController,
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
                                                keyboardType: TextInputType.emailAddress,
                                                validator: Validation.validateEmail,
                                                controller:  controller.emailController,
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
                                                  textHeading(text: 'Mobile Number'),
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
                                                validator: Validation.validateMobile,
                                                hintText: "Enter Mobile Number",
                                                hintStyle: TextStyle(
                                                    color: AppColor.lightGrey,
                                                    fontSize: 13,
                                                    fontFamily: AppFont.poppinsRegular),
                                                maxLength: 10,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                    RegExp(r"\d"), // allow only numbers
                                                  )
                                                ],
                                                keyboardType: TextInputType.number,
                                                controller:controller.mobileController,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  textHeading(
                                                      text: 'Password'),
                                                  // const Padding(
                                                  //   padding: EdgeInsets.only(bottom: 5),
                                                  //   child: Icon(
                                                  //     Icons.star,
                                                  //     color: Colors.red,
                                                  //     size: 10,
                                                  //   ),
                                                  // )
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
                                                      hintText:
                                                      "Enter 8 characters or more",
                                                      hintStyle: TextStyle(
                                                          color: AppColor.lightGrey,
                                                          fontSize: 13,
                                                          fontFamily:
                                                          AppFont.poppinsRegular),
                                                      validator: (value){
                                                        if(value!.isNotEmpty){
                                                          if (value.length < 8) {
                                                            return "Should at least 8 characters";
                                                          }
                                                        }
                                                        return null;

                                                      },
                                                      //validator: Validation.validatePass,
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
                                          ),
                                        ),
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
                                  controller.
                                  updateStateGovernmentAgencyApi(
                                      controller.emailController.text,
                                      passwordController.text,
                                      controller.firstNameController.text,
                                      controller.lastNameController.text,
                                      controller.mobileController.text,
                                      controller.stateModel!.data!.id
                                  );
                                },
                                width: AppSize.getWidth(context),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(AppColor.green),
                                buttonText: "Update State Government",
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
            )
    );
  }
}
