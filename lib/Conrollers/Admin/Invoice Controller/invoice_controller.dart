import 'package:get/get.dart';

class InvoiceController extends GetxController {
  final RxList<bool> areOptionVisibleList =
      List.generate(10, (index) => false).obs;

  void ImageVisibility(int index) {
    areOptionVisibleList[index] = !areOptionVisibleList[index];
  }
}
