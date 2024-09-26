import 'package:demo_flutter/storages/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ThingBoughtUI extends StatefulWidget {
  const ThingBoughtUI({super.key});

  @override
  State<ThingBoughtUI> createState() => _ThingBoughtUIState();
}

class _ThingBoughtUIState extends State<ThingBoughtUI> {
  FirebaseStorageUtil _firebaseStorageUtil = FirebaseStorageUtil();
  TextEditingController thingController = TextEditingController();
  TextEditingController costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thing Bougth'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return NoteItem();
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.dialog(AddDialog());
        },
        child: const Text("Add"),
      ),
    );
  }

  AlertDialog AddDialog() {
    return AlertDialog(
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
          TextButton(
              onPressed: () async {
                await _firebaseStorageUtil.addThingsBought(
                    nameThing: thingController.text,
                    money: costController.text);
              },
              child: const Text('Confirm'))
        ],
      ),
    );
  }

  Padding NoteItem() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/google.png',
              width: 24,
              height: 24,
            ),
          ),
          const Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tittle'),
                Text('Cost'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
