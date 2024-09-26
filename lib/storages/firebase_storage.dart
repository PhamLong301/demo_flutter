import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageUtil {
  static final FirebaseStorageUtil _singleton = FirebaseStorageUtil._internal();

  factory FirebaseStorageUtil() {
    return _singleton;
  }

  FirebaseStorageUtil._internal();

  final storage = FirebaseFirestore.instance;

  Future<bool> addThingsBought({
    required String nameThing,
    required String money,
  }) async {
    bool result = false;
    try{
      await storage.collection('ThingsBought').doc(const Uuid().v1()).set({
        'thingName' : nameThing,
        'cost' : money
      });
      result = true;
    }on FirebaseException catch(e){
      result = false;
      print("Failed with error '${e.code}: '${e.message}'");
    }

    return result;
  }
}
