import 'package:flutter/material.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class BatchDetails extends StatefulWidget {
  const BatchDetails({super.key});

  @override
  State<BatchDetails> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 7),
                Text(
                  'Kepa Waste Track',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFont.poppinsBold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Batch Number :",
                  style: TextStyle(
                      color: AppColor.grey1,
                      fontSize: 15,
                      fontFamily: AppFont.poppinsSemiBold),
                ),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                  child: Text(
                    "7478939872156",
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 17,
                        fontFamily: AppFont.poppinsBold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 7, bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 100.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 4.0),
                itemCount: 31,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    AppImages.qr,
                    height: 100,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
