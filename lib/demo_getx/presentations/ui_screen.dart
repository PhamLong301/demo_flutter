import 'package:demo_flutter/demo_getx/presentations/get_x_demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GetXUIDemo extends GetView<GetXControllerDemo> {
  const GetXUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final GetXControllerDemo _controller = Get.put(GetXControllerDemo());
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _controller.decrease();
                    },
                    child: const Text("-")),
                Obx(() => Text("${_controller.count}")),
                ElevatedButton(
                    onPressed: () {
                      _controller.increment();
                    },
                    child: const Text("+"))
              ],
            ),
            GetBuilder<GetXControllerDemo>(
              builder: (_) => Text(_controller.value),
            ),
            ElevatedButton(onPressed: () {
              _controller.updateValue();
            }, child: const Text('Press')),

            ElevatedButton(onPressed: () {
              Get.toNamed('/home');
            }, child: const Text('Go to'))
          ],
        ),
      ),
    );
  }
}

/*
class UIScreen extends StatefulWidget {
  const UIScreen({super.key});

  @override
  State<UIScreen> createState() => _UIScreenState();
}

class _UIScreenState extends State<UIScreen> {
  @override
  Widget build(BuildContext context) {
    final GetXControllerDemo _controller =
    Get.put(GetXControllerDemo());

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("-")),
            Obx(() =>  Text("${_controller.count}")),
            ElevatedButton(onPressed: () {}, child: Text("+"))
          ],
        ),
      ),
    );
  }
}
*/
