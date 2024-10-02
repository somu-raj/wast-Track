import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/add_vendor_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Area%20Search%20Model/area_search_model.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/validation.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({super.key});

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  var areaSearchController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var companyNameController = TextEditingController();
  var companyAddressController = TextEditingController();
  var websiteController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? areaId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddVendorController(context: context),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 7, left: 15, right: 15),
          child: ListView(
            children: [
              const Text(
                "Vendor",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 18,
                    fontFamily: AppFont.poppinsBold),
              ),
              SizedBox(
                height: 10,
              ),
                ListView(
                   physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
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
                                          textHeading(text: 'Area'),
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
                                      CustomTextField(
                                        controller: areaSearchController,
                                        hintText: "Search Area",
                                        readOnly: true,
                                        onTap: (){
                                       controller.getAreaSearchApi(context, "").then(
                                           (value) {
                                             if(value != null) {
                                               showAreasList(controller)
                                                   ?.then((value) {
                                                 areaSearchController.text =
                                                     value;
                                               });
                                             }else{
                                               CustomSnackBar.mySnackBar(context, "Something Went Wrong!!");
                                             }
                                       });
                                        },
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return 'Please enter Area';
                                        //   }
                                        //   return null;
                                        // },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
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
                                      CustomTextField(
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
                                      CustomTextField(
                                        controller: companyAddressController,
                                        hintText: "Company Address",
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter company address';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          textHeading(text: 'WebSite(if any)'),
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
                                        controller: websiteController,
                                        hintText: "WebSite",
                                        hintStyle: TextStyle(
                                            color: AppColor.lightGrey,
                                            fontSize: 13,
                                            fontFamily: AppFont.poppinsRegular),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter WebSite';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          textHeading(text: 'Temporary Password'),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          controller.isLoading ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CupertinoActivityIndicator(),
                          ):
                          CustomButton(
                            // isLoading: authController.buttonLoader.value,
                            onPressed: () async {
                              if(formKey.currentState!.validate()) {
                                controller.addVendorApi(
                                    emailController.text.trim().toLowerCase(),
                                    passwordController.text,
                                    firstNameController.text,
                                    lastNameController.text,
                                    mobileController.text,
                                    companyNameController.text,
                                    companyAddressController.text,
                                    websiteController.text,
                                    areaId,
                                    context
                                ).then((value){
                                   clearAllController();
                                });
                              }
                            },
                            width: AppSize.getWidth(context),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColor.green),
                            buttonText: "Add Vendor",
                            textColor: AppColor.white,
                          ),
                        ],
                      ),

            ],
          ),
        );
      }
    );
  }
  clearAllController(){
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    mobileController.clear();
    companyNameController.clear();
    companyAddressController.clear();
    websiteController.clear();
    areaSearchController.clear();
    areaId = null;
  }
 Future<String>? showAreasList(AddVendorController controller) async {
   ValueNotifier<GetAreaSearchModel> searchAreaModel = ValueNotifier(controller.searchAreaModel!);

    (String?,String?)area = await showDialog(
        context: context,
        builder: (_){
          return Dialog(
            child:
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        hintText: "Search Area",
                        onChanged: (val){
                          controller.getAreaSearchApi(context, val).then(
                                  (value){
                                    searchAreaModel.value = value!;
                                  });
                        },
                        hintStyle: TextStyle(
                            color: AppColor.lightGrey,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsRegular),
                      ),
                      SizedBox(height: 10,),
                      Flexible(
                        child: ValueListenableBuilder(
                          valueListenable: searchAreaModel,
                          builder: (_,searchAreaModel,child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                    searchAreaModel.data.length == 0?
                                    Center(child: Text("No Area Found"),):
                                Flexible(
                                   child: ListView.builder(
                                   shrinkWrap: true,
                                   itemCount: searchAreaModel.data.length,
                                   itemBuilder: (_,index){
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        GestureDetector(
                                          onTap: (){
                                            
                                            if(searchAreaModel.data[index].isAlreadyAssigned??false){
                                              showAreaAlreadyAssignedDialog().then(
                                                      (value){
                                                        if(value??false){
                                                          Navigator.pop(context,(searchAreaModel.data[index].areaName,searchAreaModel.data[index].id));
                                                        }
                                                        else{
                                                          Navigator.pop(context);
                                                        }
                                                      });
                                            }
                                            else {
                                              Navigator.pop(context,
                                                  (searchAreaModel.data[index]
                                                      .areaName, searchAreaModel
                                                      .data[index].id));
                                            }
                                          },
                                          child: Text(
                                              searchAreaModel.data[index].areaName??"",
                                            style: TextStyle(
                                              fontSize: 16
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 2,)
                                      ],
                                    );
                                  }
              ),
            ),
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
          );
        }
    );
    areaId = area.$2;
    debugPrint("areaId = ${areaId}");
    return area.$1??"";
  }
   Future<bool?> showAreaAlreadyAssignedDialog() async {
    bool? confirm = await showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text("This area is already assigned to another vendor. Are you sure you want to proceed with the assignment?"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,true);
                  },
                  child: Text("Yes",style: TextStyle(color: AppColor.green),)),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,false);
                  },
                  child: Text("No",style: TextStyle(color: AppColor.redLight),)),
            ],
          );
        }
    );
    return confirm;
  }
}
