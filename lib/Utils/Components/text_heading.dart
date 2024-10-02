import 'package:flutter/cupertino.dart';

import '../colors/app_colors.dart';
import 'app_font.dart';

Widget textHeading({required String text}) {
  var fontStyle = const TextStyle(
      color: AppColor.black, fontFamily: AppFont.poppinsMedium, fontSize: 14);
  return Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: Text(
      text,
      style: fontStyle,
    ),
  );
}
