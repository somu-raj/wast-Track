import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

class VendorAreaAlloted extends StatefulWidget {
  const VendorAreaAlloted({super.key});

  @override
  State<VendorAreaAlloted> createState() => _VendorAreaAllotedState();
}

class _VendorAreaAllotedState extends State<VendorAreaAlloted> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            margin: const EdgeInsets.only(bottom: 6),
            child: Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Area:",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 12,
                          fontFamily: AppFont.poppinsSemiBold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: const Text(
                        "Lorem ipsum dolor sit amet. Nam ducimus repellendus At voluptatem",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 12,
                            fontFamily: AppFont.poppinsLight),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
