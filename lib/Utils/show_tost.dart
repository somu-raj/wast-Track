import 'package:fluttertoast/fluttertoast.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

void showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.blueLight,
      textColor: AppColor.black,
      fontSize: 16.0,
    );
