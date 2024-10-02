import 'package:get/get.dart';

class SubAdminVisibilityController extends GetxController {
  var editVisibleList = true.obs;
  var isShowVisible = true.obs;

  final RxList<bool> areOptionVisibleList ;
  SubAdminVisibilityController(this.areOptionVisibleList);
      // List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }

  void EditVisibility(int index) {
    editVisibleList.value = false;
  }

  void ShowVisibility(int index) {
    isShowVisible.value = false;
  }
}

class VendorVisibilityController extends GetxController {
  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }
}

class VendorStaffListVisibilityController extends GetxController {
  var isShowVisible = true.obs;

  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }

  void ShowVisibility() {
    isShowVisible.value = false;
  }

  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class NylonProductionController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class StateGovernmentAgencyController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class EnforcementTeamController extends GetxController {
  var isContainerVisible = true.obs;

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }
}

class WasteManagementController extends GetxController {
  var isAddStaffVisible = true.obs;
  var isContainerVisible = true.obs;
  var isWastManaVisible = true.obs;

  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }

  void AddStaffVisibility() {
    isAddStaffVisible.value = false;
  }

  void ContainerVisible() {
    isContainerVisible.value = false;
  }

  void ContainerHide() {
    isContainerVisible.value = true;
  }

  void WastManaVisible() {
    isWastManaVisible.value = false;
  }

  void WastManaHide() {
    isWastManaVisible.value = true;
  }
}

class NylonManagementDetailsVisibilityController extends GetxController {
   RxList<bool> areOptionVisibleList ;
   RxList<bool>? areOptionSelectedList ;

   NylonManagementDetailsVisibilityController(this.areOptionVisibleList);
      // List.generate(10, (index) => false).obs;
  // void initializeSelectedList(RxList<bool>? list){
  //   areOptionSelectedList = list;
  // }
  void toggleVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }
}
