import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_track/Conrollers/Authentication%20Controller/profile_controller.dart';

import '../../../Conrollers/Admin/Vender Mangagement Controller/get_vendors_controller.dart';
import '../../../Utils/App Size/app_size.dart';
import '../../../Utils/Components/app_font.dart';
import '../../../Utils/Components/custom_button.dart';
import '../../../Utils/Components/custom_textfield.dart';
import '../../../Utils/Components/text_heading.dart';
import '../../../Utils/colors/app_colors.dart';
import '../../../Utils/images/images.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileController? profileController;
    @override
  void initState() {
      profileController =  ProfileController(context: context);
    // TODO: implement initState
      profileController?.getVendorBankDetailsApi(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(context: context),
      builder:  (controller) =>
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
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text("Vendor Bank Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

                SizedBox(height: 30,),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            textHeading(text: 'Bank Name'),
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
                          controller: controller.bankNameController,
                          hintText: "Bank Name",
                          hintStyle: TextStyle(
                              color: AppColor.lightGrey,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsRegular),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter bank name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            textHeading(text: 'Account Holder Name'),
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
                        SizedBox(height: 5),
                        CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: controller.accountNumberController,
                          hintText: "Account Number",
                          hintStyle: TextStyle(
                              color: AppColor.lightGrey,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsRegular),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter account number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            textHeading(text: 'Account Holder Name'),
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
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: controller.accountHolderNameController,
                          hintText: "Account Holder Name",
                          hintStyle: TextStyle(
                              color: AppColor.lightGrey,
                              fontSize: 13,
                              fontFamily: AppFont.poppinsRegular),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter account holder name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 60),
                        CustomButton(
                          isLoading: controller.isLoading,
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              controller.updateBankDetails(controller.bankNameController.text,controller.accountNumberController.text,controller.accountHolderNameController.text).then((value) => controller.getProfileApi(context));
                            }else{
                              
                            }

                          },
                          width: AppSize.getWidth(context),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(AppColor.green),
                          buttonText: "Save Change ",
                          textColor: AppColor.white,
                        ),

                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
