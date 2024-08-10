import 'package:demo_flutter/demo_getx/binding/binding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIBindingScreen extends StatelessWidget {
  const UIBindingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text("${Get.find<DemoBindingController>().currentValue}"),
      ),
    ));
  }
}
