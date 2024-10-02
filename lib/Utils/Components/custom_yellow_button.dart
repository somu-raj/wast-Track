import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class CustomYellowButton extends StatelessWidget {
  final MaterialStateProperty<Color?>? backgroundColor;
  final MaterialStateProperty<Color?>? foregroundColor;
  final MaterialStateProperty<BorderSide?>? side;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final String buttonText;
  final Color? textColor;
  final bool isLoading;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamily;
  final double radius;
  final Color? loaderColor;
  const CustomYellowButton(
      {Key? key,
      this.backgroundColor,
      this.onPressed,
      this.height = 50,
      this.isLoading = false,
      this.width = 350,
      required this.buttonText,
      this.textColor = AppColor.black,
      this.foregroundColor,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 15,
      // this.fontFamily = AppFont.poppinsSemiBold,
      this.radius = 30,
      this.side,
      this.loaderColor = AppColor.black,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        side: side,
        elevation: MaterialStateProperty.all<double?>(0),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        )),
      ),
      onPressed: !isLoading ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isLoading
              ? CupertinoActivityIndicator(
                  radius: 15,
                  color: loaderColor,
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: fontWeight,
                    color: textColor,
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                  ),
                ),
        ),
      ),
    );
  }
}
