import 'package:flutter/material.dart';
import 'package:waste_track/App%20Routes/app_routes.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool image = true;
  bool showText = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      toggleImage();
      // Show the text after another delay (e.g., 2 seconds)
      Future.delayed(Duration(milliseconds: 1300), () {
        toggleText();
        Future.delayed(Duration(milliseconds: 2000), () {
          Navigator.pushNamed(context, AppScreen.login);
        });
      });
    });
  }
  void toggleImage() {
    setState(() {
      image = !image;
    });
  }
  void toggleText() {
    setState(() {
      showText = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.splashScreen,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: image ? 200.0 : 100.0,
              height: image ? 200.0 : 100.0,
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            if (showText)
              Container(
                height: MediaQuery.of(context).size.width * 0.1,
                margin: EdgeInsets.all(10.0),
                child: SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.horizontal,
                  axisAlignment: -1,
                  child: Text(
                    'Kepa Waste Track',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Bold',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
