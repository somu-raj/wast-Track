import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Screens/Login%20Screen/login_screen.dart';
import 'package:waste_track/Screens/Splash%20Screen/splash_screen.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import 'Screens/Dashboard/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  var isRegistered = prefs.getBool("isRegistered") ?? false;
  Widget widget = isLoggedIn
      ? DashBoard()
      : isRegistered
          ? const LoginScreen()
          : const SplashScreen();
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp(widgetDetail: widget));
}

class MyApp extends StatefulWidget {
  final Widget? widgetDetail;
  const MyApp({super.key, this.widgetDetail});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Kepa Waste Track',
        theme: ThemeData(
          dividerColor: Colors.transparent,
          scaffoldBackgroundColor: AppColor.backGround,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: widget.widgetDetail);
  }
}
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   // HttpClient createHttpClient(SecurityContext context){
//   //   return super.createHttpClient(context)
//   //     ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   // }
// }
