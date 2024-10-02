import 'package:flutter/cupertino.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

Widget dot({double rightMargin = 0.0}) {
  return Container(
    margin: EdgeInsets.only(left: 5, right: rightMargin),
    width: 6,
    height: 6,
    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.black),
  );
}
