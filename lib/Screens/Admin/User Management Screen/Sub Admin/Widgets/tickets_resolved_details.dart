import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/divider/horizontal_doted_divider.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

class TicketsResolvedDetails extends StatefulWidget {
  const TicketsResolvedDetails({super.key});

  @override
  State<TicketsResolvedDetails> createState() => _TicketsResolvedDetailsState();
}

class _TicketsResolvedDetailsState extends State<TicketsResolvedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
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
        padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Ticket Id : #${"121255"}",
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 15,
                      fontFamily: AppFont.poppinsBold),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ticket Information",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: AppFont.poppinsSemiBold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ticket Opened by:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppFont.poppinsSemiBold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outline_sharp,
                                            color: AppColor.green,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Enumeral Waste Solutions Limited",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor.grey1,
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Vendor@gmail.com",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColor.black
                                                          .withOpacity(0.4),
                                                      fontFamily: AppFont
                                                          .poppinsMedium),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          " Also on this Ticket:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppFont.poppinsSemiBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline_sharp,
                                              color: AppColor.green,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Admin Name",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.grey1,
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Admin@gmail.com",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline_sharp,
                                              color: AppColor.green,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Sub-Admin",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.grey1,
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "subAdmin@gmail.com",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColor.black
                                                            .withOpacity(0.4),
                                                        fontFamily: AppFont
                                                            .poppinsMedium),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AppImages.info,
                    height: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Withdraw related issue",
              style: TextStyle(
                  color: AppColor.green,
                  fontSize: 15,
                  fontFamily: AppFont.poppinsBold),
            ),
            const SizedBox(
              height: 20,
            ),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(2),
                          // clipBehavior: Clip.hardEdge,
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(42),
                              child: Image.asset(AppImages.profileImg)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Vendor Name",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 12,
                                      fontFamily: AppFont.poppinsBold),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "11 sept 2023 ,03:62 PM",
                                  style: TextStyle(
                                      color: AppColor.grey1,
                                      fontSize: 10,
                                      fontFamily: AppFont.poppinsRegular),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Okay,Thanks",
                              style: TextStyle(
                                  color: AppColor.black.withOpacity(0.9),
                                  fontSize: 12,
                                  fontFamily: AppFont.poppinsRegular),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: DottedHorizontalDivider(
                      color: Colors.green,
                      spacing: 5.0,
                      strokeWidth: 2.0,
                      width: 340.0,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(2),
                              // clipBehavior: Clip.hardEdge,
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(42),
                                  child: Image.asset(AppImages.profileImg)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Vendor Name",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 12,
                                          fontFamily: AppFont.poppinsBold),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "11 sept 2023 ,03:62 PM",
                                      style: TextStyle(
                                          color: AppColor.grey1,
                                          fontSize: 10,
                                          fontFamily: AppFont.poppinsRegular),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "Dear Vendor Name,I am writing to apologize for the delay in processing your withdrawal request. We understand that you need access to these funds, and we are working hard to get them to you as soon as possible.We have investigated the matter, and we have determined that the delay was due to a technical issue. This issue has been resolved, and your withdrawal request is now being processed.We expect that the funds will be deposited into your bank account within 3 business days. You will receive an email notification once the funds have been deposited.We appreciate your patience and understanding. If you have any further questions or concerns, please do not hesitate to contact us.Sincerely,Admin Name",
                          style: TextStyle(
                              color: AppColor.black.withOpacity(0.9),
                              fontSize: 12,
                              fontFamily: AppFont.poppinsRegular),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: DottedHorizontalDivider(
                      color: Colors.green,
                      spacing: 5.0,
                      strokeWidth: 2.0,
                      width: 340.0,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(2),
                          // clipBehavior: Clip.hardEdge,
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(42),
                              child: Image.asset(AppImages.profileImg)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Vendor Name",
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 12,
                                        fontFamily: AppFont.poppinsBold),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "11 sept 2023 ,03:62 PM",
                                    style: TextStyle(
                                        color: AppColor.grey1,
                                        fontSize: 10,
                                        fontFamily: AppFont.poppinsRegular),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "I am not able to withdraw my money even after you accepted my withdrawal request.",
                                style: TextStyle(
                                    color: AppColor.black.withOpacity(0.9),
                                    fontSize: 12,
                                    fontFamily: AppFont.poppinsRegular),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var p1 = const Offset(90.0, 100.0);
    var p2 = const Offset(300.0, 100.0);
    var paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
