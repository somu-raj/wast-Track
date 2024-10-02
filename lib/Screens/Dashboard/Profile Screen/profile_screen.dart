
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Conrollers/Authentication%20Controller/profile_controller.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/Components/icon_card.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../../Models/Auth/profile_response_model.dart';
import '../../../Utils/Components/custom_sanckbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getRoleType();
    profileController = ProfileController(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    profileController.dispose();
  }

  String? userType;
  getRoleType() async {
    userType = await SharedPref().getUserType();
    //await profileController.getProfileApi(context);
    getProfileApi();

  }

  /// Get Profile Api
  ProfileResponseModel? model;
  getProfileApi() async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    setState(() {});
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var request = http.Request('GET', Uri.parse('${Endpoints.baseUrl}${Endpoints.profile}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = ProfileResponseModel.fromJson(jsonDecode(result));
      setState(() {
        model = finalResult;
      });
    }

    else {
      print(response.reasonPhrase);
    }

  }


  late ProfileController profileController;
  @override
  Widget build(BuildContext context) {
    return
      // GetBuilder(
      //   init:profileController,
      //   builder: (controller) =>
      Scaffold(
          body:  Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      model == null ? Center(child: Center(child: CupertinoActivityIndicator()))  :
                      model == null ? Text("Session expired. Please log in again"):
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              // clipBehavior: Clip.hardEdge,
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network("${model?.data?.imageBaseUrl}${model?.data?.imageName}",
                                  fit: BoxFit.cover,
                                  loadingBuilder: (_,child,loadingProgress){
                                    if(loadingProgress == null){
                                      return child;
                                    }
                                    // else if(loadingProgress.expectedTotalBytes == null){
                                    //   return  Image.asset(AppImages.profileImg,fit: BoxFit.fill,);
                                    // }
                                    else {
                                      return CupertinoActivityIndicator();
                                    }
                                  },
                                  errorBuilder: (context,_,__){
                                    return Image.asset(AppImages.profileImg,fit: BoxFit.fill,);
                                  },
                                ),
                              )

                            // ClipRRect(
                            //     borderRadius: BorderRadius.circular(100),
                            //     child: Image.network("${Endpoints.imageUrl}${controller.model!.data!.imageName}",fit: BoxFit.cover,),
                            //   errorBuilder: (context,_,__){
                            //     return Image.asset(AppImages.profileImg,fit: BoxFit.fill,);
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model?.data?.firstName}",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 13,
                                    fontFamily: AppFont.poppinsBold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${model?.data?.roleInfo?.roleName}",
                                style: TextStyle(
                                    color: AppColor.black.withOpacity(0.9),
                                    fontSize: 13,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Joined ${"${model!.data!.joinDate}"}",
                                style: TextStyle(
                                    color: AppColor.black.withOpacity(0.4),
                                    fontSize: 12,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                            ],
                          ),
                        ],
                      )

                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 15,
                            fontFamily: AppFont.poppinsBold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppScreen.editProfileScreen,arguments: model!.data!).then((value) {
                            getProfileApi();
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                iconCard(
                                    color: AppColor.pinkLight.withOpacity(0.2),
                                    icon: Icon(
                                      Icons.person_2_outlined,
                                      color: AppColor.pinkDark,
                                    ),
                                    height: 50,
                                    width: 50,
                                    radius: 30),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 15,
                                      fontFamily: AppFont.poppinsSemiBold),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.grey1.withOpacity(0.1)),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.black,
                                    size: 17,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppScreen.changePassword);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Settings",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 15,
                              fontFamily: AppFont.poppinsBold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                iconCard(
                                    color: AppColor.purpleLight.withOpacity(0.2),
                                    icon: Icon(
                                      Icons.lock_outlined,
                                      color: AppColor.midPurpleDark,
                                    ),
                                    height: 50,
                                    width: 50,
                                    radius: 30),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 15,
                                      fontFamily: AppFont.poppinsSemiBold),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.grey1.withOpacity(0.1)),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.black,
                                    size: 17,
                                  )),
                            )
                          ],
                        ),
                        userType =="1" || userType == "4"? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppScreen.notificationProfileScreen);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      iconCard(
                                          color: AppColor.blueLight.withOpacity(0.2),
                                          icon: Icon(
                                            Icons.notifications_none,
                                            color: AppColor.blueDark,
                                          ),
                                          height: 50,
                                          width: 50,
                                          radius: 30),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Notifications",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 15,
                                            fontFamily: AppFont.poppinsSemiBold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: AppColor.grey1.withOpacity(0.1)),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: AppColor.black,
                                          size: 17,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ):
                        const SizedBox.shrink(),

                        userType == "4" ?  GestureDetector(
                          onTap: () {

                            Navigator.pushNamed(
                                context, AppScreen.vendorBankDetailsScreen).then((value) => {
                              //getVendorBankDetailsApi(context)
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  iconCard(
                                      color: AppColor.greenLight.withOpacity(0.2),
                                      icon: Icon(
                                        Icons.location_city,
                                        color: AppColor.green,
                                      ),
                                      height: 50,
                                      width: 50,
                                      radius: 30),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Bank Details",
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 15,
                                        fontFamily: AppFont.poppinsSemiBold),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColor.grey1.withOpacity(0.1)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.black,
                                      size: 17,
                                    )),
                              )
                            ],
                          ),
                        ):SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Column(
                                    children: [
                                      Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.black),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(9),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(7),
                                                color: AppColor.green,
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontFamily:
                                                    AppFont.poppinsLight,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              getSignOut();
                                              //await SharedPreferences.getInstance();
                                              Navigator.pushNamed(context,AppScreen.login);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10,
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(7),
                                                color: AppColor.green,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'yes',
                                                  style: TextStyle(
                                                      fontFamily:
                                                      AppFont.poppinsLight,
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ), // show pop-up
                                );
                              },
                            );


                          },
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.redLight.withOpacity(0.2)),
                                child: Image.asset(
                                  height: 27,
                                  AppImages.logout,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Sign Out",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 15,
                                    fontFamily: AppFont.poppinsSemiBold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      );
    // );
  }


  getSignOut() async {
    model = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", false);
  }
  Widget listTile(
      {Widget? leading,
        required Widget title,
        double height = 30,
        double width = 30,
        required void Function()? onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: leading,
      title: title,
      trailing: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.grey1.withOpacity(0.1)),
        child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.black,
              size: 17,
            )),
      ),
    );
  }

// listTile(
//                 title: Row(
//                   children: [
//                     iconCard(
//                         color: AppColor.pinkLight.withOpacity(0.2),
//                         icon: Icon(
//                           Icons.person_2_outlined,
//                           color: AppColor.pinkDark,
//                         ),
//                         height: 60,
//                         width: 60,
//                         radius: 30),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Edit Profile",
//                       style: TextStyle(
//                           color: AppColor.black,
//                           fontSize: 16,
//                           fontFamily: AppFont.poppinsSemiBold),
//                     )
//                   ],
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, AppScreen.editProfileScreen);
//                 },
//               ),
}
