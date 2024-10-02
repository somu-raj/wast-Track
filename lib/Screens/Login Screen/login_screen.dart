import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:waste_track/Conrollers/home_widget_controller.dart';
import 'package:waste_track/Models/Auth/role_response_model.dart';
import 'package:waste_track/Screens/Qr%20Scanner/scanner_button.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/custom_button.dart';
import 'package:waste_track/Utils/Components/custom_sanckbar.dart';
import 'package:waste_track/Utils/Components/custom_text_colorfield.dart';
import 'package:waste_track/Utils/images/images.dart';
import '../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../App Routes/app_routes.dart';
import '../../Conrollers/Authentication Controller/authentication_controller.dart';
import '../../Utils/App Size/app_size.dart';
import '../../Utils/colors/app_colors.dart';
import '../../Utils/validation.dart';
import 'package:http/http.dart'as http;
String? newRoleID;
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  HomeWidgetController homeWidgetController = HomeWidgetController();

  // final authController = Get.put<Authenticate>(Authenticate());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? dropdownvalue,roleId;



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> roles = []; // List to hold role data
  String selectedRole = '';
  // Variable to store selected role
  //
  // Future<void> fetchData() async {
  //   try {
  //     var dio = Dio();
  //   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
  //   HttpClient()
  //     ..badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     Response response = await dio.get('http://matchitsports.com:3000/api/roles');
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> roleResponseModel = response.data['data'];
  //       roles = roleResponseModel.map((data) => data as Map<String, dynamic>).toList();
  //       print("this is a parameter---------->${roles}");
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load data: $e');
  //   }
  // }
  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: LoginController(),
        builder: (controller) =>
            Obx((){
              return SafeArea(
                child: Scaffold(
                  body:
                  homeWidgetController.isLoading.value?
                  Center(child: CupertinoActivityIndicator(
                    color: AppColor.green,
                  ),):
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.background),
                              // Replace with your image path
                              fit: BoxFit
                                  .cover, // You can adjust the fit as needed
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 90),
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontFamily: AppFont.poppinsBold,
                                  fontSize: 25,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/login_image.png',
                                height: 200,
                              ),
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // Align(
                                            //   alignment: Alignment.centerLeft,
                                            //   child: Text(
                                            //     "Login as",
                                            //     style: TextStyle(
                                            //       color: AppColor.black,
                                            //       fontFamily: AppFont.poppinsMedium,
                                            //       fontSize: 15,
                                            //     ),
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),

                                            // Container(
                                            //   padding: EdgeInsets.only(left: 10, right: 10),
                                            //   width: MediaQuery.of(context).size.width * 0.9,
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.white,
                                            //     borderRadius: BorderRadius.circular(10.0),
                                            //   ),
                                            //   child: DropdownButtonHideUnderline(
                                            //     child: DropdownButton2<RoleList>(
                                            //       hint: Text(
                                            //         'Login as',
                                            //         style: TextStyle(
                                            //           color: AppColor.black.withOpacity(0.4),
                                            //         ),
                                            //       ),
                                            //       value: roleList,
                                            //       onChanged: (RoleList? value) async {
                                            //         setState(() {
                                            //           roleList = value!;
                                            //           roleId = roleList?.id;
                                            //           newRoleID = roleList?.roleId;
                                            //
                                            //           SharedPref().setUserType(newRoleID!);
                                            //           print("roleId: $roleId");
                                            //           print("newRoleId: $newRoleID");
                                            //         });
                                            //       },
                                            //       items: model?.data.map((items) {
                                            //         return DropdownMenuItem(
                                            //           value: items,
                                            //           child: Column(
                                            //             crossAxisAlignment: CrossAxisAlignment.start,
                                            //             mainAxisAlignment: MainAxisAlignment.center,
                                            //             children: [
                                            //               Padding(
                                            //                 padding: const EdgeInsets.only(top: 2),
                                            //                 child: Container(
                                            //                   child: Padding(
                                            //                     padding: const EdgeInsets.only(top: 0),
                                            //                     child: Text(
                                            //                       items.roleName.toString(),
                                            //                       overflow: TextOverflow.ellipsis,
                                            //                       style: const TextStyle(color: AppColor.black),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         );
                                            //       }).toList(),
                                            //     ),
                                            //   ),
                                            // ),

                                            // model == null ? CupertinoActivityIndicator(
                                            //   radius: 15, color: Colors.amber,
                                            //   // color: !bgReverse ? Colors.white : color
                                            // ):
                                            // Container(
                                            //   //padding: EdgeInsets.only(left: 10, right: 10),
                                            //   width: MediaQuery.of(context).size.width * 0.9,
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.white,
                                            //     borderRadius: BorderRadius.circular(10.0),
                                            //   ),
                                            //   child: DropdownButtonHideUnderline(
                                            //     child: DropdownButton2<String>(
                                            //       value: dropdownvalue,
                                            //       underline: Container(),
                                            //       hint: Text(
                                            //         'Login as',
                                            //         style: TextStyle(
                                            //           color: AppColor.black.withOpacity(0.4),
                                            //         ),
                                            //       ),
                                            //       onChanged: (String? value) {
                                            //         setState(() {
                                            //
                                            //           dropdownvalue = value!;
                                            //           roleId = dropdownvalue;
                                            //            newRoleID = dropdownvalue;
                                            //
                                            //         });
                                            //       },
                                            //       items: model?.data.map((items) {
                                            //         return DropdownMenuItem<String>(
                                            //           value: items.id,
                                            //           child: Column(
                                            //             crossAxisAlignment: CrossAxisAlignment.start,
                                            //             mainAxisAlignment: MainAxisAlignment.center,
                                            //             children: [
                                            //               Padding(
                                            //                 padding: const EdgeInsets.only(top: 2),
                                            //                 child: Container(
                                            //                   child: Padding(
                                            //                     padding: const EdgeInsets.only(top: 0),
                                            //                     child: Text(
                                            //                       items.roleName.toString(),
                                            //                       overflow: TextOverflow.ellipsis,
                                            //                       style: const TextStyle(color: AppColor.black),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         );
                                            //       }).toList() ?? [],
                                            //     ),
                                            //   ),
                                            // ),

                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Email Address",
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily:
                                                  AppFont.poppinsMedium,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            CustomTextColorField(
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              validator:
                                              Validation.validateEmail,
                                              controller: emailController,
                                              hintText: "Enter Email  ID",
                                              hintStyle: TextStyle(
                                                  color: AppColor.lightGrey,
                                                  fontSize: 13,
                                                  fontFamily:
                                                  AppFont.poppinsRegular),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Password",
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily:
                                                  AppFont.poppinsMedium,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            StatefulBuilder(builder:
                                                (context, setTextField) {
                                              return CustomTextColorField(
                                                obscureText: _isObscure,
                                                fillColor: AppColor.white,
                                                hintText:
                                                "Enter 8 characters or more",
                                                hintStyle: TextStyle(
                                                    color: AppColor.lightGrey,
                                                    fontSize: 13,
                                                    fontFamily:
                                                    AppFont.poppinsRegular),
                                                validator:
                                                Validation.validatePass,
                                                controller: passwordController,
                                                suffixIcon: IconButton(
                                                    icon: Icon(
                                                        _isObscure
                                                            ? Icons
                                                            .visibility_off
                                                            : Icons.visibility,
                                                        color: AppColor.black,
                                                        size: 14),
                                                    onPressed: () {
                                                      setTextField(() {
                                                        _isObscure =
                                                        !_isObscure;
                                                      });
                                                    }),
                                              );
                                            }),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      AppScreen.forgetPassword);
                                                },
                                                child: Text(
                                                  "Forgot Password ?",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: AppColor.green,
                                                    fontFamily:
                                                    AppFont.poppinsSemiBold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),

                                            Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomButton(
                                                    isLoading:
                                                    controller.isLoading,
                                                    onPressed: () async {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        controller
                                                            .loginApi(
                                                            emailController
                                                                .text,
                                                            passwordController
                                                                .text,
                                                            roleId
                                                                .toString(),
                                                            context)
                                                            .then((value) {},
                                                            onError: (e) {
                                                              controller.isLoading =
                                                              false;
                                                              debugPrint(
                                                                  "this is log in error ====${e}");
                                                              CustomSnackBar
                                                                  .mySnackBar(
                                                                  context,
                                                                  e.toString());
                                                            });
                                                      } else {
                                                        CustomSnackBar.mySnackBar(
                                                            context,
                                                            "All field are required");
                                                      }
                                                    },
                                                    width: AppSize.getWidth(
                                                        context),
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all<Color>(
                                                        AppColor.green),
                                                    buttonText: "Login",
                                                    textColor: AppColor.white,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  ScannerButton(
                                                    onChange:
                                                        (loading,message,status) {
                                                      if(loading){
                                                        homeWidgetController.toggleLoader();
                                                      }
                                                      else{
                                                        homeWidgetController.toggleLoader();
                                                        showVerifyDialog(message, status);
                                                      }
                                                    },
                                                    loginScreen: true,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppScreen
                                                              .registration);
                                                    },
                                                    child: Text(
                                                      "Register as Vendor",
                                                      style: TextStyle(
                                                          color: AppColor.green,
                                                          fontSize: 15,
                                                          fontFamily: AppFont
                                                              .poppinsSemiBold),
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
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10,right: 10),
                      //   child: IconButton(
                      //       onPressed: (){},
                      //       icon: Icon(Icons.qr_code_scanner_rounded,size: 32,)),
                      // )
                    ],
                  ),
                ),
              );
            })
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      return getRole();
    });
  }

  showVerifyDialog(String message,bool status){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return CupertinoAlertDialog(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: status?AppColor.green:AppColor.redLight,
                ),
                child: Icon(
                  status? Icons.done:Icons.warning_amber,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10,),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 15,
                      color: status?AppColor.green:AppColor.redDark),
                ),
              ),
            ],
          ), // show pop-up
        );
      },
    );
  }

  RoleResponseModel? model  ;
  String? roleName;
  RoleList? roleList;
  getRole() async {
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    var request = http.Request('GET', Uri.parse('${Endpoints.baseUrl}${Endpoints.role}'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult  = RoleResponseModel.fromJson(json.decode(result));
      setState(() {
        model = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

}
