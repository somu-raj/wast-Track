import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/add_vendor_controller.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/get_vendors_controller.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Area%20Search%20Model/area_search_model.dart';
import 'package:waste_track/Models/Vendor%20Management%20Model/Get%20Vendors%20Model/get_vendors_model.dart';
import 'package:waste_track/Utils/App%20Size/app_size.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_textfield.dart';
import 'package:waste_track/Utils/Components/text_heading.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../../../Utils/Components/app_font.dart';
import '../../../../../../Utils/validation.dart';

class AllVendorEdit extends StatefulWidget {
  const AllVendorEdit({super.key, this.vendorsData});
  final VendorsData? vendorsData ;

  @override
  State<AllVendorEdit> createState() => _AllVendorEditState();
}

class _AllVendorEditState extends State<AllVendorEdit> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var companyNameController = TextEditingController();
  var companyAddressController = TextEditingController();
  var websiteController = TextEditingController();
  var areaSearchController = TextEditingController();
  String? areaId;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;



  @override
  void initState() {
    _addVendorController = AddVendorController(context: context);
    _addVendorController.getAreaSearchApi(context, "").then(
            (value){
              debugPrint("data ${value?.data.first.id}");
              debugPrint("data ${widget.vendorsData?.areaId}");
              debugPrint("area name ${value?.data.where((element){
                return element.id == widget.vendorsData?.areaId;
              }).first.areaName}");
              areaSearchController.text = value?.data.where((element){
                return widget.vendorsData?.areaId == element.id;
              }).first.areaName??"";
            }
    );
    // TODO: implement initState
    super.initState();
    firstNameController.text = widget.vendorsData?.firstName??"";
    lastNameController.text = widget.vendorsData?.lastName??"";
    emailController.text = widget.vendorsData?.email??"";
    mobileController.text = widget.vendorsData?.phoneNumber??"";
    // passwordController.text = widget.vendorsData?.??"";
    companyNameController.text = widget.vendorsData?.companyName??"";
        companyAddressController.text =widget.vendorsData?.companyAddress??"";
    websiteController.text = widget.vendorsData?.website??"";
    areaId = widget.vendorsData?.areaId;
     // areaSearchController.text = _addVendorController.searchAreaModel?.data.first.areaName??"";
  }
 late AddVendorController _addVendorController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _addVendorController,
      builder: (controller) {
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
            padding: EdgeInsets.all(10),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Edit Vendor Details',
                      style: TextStyle(
                          color: AppColor.green,
                          fontSize: 17,
                          fontFamily: AppFont.poppinsBold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
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
                                              textHeading(text: 'Area'),
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
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Area';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
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
                                          CustomTextField(
                                            controller: firstNameController,
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
                                          const SizedBox(
                                            height: 15,
                                          ),
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
                                          CustomTextField(
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
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              textHeading(text: 'Email'),
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
                                          CustomTextField(
                                            validator: Validation.validateEmail,
                                            controller: emailController,
                                            hintText: "Enter Email ID",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsRegular),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              textHeading(text: 'Phone Number'),
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
                                          CustomTextField(
                                            validator: Validation.validateMobile,
                                            hintText: "Enter Mobile Number",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsRegular),
                                            maxLength: 10,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r"\d"), // allow only numbers
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
                                          CustomTextField(
                                            controller: companyNameController,
                                            hintText: "Company Name",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsRegular),
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
                                              textHeading(
                                                  text: 'Company Address'),
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
                                          CustomTextField(
                                            controller: companyAddressController,
                                            hintText: "Company Address",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsRegular),
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
                                              textHeading(text: 'WebSite'),
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
                                          CustomTextField(
                                            controller: websiteController,
                                            hintText: "WebSite",
                                            hintStyle: TextStyle(
                                                color: AppColor.lightGrey,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsRegular),
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
                                              textHeading(text: 'Password'),
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
                                                  // validator: Validation.validatePass,
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
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              controller.updateVendorsApi(
                                  emailController.text.trim().toLowerCase(),
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  mobileController.text,
                                  areaId,
                                  companyNameController.text,
                                  companyAddressController.text,
                                  websiteController.text,
                                  widget.vendorsData?.id);
                            }

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     Future.delayed(Duration(seconds: 1), () {
                            //       Navigator.pop(context);
                            //       Navigator.pop(context);
                            //     });
                            //
                            //     return CupertinoAlertDialog(
                            //       title: Row(
                            //         children: [
                            //           Container(
                            //             padding: EdgeInsets.all(10),
                            //             decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(30),
                            //               color: AppColor.green,
                            //             ),
                            //             child: Icon(
                            //               Icons.done,
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //           Flexible(
                            //             child: Text(
                            //               " Changes Saved Successfully",
                            //               style: TextStyle(
                            //                   fontSize: 15,
                            //                   color: AppColor.green),
                            //             ),
                            //           ),
                            //         ],
                            //       ), // show pop-up
                            //     );
                            //   },
                            // );
                          },
                          width: AppSize.getWidth(context),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColor.green),
                          buttonText: "Save Changes",
                          textColor: AppColor.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
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
