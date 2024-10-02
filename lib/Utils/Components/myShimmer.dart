import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../colors/app_colors.dart';

Widget myShimmer({double height = 80}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade300,
    enabled: true,
    child: ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: 10,
      itemBuilder: (context, index) => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            height: height,
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    ),
  );
}
