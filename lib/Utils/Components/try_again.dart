import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import 'custom_button.dart';

Widget tryAgain({required Function() onTap}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(child: Image.asset("AppImages.errorImg,height: 250")),
      const SizedBox(
        height: 10,
      ),
      CustomButton(
          height: 20,
          radius: 30,
          side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(width: 1, color: Colors.red)),
          backgroundColor: MaterialStateProperty.all<Color>(AppColor.blueLight),
          buttonText: "Try Again",
          fontSize: 14,
          textColor: Colors.black,
          onPressed: onTap),
    ],
  );
}
