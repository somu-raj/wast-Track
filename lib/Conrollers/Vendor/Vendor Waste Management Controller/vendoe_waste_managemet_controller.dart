import 'package:get/get.dart';

class VendorWasteManagementController extends GetxController {
  var isShowVisible = true.obs;

  void ShowVisibility() {
    isShowVisible.value = false;
  }
}
