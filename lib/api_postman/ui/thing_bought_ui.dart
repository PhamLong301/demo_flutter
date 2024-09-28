import 'package:demo_flutter/api_postman/controller/thing_bought_controller.dart';
import 'package:demo_flutter/storages/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ThingBoughtUI extends StatefulWidget {
  const ThingBoughtUI({super.key});

  @override
  State<ThingBoughtUI> createState() => _ThingBoughtUIState();
}

class _ThingBoughtUIState extends State<ThingBoughtUI> {
  late ThingBoughtController thingBoughtController;
  late TextEditingController thingController;
  late TextEditingController costController;

  @override
  void initState() {
    thingBoughtController = Get.put(ThingBoughtController());
    thingController = TextEditingController();
    costController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thing Bougth'),
        actions: [
          IconButton(onPressed: () async {
            await thingBoughtController.refreshThingsBought();
          }, icon: const Icon(Icons.refresh),),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = thingBoughtController.thingBought[index];
              return boughtItem(name: item.title ?? '', cost: item.cost ?? '',
              itemID: item.id ?? '');
            },
            itemCount: thingBoughtController.thingBought.length,
          );
        }),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          openDialog();
        },
        child: const Text("Add"),
      ),
    );
  }

  void openDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Dialog"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: costController,
              decoration: const InputDecoration(hintText: 'Cost'),
            ),
            TextFormField(
              controller: thingController,
              decoration: const InputDecoration(hintText: 'Tittle'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back(result: [
                  costController.text,
                  thingController.text,
                ]);
              },
              child: const Text('Confirm'))
        ],
      ),
    ).then((result) async {
      costController.clear();
      thingController.clear();
      if (result != null) {
        String cost = result[0];
        String nameThing = result[1];
        await thingBoughtController.addThingBought(
          nameThing: nameThing,
          money: cost,
        );
      }
    });
  }

  Widget boughtItem({
    required String name,
    required String cost,
    required String itemID,
  }) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/money.png',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(cost),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      thingBoughtController.deleteThingBought(itemID);
                    },
                    icon: const Icon(Icons.clear_rounded),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
