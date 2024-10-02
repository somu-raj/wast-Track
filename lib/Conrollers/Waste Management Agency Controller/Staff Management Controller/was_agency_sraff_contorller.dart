import 'package:get/get.dart';

class WasAgencyStaffManagementController extends GetxController {
  var isContainerVisible = true.obs;

  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}
