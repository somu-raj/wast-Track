// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_track/Utils/colors/app_colors.dart';

// class CustomButtonAuth extends StatelessWidget {
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
//   const CustomButtonAuth(
//       {Key? key,
//       this.backgroundColor,
//       this.onPressed,
//       this.height = 50,
//       this.isLoading = false,
//       this.width = 0,
//       required this.buttonText,
//       this.textColor = AppColor.black,
//       this.foregroundColor,
//       this.fontWeight = FontWeight.bold,
//       this.fontSize = 20,
//       // this.fontFamily = AppFont.poppinsSemiBold,
//       this.radius = 10,
//       this.side,
//       this.loaderColor = AppColor.black})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         side: side,
//         elevation: MaterialStateProperty.all<double?>(0),
//         backgroundColor: MaterialStatePropertyAll(
//           Colors.transparent,
//         ),
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
//           borderRadius: BorderRadius.circular(10),
//           gradient: RadialGradient(
//             radius: 4,
//             colors: [AppColor.lightPurple, AppColor.lightCherry],
//           ),
//         ),
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
