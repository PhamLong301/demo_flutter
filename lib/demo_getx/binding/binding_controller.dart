import 'package:get/get.dart';

class DemoBindingController extends GetxController{
 int currentValue = 10;

 @override
  void onInit() {
    currentValue++;
    super.onInit();
  }
}