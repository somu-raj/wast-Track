import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waste_track/Conrollers/Admin/Vender%20Mangagement%20Controller/add_area_controller.dart';

import '../../../../Utils/App Size/app_size.dart';
import '../../../../Utils/Components/app_font.dart';
import '../../../../Utils/Components/custom_button.dart';
import '../../../../Utils/Components/custom_sanckbar.dart';
import '../../../../Utils/Components/custom_textfield.dart';
import '../../../../Utils/Components/text_heading.dart';
import '../../../../Utils/behavior.dart';
import '../../../../Utils/colors/app_colors.dart';
import '../../../../Utils/images/images.dart';

class AddArea extends StatefulWidget {
  const AddArea({super.key});

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> with SingleTickerProviderStateMixin{

  late TabController tabAreaController;

  @override
  void initState() {
    super.initState();
    tabAreaController = TabController(length: 2, vsync: this);
  }
  String _filePath = '';
  void _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          _filePath = file.path;
        });
        //_readExcelFile(_filePath);
      } else {
        print('User canceled file picking');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }






  @override
  void dispose() {
    tabAreaController.dispose();
    super.dispose();
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final areaController  =  TextEditingController();
  bool isButtonSelected = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  AddAreaController(context: context),
      builder:(controller) =>
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Add Area',
                style: TextStyle(
                    color: AppColor.green,
                    fontSize: 17,
                    fontFamily: AppFont.poppinsBold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TabBar(
                  labelColor: AppColor.green,
                  labelStyle: TextStyle(fontSize: 15),
                  unselectedLabelColor: AppColor.grey1,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: AppColor.green, width: 2),
                    insets: EdgeInsets.symmetric(horizontal: 2),
                  ),
                  controller: tabAreaController,
                  tabs: const [
                    Tab(text: 'Enter Area'),
                    Tab(text: 'Import Area'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabAreaController,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                      key: formKey,
                      child: Column(

                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              textHeading(
                                  text: 'Add Area'),
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
                            areaController,
                            hintText: "Enter Area",
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
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            isLoading: controller.isLoading,
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                controller.addAreaApi(areaController.text, _filePath, context);
                               // controller.addEcoBlueSubAdminApi(emailController.text, passwordController.text, firstNameController.text, lastNameController.text, mobileController.text, context);
                              }else{
                                CustomSnackBar.mySnackBar(context, "All field are required");
                              }
                            },
                            width: AppSize.getWidth(context),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                AppColor.green),
                            buttonText: "Add Area",
                            textColor: AppColor.white,
                          ),

                        ],
                      )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                    Text(
                       'Weve got a sample template to help you get started\n Only .xls and .xlsx files are allowed',
                         style: TextStyle(
                     color: AppColor.black.withOpacity(0.5),
                       fontSize: 12,),
                      ),
                        SizedBox(height: 20,),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                             border: Border.all(color: AppColor.green),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_download_outlined,color: AppColor.black),
                              SizedBox(width: 5,),
                              Text("Download Sample",style: TextStyle(color: AppColor.black,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                       SizedBox(height:20,),
                        InkWell(
                          onTap: (){
                            _openFileExplorer();
                          },
                          child: Container(
                            height: _filePath.isEmpty ? 45:75,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.green,),

                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: _filePath.isEmpty ? 10:5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload_file_outlined,color: AppColor.black),
                                    SizedBox(width: 5,),
                                    Text("Upload Excel File",style: TextStyle(color: AppColor.black,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                SizedBox(height: 2,),
                                _filePath.isEmpty ?SizedBox():  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("${_filePath}",style: TextStyle(
                                      color: AppColor.black
                                  ),),
                                )
                              ],
                            ),
                          ),
                        ),
                       SizedBox(height: 20,),
                       InkWell(
                         onTap: (){
                        controller.addAreaApi(areaController.text, _filePath, context);
                         },
                         child: Container(
                           height: 45,
                           decoration: BoxDecoration(
                             color: AppColor.green,
                             borderRadius: BorderRadius.circular(10)
                           ),
                           child: Column(
                             children: [
                               SizedBox(height:10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Icons.upload_file_outlined,color: AppColor.white),
                                   SizedBox(width: 5,),
                                   Text("Upload Excel File",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),)
                                 ],
                               ),

                             ],
                           ),
                         ),
                       )


                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

}
