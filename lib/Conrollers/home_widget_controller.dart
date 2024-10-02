

import 'package:get/get.dart';

class HomeWidgetController extends GetxController{


  RxBool isLoading = false.obs;

  toggleLoader(){
    this.isLoading.value = !this.isLoading.value;
  }

}