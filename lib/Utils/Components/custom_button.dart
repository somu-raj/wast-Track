// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_track/Utils/colors/app_colors.dart';
//
// class CustomButton extends StatelessWidget {
//   final MaterialStateProperty<Color?>? backgroundColor;
//   final MaterialStateProperty<Color?>? foregroundColor;
//   final MaterialStateProperty<BorderSide?>? side;
//   final void Function()? onPressed;
//   final double? height;
//   final double? width;
//   final String buttonText;
//   final Color? textColor;
//   final bool isLoading;
//   final FontWeight? fontWeight;
//   final double? fontSize;
//   //final String? fontFamily;
//   final double radius;
//   final Color? loaderColor;
//   const CustomButton(
//       {Key? key,
//       this.backgroundColor,
//       this.onPressed,
//       this.height = 50,
//       this.isLoading = false,
//       this.width = 150,
//       required this.buttonText,
//       this.textColor = AppColor.black,
//       this.foregroundColor,
//       this.fontWeight = FontWeight.bold,
//       this.fontSize = 18,
//       // this.fontFamily = AppFont.poppinsSemiBold,
//       this.radius = 10,
//       this.side,
//       this.loaderColor = AppColor.black})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         side: side,
//         elevation: MaterialStateProperty.all<double?>(0),
//         backgroundColor: backgroundColor,
//         foregroundColor: foregroundColor,
//         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radius),
//         )),
//       ),
//       onPressed: !isLoading ? onPressed : null,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//             // gradient: LinearGradient(
//             //   begin: Alignment.bottomCenter,
//             //   end: Alignment.topCenter,
//             //   stops: [0.5, 0.91],
//             //   colors: [
//             //     AppColor.lightPurple.withOpacity(0.4),
//             //     AppColor.lightCherry.withOpacity(0.5)
//             //   ],
//             // ),
//             ),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 500),
//           transitionBuilder: (Widget child, Animation<double> animation) {
//             return ScaleTransition(scale: animation, child: child);
//           },
//           child: isLoading
//               ? CupertinoActivityIndicator(
//                   radius: 15, color: loaderColor,
//                   // color: !bgReverse ? Colors.white : color
//                 )
//               : Text(
//                   buttonText,
//                   style: TextStyle(
//                     fontWeight: fontWeight,
//                     color: textColor,
//                     // fontFamily: fontFamily,
//                     fontSize: fontSize,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomButton extends StatelessWidget {
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
  //final String? fontFamily;
  final double radius;
  final Color? loaderColor;

  const CustomButton({
    this.backgroundColor,
      this.onPressed,
      this.height = 50,
      this.isLoading = false,
      this.width = 150,
      required this.buttonText,
      this.textColor = AppColor.black,
      this.foregroundColor,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 18,
      // this.fontFamily = AppFont.poppinsSemiBold,
      this.radius = 10,
      this.side,
      this.loaderColor = AppColor.black});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child:
      isLoading
          ? CupertinoActivityIndicator() // Show activity indicator when loading
          :
      ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}



