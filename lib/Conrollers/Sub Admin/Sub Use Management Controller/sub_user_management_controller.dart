import 'package:get/get.dart';

class VendorController extends GetxController {
  var isContainerVisible = true.obs;
  var isShowVisible = true.obs;
  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }

  void ShowVisibility() {
    isShowVisible.value = false;
  }
}
class WasteManagementAgeController extends GetxController {
  var isContainerVisible = true.obs;
  var isContainerStaffVisible = true.obs;
  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }

  void ContainerStaffVisible() {
    isContainerStaffVisible.value = false;
  }

  void ContainerStaffHide() {
    isContainerStaffVisible.value = true;
  }
}

class NylonProCompanyController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class StateGovAgencyController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class EnforcementController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}
