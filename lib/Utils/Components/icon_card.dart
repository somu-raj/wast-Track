import 'package:flutter/material.dart';

Widget iconCard(
    {required Widget icon,
    void Function()? onPressed,
    required Color color,
    double height = 30,
    double width = 30,
    double radius = 50}) {
  return Center(
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: 30,
      ),
    ),
  );
}
