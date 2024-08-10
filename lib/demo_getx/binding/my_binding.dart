import 'package:demo_flutter/demo_getx/binding/binding_controller.dart';
import 'package:get/get.dart';

class MyBinding implements Bindings{
  @override
  void dependencies() {
    // Get.lazyPut(() => DemoBindingController());
    Get.put(DemoBindingController());
  }

}