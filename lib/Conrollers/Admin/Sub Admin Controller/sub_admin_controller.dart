import 'package:get/get.dart';

class AdminSubAdminController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}
