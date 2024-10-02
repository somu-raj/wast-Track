import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Dashboard/Home%20Screen/home_screen.dart';
import 'package:waste_track/Screens/Dashboard/Notification%20Screen/notification_screen.dart';
import 'package:waste_track/Screens/Dashboard/Profile%20Screen/profile_screen.dart';
import 'package:waste_track/Screens/Dashboard/Search%20Screen/search_screen.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class DashBoard extends StatefulWidget {

  @override
  DashBoardState createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
   List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
     NotificationScreen(),
    ProfileScreen(),
  ];

  var currentIndex = 0;
  bool isLoading = true;
  String? userType;
  getUserType() async {
    userType = await SharedPref().getUserType();
    debugPrint("user type ==> $userType");
    isLoading = false;
    setState(() {});
    // if(userType =="1" || userType == "4"){
    //   screens = [
    //     HomeScreen(),
    //     SearchScreen(),
    //     NotificationScreen(),
    //     ProfileScreen(),
    //   ];
    //   listOfIcons = [
    //     Icons.home_outlined,
    //     Icons.search,
    //     Icons.notifications_none_outlined,
    //     Icons.person_rounded,
    //   ];
    //   listOfStrings = [
    //     'Home',
    //     'Search',
    //     'Notifications',
    //     'Profile',
    //   ];
    // }
  }


  List<IconData> listOfIcons = [
    Icons.home_outlined,
    Icons.search,
    Icons.notifications_none_outlined,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Search',
    'Notifications',
    'Profile',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserType();
  }
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
         bool exit = await showDialog(
              context: context,
              builder: (_) {
                return  AlertDialog(
                  title: Text("Do you want to Exit App?"),
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
              });
         return exit;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
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
        body: isLoading? Center(child: CupertinoActivityIndicator(),):screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          margin: EdgeInsets.only(
              top: 0,
              left: displayWidth * .05,
              right: displayWidth * .05,
              bottom: displayWidth * .05),
          height: displayWidth * .155,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: currentIndex == 0
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: currentIndex == 0
                                  ? Colors.white
                                  : Colors.black26,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.home_outlined,
                          color: Colors.black26,
                        ),
                      ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: currentIndex == 1
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: currentIndex == 1
                                  ? Colors.white
                                  : Colors.black26,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.search, color: Colors.black26),
                      ),
              ),
              userType =="1"||userType =="4"? InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: currentIndex == 2
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: currentIndex == 2
                                  ? Colors.white
                                  : Colors.black26,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.notifications_none_outlined,
                            color: Colors.black26),
                      ),
              ): const SizedBox.shrink(),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: currentIndex == 3
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              color: currentIndex == 3
                                  ? Colors.white
                                  : Colors.black26,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.black26,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
