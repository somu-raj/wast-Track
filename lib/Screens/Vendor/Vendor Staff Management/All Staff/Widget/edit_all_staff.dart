import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Vendor/Staff%20%20Management%20Controller/staff_mangement_controller.dart';
import 'package:waste_track/Models/Vendor/Staff%20Management%20model/getVendorAllStaffModel.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';
import 'package:waste_track/Utils/validation.dart';

class EditAllVendorStaff extends StatefulWidget {
  const EditAllVendorStaff({super.key, this.data,});
  final VendorAllStaffData? data;

  @override
  State<EditAllVendorStaff> createState() => _EditAllVendorStaffState();
}

class _EditAllVendorStaffState extends State<EditAllVendorStaff> {
  final staffManagementController = Get.put(StaffManagementController());
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? id;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.data?.id;
    firstNameController.text =widget.data?.firstName??"";
    lastNameController.text = widget.data?.lastName??"";
    emailController.text = widget.data?.email??"";
    mobileController.text = widget.data?.phoneNumber??"";
    // final Map<String,dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    // if (args != null) {
    //   id = args['id'];
    //   firstNameController.text = args['first_name'];
    //   lastNameController.text = args['last_name'];
    //   emailController.text = args['email'];
    //   mobileController.text = args['phone_number'];
    //   // Use the id variable here as needed
    // }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final Map<String,dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
  //   if (args != null) {
  //       id = args['id'];
  //       firstNameController.text = args['first_name'];
  //       lastNameController.text = args['last_name'];
  //       emailController.text = args['email'];
  //       mobileController.text = args['phone_number'];
  //     // Use the id variable here as needed
  //   }
  //
  // }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final Map<String,dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    // if (args != null) {
    //   id = args['id'];
    //   firstNameController.text = args['first_name'];
    //   lastNameController.text = args['last_name'];
    //   emailController.text = args['email'];
    //   mobileController.text = args['phone_number'];
    //   // Use the id variable here as needed
    // }
   debugPrint("id===>$id");
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Edit Vendor Staff Details',
                  style: TextStyle(
                      color: AppColor.green,
                      fontSize: 17,
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
                                        controller: firstNameController,
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
                                        controller: lastNameController,
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
                                          textHeading(text: 'Contact Number'),
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
                                        controller: mobileController,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
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
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            staffManagementController.updateStaffApi(
                                context,
                                id,
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text,
                                mobileController.text);
                          }
                        },
                        width: AppSize.getWidth(context),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColor.green),
                        buttonText: "Save Changes",
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
    );
  }
}
