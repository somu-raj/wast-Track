import 'package:get/get.dart';

class RevenueSharingController extends GetxController {
  RxBool isPercentageVisible = false.obs;
  RxBool isPercentageValueVisible = true.obs;
  RxBool isButtonEnabled = false.obs;

  void togglePercentageVisibility({bool enable = true}) {
    isPercentageVisible.value = !isPercentageVisible.value;
    isPercentageValueVisible.value = !isPercentageValueVisible.value;
    isButtonEnabled.value = !isButtonEnabled.value;
  }
}
